import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/widget_data.dart';
import '../data/widget_examples.dart';
import '../theme/app_colors.dart';
import '../services/persistence_service.dart';

class DemoScaffold extends StatefulWidget {
  final String widgetId;
  final Widget previewTab;
  final String codeSnippet;
  final Widget? learnTab;
  final bool scrollablePreview;
  final List<DemoExample>? examples;

  const DemoScaffold({
    super.key,
    required this.widgetId,
    required this.previewTab,
    required this.codeSnippet,
    this.learnTab,
    this.scrollablePreview = true,
    this.examples,
  });

  @override
  State<DemoScaffold> createState() => _DemoScaffoldState();
}

class _DemoScaffoldState extends State<DemoScaffold> {
  late TextEditingController _codeController;
  // _renderedCode is what the preview shows — only updated on Run
  late String _renderedCode;
  // tracks if user has edited but not yet run
  bool _hasUnsavedChanges = false;

  late List<DemoExample> _allExamples;
  late DemoExample _selectedExample;

  @override
  void initState() {
    super.initState();
    final additional = widgetExamplesRegistry[widget.widgetId] ?? [];
    _allExamples = [
      DemoExample(name: 'Default Example', code: widget.codeSnippet),
      ...additional,
    ];
    _selectedExample = _allExamples.first;

    _codeController = TextEditingController(text: _selectedExample.code);
    _renderedCode = _selectedExample.code;
    _codeController.addListener(() {
      final changed = _codeController.text != _renderedCode;
      if (changed != _hasUnsavedChanges) {
        setState(() => _hasUnsavedChanges = changed);
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _runCode() {
    setState(() {
      _renderedCode = _codeController.text;
      _hasUnsavedChanges = false;
    });
    final tabController = DefaultTabController.maybeOf(context);
    if (tabController != null) {
      tabController.animateTo(0);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.codeEditorSurface,
        content: Row(
          children: [
            const Icon(Icons.check_circle_rounded, color: AppColors.runButton, size: 18),
            const SizedBox(width: 8),
            Text('Preview updated!',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13)),
          ],
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  void _resetCode() {
    setState(() {
      _codeController.text = _selectedExample.code;
      _renderedCode = _selectedExample.code;
      _hasUnsavedChanges = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code reset to original snippet'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleFavoriteFromWidget() async {
    final service = await PersistenceService.init();
    await service.toggleFavorite(widget.widgetId);
    
    if (mounted) {
      final isFav = PersistenceService.favoritesNotifier.value.contains(widget.widgetId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.codeEditorSurface,
          content: Row(
            children: [
              Icon(
                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: isFav ? Colors.redAccent : Colors.white70,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                isFav ? 'Added to favorites!' : 'Removed from favorites',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
              ),
            ],
          ),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = WidgetData.findById(widget.widgetId);
    final title = item?.name ?? widget.widgetId;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final previewHeight = (height * 0.4).clamp(280.0, 320.0);

    Widget buildCodeEditor() {
      return Container(
        color: AppColors.codeEditorSurface,
        child: Column(
          children: [
            // ── Toolbar ──────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: const BoxDecoration(
                color: AppColors.codeEditorHeader,
                border: Border(bottom: BorderSide(color: AppColors.codeEditorBorder)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.code_rounded, color: AppColors.codeClass, size: 16),
                  const SizedBox(width: 8),
                  if (_allExamples.length > 1) ...[
                    SizedBox(
                      width: 100,
                      height: 26,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                          color: AppColors.codeEditorSurface,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppColors.codeEditorBorder,
                            width: 1.0,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<DemoExample>(
                            value: _selectedExample,
                            dropdownColor: AppColors.codeEditorSurface,
                            icon: const Icon(Icons.arrow_drop_down_rounded, color: AppColors.codeBase, size: 18),
                            style: GoogleFonts.jetBrainsMono(
                              color: AppColors.codeBase,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            isExpanded: true,
                            onChanged: (newEx) {
                              if (newEx != null) {
                                setState(() {
                                  _selectedExample = newEx;
                                  _codeController.text = newEx.code;
                                  _renderedCode = newEx.code;
                                  _hasUnsavedChanges = false;
                                });
                              }
                            },
                            items: _allExamples.map((ex) {
                              return DropdownMenuItem<DemoExample>(
                                value: ex,
                                child: Text(
                                  ex.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ] else ...[
                    Text(
                      'editor.dart',
                      style: GoogleFonts.jetBrainsMono(
                        color: AppColors.codeBase,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (_hasUnsavedChanges) ...[
                    const SizedBox(width: 6),
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.intermediate,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                  const Spacer(),
                  // Reset
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.restart_alt_rounded,
                        color: AppColors.codeEditorLineNumbers, size: 18),
                    tooltip: 'Reset code',
                    onPressed: _resetCode,
                  ),
                  const SizedBox(width: 10),
                  // Copy
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.copy_outlined,
                        color: AppColors.codeEditorLineNumbers, size: 17),
                    tooltip: 'Copy code',
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: _codeController.text));
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Code copied to clipboard!'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(width: 10),
                  // ▶ Run button — mint green, semantic signal
                  FilledButton.icon(
                    onPressed: _runCode,
                    icon: const Icon(Icons.play_arrow_rounded, size: 15),
                    label: Text('Run',
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.runButtonText)),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.runButton,
                      foregroundColor: AppColors.runButtonText,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
            // ── Code TextField ────────────────────────────────────────
            Expanded(
              child: SingleChildScrollView(
                child: TextField(
                  controller: _codeController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 12.5,
                    color: AppColors.codeBase,
                    height: 1.7,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  cursorColor: AppColors.runButton,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (width >= 800) {
      // ── Desktop split layout ───────────────────────────────────────────────
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          title: Text(title,
              style: GoogleFonts.dmSans(
                  fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
          actions: [
            ValueListenableBuilder<Set<String>>(
              valueListenable: PersistenceService.favoritesNotifier,
              builder: (context, favorites, _) {
                final isFav = favorites.contains(widget.widgetId);
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: isFav ? Colors.redAccent : Colors.white70,
                  ),
                  tooltip: isFav ? 'Remove from Favorites' : 'Add to Favorites',
                  onPressed: _toggleFavoriteFromWidget,
                );
              },
            ),
            TextButton.icon(
              onPressed: _resetCode,
              icon: const Icon(Icons.restart_alt_rounded,
                  size: 16, color: Colors.white70),
              label: Text('Reset Code',
                  style: GoogleFonts.inter(
                      fontSize: 12, color: Colors.white70)),
            ),
          ],
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left Column: Preview and Learn
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: widget.learnTab != null
                    ? NestedScrollView(
                        headerSliverBuilder: (context, innerBoxIsScrolled) {
                          return [
                            SliverToBoxAdapter(
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.play_circle_outline, color: Colors.blue),
                                          SizedBox(width: 8),
                                          Text(
                                            'Live Preview',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        height: previewHeight,
                                        child: DynamicPreview(
                                          widgetId: widget.widgetId,
                                          code: _renderedCode,
                                          fallback: widget.previewTab,
                                          scrollablePreview: widget.scrollablePreview,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SliverToBoxAdapter(
                              child: SizedBox(height: 16),
                            ),
                          ];
                        },
                        body: widget.learnTab!,
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Icon(Icons.play_circle_outline, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text(
                                        'Live Preview',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 8),
                                  SizedBox(
                                    height: previewHeight,
                                    child: DynamicPreview(
                                      widgetId: widget.widgetId,
                                      code: _renderedCode,
                                      fallback: widget.previewTab,
                                      scrollablePreview: widget.scrollablePreview,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            // Vertical divider
            Container(width: 1, color: Colors.grey.shade300),
            // Right Column: Code Editor
            Expanded(
              flex: 4,
              child: buildCodeEditor(),
            ),
          ],
        ),
      );
    } else {
      // ── Mobile Layout ───────────────────────────────────────────────
      Widget buildPreviewTab() {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: DynamicPreview(
            widgetId: widget.widgetId,
            code: _renderedCode,
            fallback: widget.previewTab,
            scrollablePreview: widget.scrollablePreview,
          ),
        );
      }

      final hasLearnTab = widget.learnTab != null;
      final tabCount = hasLearnTab ? 3 : 2;

      return DefaultTabController(
        length: tabCount,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            title: Text(title,
                style: GoogleFonts.dmSans(
                    fontSize: 17, fontWeight: FontWeight.w600, color: Colors.white)),
            actions: [
              ValueListenableBuilder<Set<String>>(
                valueListenable: PersistenceService.favoritesNotifier,
                builder: (context, favorites, _) {
                  final isFav = favorites.contains(widget.widgetId);
                  return IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                      color: isFav ? Colors.redAccent : Colors.white70,
                    ),
                    tooltip: isFav ? 'Remove from Favorites' : 'Add to Favorites',
                    onPressed: _toggleFavoriteFromWidget,
                  );
                },
              ),
            ],
            bottom: TabBar(
              indicatorColor: AppColors.runButton,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.55),
              dividerColor: Colors.transparent,
              tabs: [
                Tab(
                  icon: const Icon(Icons.play_circle_outline_rounded, size: 18),
                  child: Text('Preview',
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                Tab(
                  icon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.code_rounded, size: 18),
                      if (_hasUnsavedChanges) ...[  
                        const SizedBox(width: 4),
                        Container(
                          width: 6, height: 6,
                          decoration: const BoxDecoration(
                            color: AppColors.intermediate,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ],
                  ),
                  child: Text('Code',
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
                ),
                if (hasLearnTab)
                  Tab(
                    icon: const Icon(Icons.menu_book_outlined, size: 18),
                    child: Text('Learn',
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildPreviewTab(),
              buildCodeEditor(),
              if (hasLearnTab) widget.learnTab!,
            ],
          ),
        ),
      );
    }
  }
}

class _PreviewContainer extends StatelessWidget {
  final Widget child;
  final bool scrollable;
  const _PreviewContainer({required this.child, this.scrollable = true});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F1422) : AppColors.pageBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? AppColors.codeEditorBorder
              : const Color(0xFF90CAF9).withValues(alpha: 0.6),
        ),
      ),
      child: scrollable
          ? LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                        minWidth: constraints.maxWidth,
                      ),
                      child: child,
                    ),
                  ),
                );
              },
            )
          : child,
    );
  }
}

class DynamicPreview extends StatelessWidget {
  final String widgetId;
  final String code;
  final Widget fallback;
  final bool scrollablePreview;

  const DynamicPreview({
    super.key,
    required this.widgetId,
    required this.code,
    required this.fallback,
    this.scrollablePreview = true,
  });

  @override
  Widget build(BuildContext context) {
    try {
      switch (widgetId) {
        case 'text-widget':
          final text = DynamicCodeParser.parseString(code) ?? 'Hello, Flutter!';
          final fontSize = DynamicCodeParser.parseDouble(code, 'fontSize') ?? 24.0;
          final color = DynamicCodeParser.parseColor(code, 'color') ?? Colors.blue;
          final fontWeight = DynamicCodeParser.parseFontWeight(code) ?? FontWeight.bold;
          final textAlign = DynamicCodeParser.parseTextAlign(code) ?? TextAlign.center;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                ),
                textAlign: textAlign,
              ),
            ),
          );

        case 'container-widget':
          final width = DynamicCodeParser.parseDouble(code, 'width') ?? 200.0;
          final height = DynamicCodeParser.parseDouble(code, 'height') ?? 200.0;
          final color = DynamicCodeParser.parseColor(code, 'color') ?? Colors.blue;
          final borderRadius = DynamicCodeParser.parseDouble(code, 'borderRadius') ?? 12.0;
          final padding = DynamicCodeParser.parseDouble(code, 'padding') ?? 16.0;
          final margin = DynamicCodeParser.parseDouble(code, 'margin') ?? 16.0;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Container(
                width: width,
                height: height,
                margin: EdgeInsets.all(margin),
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: const Center(
                  child: Text(
                    'Container Widget',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          );

        case 'center-widget':
          final color = DynamicCodeParser.parseColor(code, 'color') ?? Colors.blue;
          final text = DynamicCodeParser.parseString(code) ?? 'Centered Child';
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Container(
                color: color.withValues(alpha: 0.15),
                width: 250,
                height: 250,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: color,
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );

        case 'padding-widget':
          final paddingValue = DynamicCodeParser.parseDouble(code, 'padding') ?? 24.0;
          final color = DynamicCodeParser.parseColor(code, 'color') ?? Colors.blue;
          final text = DynamicCodeParser.parseString(code) ?? 'Padded Content';
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Container(
                color: Colors.grey.withValues(alpha: 0.1),
                child: Padding(
                  padding: EdgeInsets.all(paddingValue),
                  child: Container(
                    color: color,
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );

        case 'sizedbox-widget':
          final width = DynamicCodeParser.parseDouble(code, 'width') ?? 150.0;
          final height = DynamicCodeParser.parseDouble(code, 'height') ?? 150.0;
          final color = DynamicCodeParser.parseColor(code, 'color') ?? Colors.blue;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: SizedBox(
                width: width,
                height: height,
                child: Container(
                  color: color,
                  child: const Center(
                    child: Text(
                      'SizedBox',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );

        case 'card-widget':
          final elevation = DynamicCodeParser.parseDouble(code, 'elevation') ?? 8.0;
          final color = DynamicCodeParser.parseColor(code, 'color') ?? Colors.white;
          final shadowColor = DynamicCodeParser.parseColor(code, 'shadowColor') ?? Colors.grey;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Card(
                elevation: elevation,
                color: color,
                shadowColor: shadowColor,
                child: const SizedBox(
                  width: 250,
                  height: 150,
                  child: Center(
                    child: Text(
                      'Card Content',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          );

        case 'row-column-widget':
          final hasRow = code.contains('Row(');
          final hasCol = code.contains('Column(');

          String getBlock(String type) {
            final startIndex = code.indexOf('$type(');
            if (startIndex == -1) return '';
            final nextRow = code.indexOf('Row(', startIndex + type.length + 1);
            final nextCol = code.indexOf('Column(', startIndex + type.length + 1);
            int endIndex = code.length;
            if (nextRow != -1 && nextRow < endIndex) endIndex = nextRow;
            if (nextCol != -1 && nextCol < endIndex) endIndex = nextCol;
            return code.substring(startIndex, endIndex);
          }

          final rowBlock = getBlock('Row');
          final colBlock = getBlock('Column');

          final rowStrings = DynamicCodeParser.parseAllStrings(rowBlock);
          final colStrings = DynamicCodeParser.parseAllStrings(colBlock);

          Widget buildItem(String text, Color color) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(text,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
              ),
            );
          }

          Widget? rowWidget;
          if (hasRow) {
            final rowAlign = DynamicCodeParser.parseMainAxisAlignment(rowBlock) ?? MainAxisAlignment.center;
            final children = rowStrings.isEmpty
                ? [buildItem('Apple', const Color(0xFF2196F3)), buildItem('Banana', const Color(0xFF2196F3)), buildItem('Orange', const Color(0xFF2196F3))]
                : rowStrings.map((t) => buildItem(t, const Color(0xFF2196F3))).toList();
            rowWidget = Row(
              mainAxisAlignment: rowAlign,
              children: children,
            );
          }

          Widget? colWidget;
          if (hasCol) {
            final colAlign = DynamicCodeParser.parseMainAxisAlignment(colBlock) ?? MainAxisAlignment.center;
            final children = colStrings.isEmpty
                ? [buildItem('Item 1', const Color(0xFF4CAF50)), buildItem('Item 2', const Color(0xFF4CAF50)), buildItem('Item 3', const Color(0xFF4CAF50))]
                : colStrings.map((t) => buildItem(t, const Color(0xFF4CAF50))).toList();
            colWidget = Column(
              mainAxisAlignment: colAlign,
              children: children,
            );
          }

          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: (hasRow && hasCol)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Row Layout',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          rowWidget!,
                          const SizedBox(height: 16),
                          const Divider(height: 1),
                          const SizedBox(height: 16),
                          const Text('Column Layout',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          colWidget!,
                        ],
                      )
                    : hasRow
                        ? rowWidget!
                        : colWidget ?? const Text('Add Row or Column to preview'),
              ),
            ),
          );

        case 'expanded-widget':
          final flex = DynamicCodeParser.parseInt(code, 'flex') ?? 1;
          final color = DynamicCodeParser.parseColor(code, 'color') ?? Colors.blue;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Row(
                children: [
                  Container(width: 50, height: 50, color: Colors.grey),
                  Expanded(
                    flex: flex,
                    child: Container(
                      height: 50,
                      color: color,
                      child: Center(
                        child: Text(
                          'Flex: $flex',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Container(width: 50, height: 50, color: Colors.grey),
                ],
              ),
            ),
          );

        case 'listtile-widget':
          final title = DynamicCodeParser.parseString(code, 'title') ?? 'Title Text';
          final subtitle = DynamicCodeParser.parseString(code, 'subtitle') ?? 'Subtitle Text';
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.info, color: Colors.blue),
                  title: Text(title),
                  subtitle: Text(subtitle),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                ),
              ),
            ),
          );

        case 'fab-widget':
          final tooltip = DynamicCodeParser.parseString(code, 'tooltip') ?? 'FAB';
          final color = DynamicCodeParser.parseColor(code, 'backgroundColor') ?? Colors.blue;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: color,
                tooltip: tooltip,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          );

        case 'appbar-widget':
          final title = DynamicCodeParser.parseString(code) ?? 'App Bar';
          final color = DynamicCodeParser.parseColor(code, 'backgroundColor') ?? Colors.blue;
          final elevation = DynamicCodeParser.parseDouble(code, 'elevation') ?? 4.0;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Align(
              alignment: Alignment.topCenter,
              child: AppBar(
                title: Text(title),
                backgroundColor: color,
                elevation: elevation,
                automaticallyImplyLeading: false,
              ),
            ),
          );

        case 'textfield-widget':
          final hintText = DynamicCodeParser.parseString(code, 'hintText') ?? 'Enter text...';
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: hintText,
                  ),
                ),
              ),
            ),
          );

        case 'checkbox-widget':
          final activeColor = DynamicCodeParser.parseColor(code, 'activeColor') ?? Colors.blue;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: true,
                    activeColor: activeColor,
                    onChanged: (val) {},
                  ),
                  const Text('Checkbox Active'),
                ],
              ),
            ),
          );

        case 'switch-widget':
          final activeColor = DynamicCodeParser.parseColor(code, 'activeColor') ?? Colors.blue;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Switch(
                    value: true,
                    activeTrackColor: activeColor,
                    onChanged: (val) {},
                  ),
                  const Text('Switch Active'),
                ],
              ),
            ),
          );

        case 'cupertino-button-widget':
          final text = DynamicCodeParser.parseString(code) ?? 'Button';
          final color = DynamicCodeParser.parseColor(code, 'color') ?? Colors.blue;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: CupertinoButton(
                color: color,
                onPressed: () {},
                child: Text(text),
              ),
            ),
          );

        case 'cupertino-switch-widget':
          final activeColor = DynamicCodeParser.parseColor(code, 'activeColor') ?? Colors.blue;
          return _PreviewContainer(
            scrollable: scrollablePreview,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoSwitch(
                    value: true,
                    activeTrackColor: activeColor,
                    onChanged: (val) {},
                  ),
                  const SizedBox(width: 8),
                  const Text('Cupertino Switch'),
                ],
              ),
            ),
          );

        default:
          return _PreviewContainer(scrollable: scrollablePreview, child: fallback);
      }
    } catch (_) {
      return _PreviewContainer(scrollable: scrollablePreview, child: fallback);
    }
  }
}

