import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/models/widget_category.dart';
import '../../core/models/widget_item.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/services/persistence_service.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.category,
    this.visitedIds = const {},
    this.favoriteIds = const {},
  });

  final WidgetCategory category;
  final Set<String> visitedIds;
  final Set<String> favoriteIds;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accentColor = category.color;
    final paddingTop = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── SliverAppBar with category accent ─────────────────────────────
          SliverAppBar(
            expandedHeight: 125 + paddingTop,
            pinned: true,
            backgroundColor: accentColor,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              category.name,
              style: GoogleFonts.dmSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      accentColor,
                      accentColor.withValues(alpha: 0.75),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
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
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(category.icon, color: Colors.white, size: 14),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${category.items.length} widgets · $_difficultyRange',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Widget List ────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            sliver: SliverList.separated(
              itemCount: category.items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final item = category.items[index];
                return _WidgetListCard(
                  item: item,
                  isVisited: visitedIds.contains(item.id),
                  isFavorite: favoriteIds.contains(item.id),
                  accentColor: accentColor,
                  isDark: isDark,
                  onTap: () => context.push(item.routePath),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String get _difficultyRange {
    final levels = category.items.map((i) => i.difficulty).toSet();
    if (levels.length == 1) return levels.first;
    if (levels.contains('Beginner') && levels.contains('Advanced')) {
      return 'Beginner–Advanced';
    }
    if (levels.contains('Beginner') && levels.contains('Intermediate')) {
      return 'Beginner–Intermediate';
    }
    if (levels.contains('Intermediate') && levels.contains('Advanced')) {
      return 'Intermediate–Advanced';
    }
    return levels.first;
  }
}

// ── Widget List Card ──────────────────────────────────────────────────────────

class _WidgetListCard extends StatelessWidget {
  const _WidgetListCard({
    required this.item,
    required this.isVisited,
    required this.isFavorite,
    required this.accentColor,
    required this.isDark,
    required this.onTap,
  });

  final WidgetItem item;
  final bool isVisited;
  final bool isFavorite;
  final Color accentColor;
  final bool isDark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final diffColor = _diffColor(item.difficulty);

    return Material(
      color: isDark ? AppColors.darkCard : Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border(
              left: BorderSide(
                color: isVisited ? AppColors.beginner : accentColor.withValues(alpha: 0.4),
                width: 3,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(item.icon, color: accentColor, size: 20),
                ),
                const SizedBox(width: 12),
                // Name + description
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.name,
                              style: AppTextStyles.titleMedium(
                                color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E),
                              ),
                            ),
                          ),
                          if (isVisited)
                            const Icon(Icons.check_circle_rounded,
                                size: 16, color: AppColors.beginner),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.description,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.bodySmall(
                            color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Difficulty badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: diffColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    item.difficulty,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: diffColor,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ValueListenableBuilder<Set<String>>(
                  valueListenable: PersistenceService.favoritesNotifier,
                  builder: (context, favorites, _) {
                    final isFav = favorites.contains(item.id);
                    return IconButton(
                      icon: Icon(
                        isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                        color: isFav ? Colors.redAccent : (isDark ? AppColors.darkTextSecondary : const Color(0xFFC5CBE0)),
                        size: 20,
                      ),
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        final service = await PersistenceService.init();
                        await service.toggleFavorite(item.id);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _diffColor(String d) {
    switch (d.toLowerCase()) {
      case 'beginner': return AppColors.beginner;
      case 'intermediate': return AppColors.intermediate;
      case 'advanced': return AppColors.advanced;
      default: return Colors.grey;
    }
  }
}
