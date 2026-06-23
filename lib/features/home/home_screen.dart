import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/data/widget_data.dart';
import '../../core/models/widget_category.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets_catalog/category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.favoriteIds = const {},
    this.visitedIds = const {},
    this.onToggleFavorite,
  });

  final Set<String> favoriteIds;
  final Set<String> visitedIds;
  final void Function(String id)? onToggleFavorite;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _filterDifficulty = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = WidgetData.totalCount;
    final visited = widget.visitedIds.length;

    // Last visited widget for Continue card
    final lastVisited = _lastVisitedItem();

    // Filter categories by difficulty
    final filtered = _filteredCategories();

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : AppColors.pageBackground,
      body: CustomScrollView(
        slivers: [
          // ── AppBar ─────────────────────────────────────────────────────────
          _HomeAppBar(
            isDark: isDark,
            total: total,
            visited: visited,
            onSettingsTap: () => context.push('/settings'),
            onSearchTap: () => context.push('/search'),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Progress Strip ────────────────────────────────────────
                _ProgressStrip(visited: visited, total: total, isDark: isDark),

                // ── Continue Card ─────────────────────────────────────────
                if (lastVisited != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: _ContinueCard(
                      widgetName: lastVisited.name,
                      isDark: isDark,
                      onTap: () => context.push(lastVisited.routePath),
                    ),
                  ),

                // ── Filter Chips ──────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
                  child: Text(
                    'Browse Categories',
                    style: AppTextStyles.titleMedium(
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : const Color(0xFF1A1A2E),
                    ),
                  ),
                ),
                _FilterChipRow(
                  selected: _filterDifficulty,
                  onSelect: (v) => setState(() => _filterDifficulty = v),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // ── Category Grid ───────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final cat = filtered[index];
                  final catVisited = cat.items
                      .where((i) => widget.visitedIds.contains(i.id))
                      .length;
                  final allDone = catVisited == cat.items.length;
                  return _CategoryCard(
                    category: cat,
                    visitedCount: catVisited,
                    allDone: allDone,
                    isDark: isDark,
                    onTap: () => _openCategory(context, cat),
                  );
                },
                childCount: filtered.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.80,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _AppBottomNav(visitedCount: visited),
    );
  }

  void _openCategory(BuildContext context, WidgetCategory cat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryScreen(
          category: cat,
          visitedIds: widget.visitedIds,
          favoriteIds: widget.favoriteIds,
        ),
      ),
    );
  }

  dynamic _lastVisitedItem() {
    if (widget.visitedIds.isEmpty) return null;
    for (final cat in WidgetData.categories) {
      for (final item in cat.items.reversed) {
        if (widget.visitedIds.contains(item.id)) return item;
      }
    }
    return null;
  }

  List<WidgetCategory> _filteredCategories() {
    if (_filterDifficulty == 'All') return WidgetData.categories;
    return WidgetData.categories.where((cat) {
      return cat.items.any((i) =>
          i.difficulty.toLowerCase() == _filterDifficulty.toLowerCase());
    }).toList();
  }
}

// ── Custom App Bar ────────────────────────────────────────────────────────────

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({
    required this.isDark,
    required this.total,
    required this.visited,
    required this.onSettingsTap,
    required this.onSearchTap,
  });

  final bool isDark;
  final int total;
  final int visited;
  final VoidCallback onSettingsTap;
  final VoidCallback onSearchTap;

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top;
    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: 135 + paddingTop,
      backgroundColor: AppColors.primary,
      surfaceTintColor: Colors.transparent,
      title: Text(
        'FlutterLearn',
        style: GoogleFonts.dmSans(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white70),
          onPressed: onSettingsTap,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColors.primary,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 56,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '$total widgets · ${WidgetData.categories.length} categories',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: onSearchTap,
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Icon(Icons.search, color: Colors.white.withValues(alpha: 0.7), size: 18),
                      const SizedBox(width: 8),
                      Text(
                        'Search widgets, e.g. "ListView"',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.6),
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
    );
  }
}

// ── Progress Strip ────────────────────────────────────────────────────────────

class _ProgressStrip extends StatelessWidget {
  const _ProgressStrip(
      {required this.visited, required this.total, required this.isDark});