class DynamicCodeParser {
  static List<String> parseAllStrings(String code) {
    final reg = RegExp(r"['\u0022](.*?)['\u0022]");
    final matches = reg.allMatches(code);
    return matches
        .map((m) => m.group(1) ?? '')
        .where((text) =>
            text.isNotEmpty &&
            !text.contains('Colors') &&
            !text.contains('MainAxisAlignment') &&
            !text.contains('FontWeight') &&
            !text.contains('Alignment') &&
            !text.contains('TextAlign') &&
            !text.contains('flex'))
        .toList();
  }

  static String? parseString(String code, [String key = '']) {
    if (key.isEmpty) {
      final reg = RegExp(r"Text\(\s*['\u0022](.*?)['\u0022]");
      final match = reg.firstMatch(code);
      if (match != null) return match.group(1);

      // Fallback to first string literal
      final list = parseAllStrings(code);
      return list.isNotEmpty ? list.first : null;
    }
    final reg = RegExp(key + r"\s*:\s*['\u0022](.*?)['\u0022]");
    final match = reg.firstMatch(code);
    return match?.group(1);
  }

  static double? parseDouble(String code, String key) {
    final reg = RegExp(key + r'\s*:\s*([\d\.]+)');
    final match = reg.firstMatch(code);
    if (match != null) {
      return double.tryParse(match.group(1) ?? '');
    }
    return null;
  }

