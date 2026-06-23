import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/data/widget_data.dart';
import '../../core/models/widget_item.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/menu_item_card.dart';

const _kSearchSuggestions = ['Stack', 'ListView', 'animation', 'button', 'form', 'HTTP'];

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _controller = TextEditingController();
  List<WidgetItem> _results = [];
  bool _hasSearched = false;


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    setState(() {
      _hasSearched = true;
      _results = query.isEmpty ? [] : WidgetData.search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _controller,
            autofocus: true,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Search widgets, e.g. "ListView"…',
              hintStyle: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.6), fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              prefixIcon: Icon(Icons.search,
                  color: Colors.white.withValues(alpha: 0.7), size: 18),
              suffixIcon: _controller.text.isNotEmpty
                  ? IconButton(
                      icon: Icon(Icons.clear,
                          color: Colors.white.withValues(alpha: 0.7), size: 18),
                      onPressed: () {
                        _controller.clear();
                        _onSearch('');
                      },
                    )
                  : null,
            ),
            onChanged: _onSearch,
          ),
        ),
      ),
      body: _hasSearched
          ? _results.isEmpty
              ? _EmptyResults(query: _controller.text)
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _results.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, i) {
                    final item = _results[i];
                    return MenuItemCard(
                      title: item.name,
                      description: item.description,
                      icon: item.icon,
                      difficulty: item.difficulty,
                      categoryName: WidgetData.findCategoryById(item.categoryId)?.name,
                      onTap: () {
                        try { context.push(item.routePath); } catch (_) {}
                      },
                    );
                  },
                )
          : _IdleState(
              isDark: isDark,
              onSuggestionTap: (s) {
                _controller.text = s;
                _onSearch(s);
              },
            ),
    );
  }
}

// ── Idle / empty-input state ──────────────────────────────────────────────────

class _IdleState extends StatelessWidget {
  const _IdleState({required this.isDark, required this.onSuggestionTap});
  final bool isDark;
  final ValueChanged<String> onSuggestionTap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.manage_search_rounded,
                        size: 72,
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFFDDE3F0)),
                    const SizedBox(height: 16),
                    Text(
                      'Search any Flutter widget',
                      style: AppTextStyles.titleLarge(
                          color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${WidgetData.totalCount} demos available across 9 categories',
                      style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Try searching',
                      style: AppTextStyles.labelSmall(
                          color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8)),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: _kSearchSuggestions.map((tag) => GestureDetector(
                        onTap: () => onSuggestionTap(tag),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkCard : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: isDark ? AppColors.darkBorder : const Color(0xFFDDE3F0)),
                          ),
                          child: Text(
                            '"$tag"',
                            style: AppTextStyles.bodySmall(color: AppColors.primary),
                          ),
                        ),
                      )).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── No results state ──────────────────────────────────────────────────────────

class _EmptyResults extends StatelessWidget {
  const _EmptyResults({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off_rounded,
                        size: 64,
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFFDDE3F0)),
                    const SizedBox(height: 16),
                    Text(
                      'No results for "$query"',
                      style: AppTextStyles.titleMedium(
                          color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try a different keyword or browse categories from Home',
                      style: AppTextStyles.bodySmall(
                          color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}