  final int visited;
  final int total;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? visited / total : 0.0;
    return Container(
      color: AppColors.primarySurface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Text(
            '$visited / $total completed',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: pct,
                minHeight: 4,
                backgroundColor: Colors.white.withValues(alpha: 0.2),
                valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.runButton),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${(pct * 100).round()}%',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.runButton,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Continue Card ─────────────────────────────────────────────────────────────

class _ContinueCard extends StatelessWidget {
  const _ContinueCard(
      {required this.widgetName, required this.isDark, required this.onTap});

  final String widgetName;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isDark ? AppColors.darkCard : Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: const BorderSide(color: AppColors.runButton, width: 3),
              top: BorderSide(color: isDark ? AppColors.darkBorder : const Color(0x12000000)),
              right: BorderSide(color: isDark ? AppColors.darkBorder : const Color(0x12000000)),
              bottom: BorderSide(color: isDark ? AppColors.darkBorder : const Color(0x12000000)),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.replay_rounded, color: AppColors.runButton, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Continue where you left off',
                      style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278),
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      widgetName,
                      style: AppTextStyles.titleMedium(
                        color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8)),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Filter Chips ──────────────────────────────────────────────────────────────

class _FilterChipRow extends StatelessWidget {
  const _FilterChipRow({required this.selected, required this.onSelect});

  final String selected;
  final ValueChanged<String> onSelect;

  static const _chips = [
    ('All', null),
    ('Beginner', AppColors.beginner),
    ('Intermediate', AppColors.intermediate),
    ('Advanced', AppColors.advanced),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (label, color) = _chips[i];
          final isSelected = selected == label;
          return GestureDetector(
            onTap: () => onSelect(label),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : isDark
                        ? AppColors.darkCard
                        : Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : isDark
                          ? AppColors.darkBorder
                          : const Color(0xFFDDE3F0),
                ),
              ),
              child: Row(
                children: [
                  if (color != null) ...[
                    Container(
                      width: 6,
                      height: 6,
                      decoration:
                          BoxDecoration(color: color, shape: BoxShape.circle),
                    ),
                    const SizedBox(width: 5),
                  ],
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? Colors.white
                          : isDark
                              ? AppColors.darkTextSecondary
                              : const Color(0xFF5C6278),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Category Card ─────────────────────────────────────────────────────────────

class _CategoryCard extends StatefulWidget {
  const _CategoryCard({
    required this.category,
    required this.visitedCount,
    required this.allDone,
    required this.isDark,
    required this.onTap,
  });

  final WidgetCategory category;
  final int visitedCount;
  final bool allDone;
  final bool isDark;
  final VoidCallback onTap;

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final cat = widget.category;
    final accent = cat.color;
    final pct = cat.items.isNotEmpty ? widget.visitedCount / cat.items.length : 0.0;

    // Determine difficulty range label
    final difficulties = cat.items.map((i) => i.difficulty).toSet();
    String diffLabel;
    if (difficulties.length == 1) {
      diffLabel = difficulties.first;
    } else if (difficulties.contains('Advanced')) {
      diffLabel = 'Up to Advanced';
    } else {
      diffLabel = 'Beg–Inter';
    }
    final diffColor = difficulties.contains('Advanced')
        ? AppColors.advanced
        : difficulties.contains('Intermediate')
            ? AppColors.intermediate
            : AppColors.beginner;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: widget.isDark
                  ? AppColors.darkBorder
                  : const Color(0x12000000),
            ),
            boxShadow: widget.isDark
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: icon + completion check
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: accent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(cat.icon, color: accent, size: 20),
                  ),
                  const Spacer(),
                  if (widget.allDone)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: AppColors.beginner,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 12),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              // Category name
              Text(
                cat.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: widget.isDark
                      ? AppColors.darkTextPrimary
                      : const Color(0xFF1A1A2E),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 3),
              // Count
              Text(
                '${cat.items.length} widgets',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: widget.isDark
                      ? AppColors.darkTextSecondary
                      : const Color(0xFF5C6278),
                ),
              ),
              const Spacer(),
              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: pct,
                  minHeight: 3,
                  backgroundColor:
                      widget.isDark ? AppColors.darkBorder : const Color(0xFFEEF2FF),
                  valueColor: AlwaysStoppedAnimation<Color>(accent),
                ),
              ),
              const SizedBox(height: 8),
              // Difficulty badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: diffColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  diffLabel,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: diffColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Bottom Navigation ─────────────────────────────────────────────────────────

class _AppBottomNav extends StatelessWidget {
  const _AppBottomNav({required this.visitedCount});

  final int visitedCount;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: 0,
      height: 60,
      onDestinationSelected: (index) {
        switch (index) {
          case 0: context.go('/');
          case 1: context.push('/search');
          case 2: context.push('/favorites');
          case 3: context.push('/progress');
          case 4: context.push('/settings');
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.search_outlined),
          selectedIcon: Icon(Icons.search),
          label: 'Search',
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline_rounded),
          selectedIcon: Icon(Icons.bookmark_rounded),
          label: 'Saved',
        ),
        NavigationDestination(
          icon: Icon(Icons.bar_chart_outlined),
          selectedIcon: Icon(Icons.bar_chart_rounded),
          label: 'Progress',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings_rounded),
          label: 'Settings',
        ),
      ],
    );
  }
}