  static int? parseInt(String code, String key) {
    final reg = RegExp(key + r'\s*:\s*(\d+)');
    final match = reg.firstMatch(code);
    if (match != null) {
      return int.tryParse(match.group(1) ?? '');
    }
    return null;
  }

  static Color? parseColor(String code, String key) {
    final reg = RegExp(key + r'\s*:\s*Colors\.(\w+)');
    final match = reg.firstMatch(code);
    if (match != null) {
      final colorName = match.group(1);
      switch (colorName) {
        case 'red': return Colors.red;
        case 'blue': return Colors.blue;
        case 'green': return Colors.green;
        case 'amber': return Colors.amber;
        case 'teal': return Colors.teal;
        case 'white': return Colors.white;
        case 'black': return Colors.black;
        case 'orange': return Colors.orange;
        case 'purple': return Colors.purple;
        case 'pink': return Colors.pink;
        case 'grey': return Colors.grey;
        case 'indigo': return Colors.indigo;
        case 'yellow': return Colors.yellow;
        case 'cyan': return Colors.cyan;
        case 'lime': return Colors.lime;
        case 'brown': return Colors.brown;
        case 'deepPurple': return Colors.deepPurple;
        case 'lightBlue': return Colors.lightBlue;
        case 'lightGreen': return Colors.lightGreen;
        case 'deepOrange': return Colors.deepOrange;
        case 'blueGrey': return Colors.blueGrey;
        case 'transparent': return Colors.transparent;
      }
    }
    return null;
  }

  static FontWeight? parseFontWeight(String code) {
    final reg = RegExp(r'fontWeight\s*:\s*FontWeight\.(\w+)');
    final match = reg.firstMatch(code);
    if (match != null) {
      final weight = match.group(1);
      switch (weight) {
        case 'bold': return FontWeight.bold;
        case 'normal': return FontWeight.normal;
        case 'w100': return FontWeight.w100;
        case 'w200': return FontWeight.w200;
        case 'w300': return FontWeight.w300;
        case 'w400': return FontWeight.w400;
        case 'w500': return FontWeight.w500;
        case 'w600': return FontWeight.w600;
        case 'w700': return FontWeight.w700;
        case 'w800': return FontWeight.w800;
        case 'w900': return FontWeight.w900;
      }
    }
    return null;
  }

  static TextAlign? parseTextAlign(String code) {
    final reg = RegExp(r'textAlign\s*:\s*TextAlign\.(\w+)');
    final match = reg.firstMatch(code);
    if (match != null) {
      final align = match.group(1);
      switch (align) {
        case 'center': return TextAlign.center;
        case 'left': return TextAlign.left;
        case 'right': return TextAlign.right;
        case 'justify': return TextAlign.justify;
        case 'start': return TextAlign.start;
        case 'end': return TextAlign.end;
      }
    }
    return null;
  }

  static MainAxisAlignment? parseMainAxisAlignment(String code) {
    final reg = RegExp(r'mainAxisAlignment\s*:\s*MainAxisAlignment\.(\w+)');
    final match = reg.firstMatch(code);
    if (match != null) {
      final val = match.group(1);
      switch (val) {
        case 'center': return MainAxisAlignment.center;
        case 'start': return MainAxisAlignment.start;
        case 'end': return MainAxisAlignment.end;
        case 'spaceBetween': return MainAxisAlignment.spaceBetween;
        case 'spaceEvenly': return MainAxisAlignment.spaceEvenly;
        case 'spaceAround': return MainAxisAlignment.spaceAround;
      }
    }
    return null;
  }
}

class ExplanationCard extends StatelessWidget {
  final String title;
  final String content;
  final List<PropertyRow>? properties;

  const ExplanationCard({
    super.key,
    required this.title,
    required this.content,
    this.properties,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content, style: Theme.of(context).textTheme.bodyMedium),
            if (properties != null && properties!.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Key Properties', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Table(
                border: TableBorder.all(color: Colors.grey.shade300),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(3),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                    children: const [
                      Padding(padding: EdgeInsets.all(8), child: Text('Property', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Padding(padding: EdgeInsets.all(8), child: Text('Type', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Padding(padding: EdgeInsets.all(8), child: Text('Default', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Padding(padding: EdgeInsets.all(8), child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                    ],
                  ),
                  ...properties!.map((p) => TableRow(
                    children: [
                      Padding(padding: const EdgeInsets.all(8), child: Text(p.name, style: const TextStyle(fontSize: 12))),
                      Padding(padding: const EdgeInsets.all(8), child: Text(p.type, style: TextStyle(color: Colors.blue.shade700, fontSize: 12))),
                      Padding(padding: const EdgeInsets.all(8), child: Text(p.defaultValue, style: const TextStyle(fontSize: 12))),
                      Padding(padding: const EdgeInsets.all(8), child: Text(p.description, style: const TextStyle(fontSize: 12))),
                    ],
                  )),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PropertyRow {
  final String name;
  final String type;
  final String defaultValue;
  final String description;

  const PropertyRow(this.name, this.type, this.defaultValue, this.description);
}