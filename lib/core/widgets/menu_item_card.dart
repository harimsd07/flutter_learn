import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MenuItemCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;
  final String? difficulty;
  final String? categoryName;
  final bool isVisited;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const MenuItemCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    this.difficulty,
    this.categoryName,
    this.isVisited = false,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final diffColor = _difficultyColor(difficulty);

    return Material(
      color: isDark ? AppColors.darkCard : Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? AppColors.darkBorder : const Color(0x0A000000),
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: 3,
                  child: Container(
                    color: isVisited ? AppColors.beginner : AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                  child: Row(
                    children: [
                      const SizedBox(width: 3),
                      // Icon
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(icon, color: AppColors.primary, size: 20),
                          ),
                          if (isVisited)
                            Positioned(
                              right: -4,
                              bottom: -4,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check_circle_rounded,
                                    size: 16, color: AppColors.beginner),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      // Text column
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (categoryName != null)
                              Text(
                                categoryName!,
                                style: AppTextStyles.labelSmall(
                                    color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8)),
                              ),
                            Text(
                              title,
                              style: AppTextStyles.titleMedium(
                                color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E),
                              ),
                            ),
                            const SizedBox(height: 1),
                            Text(
                              description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.bodySmall(
                                  color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Difficulty badge
                      if (difficulty != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: diffColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            difficulty!,
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: diffColor,
                            ),
                          ),
                        ),
                      // Favorite toggle
                      if (onFavoriteToggle != null)
                        IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                            size: 20,
                            color: isFavorite ? Colors.redAccent : (isDark ? AppColors.darkTextSecondary : const Color(0xFFC5CBE0)),
                          ),
                          onPressed: onFavoriteToggle,
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _difficultyColor(String? d) {
    switch (d?.toLowerCase()) {
      case 'beginner': return AppColors.beginner;
      case 'intermediate': return AppColors.intermediate;
      case 'advanced': return AppColors.advanced;
      default: return Colors.grey;
    }
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: AppTextStyles.titleMedium(
                  color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E))),
          if (subtitle != null) ...[
            const SizedBox(height: 3),
            Text(subtitle!,
                style: AppTextStyles.bodySmall(
                    color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8))),
          ],
        ],
      ),
    );
  }
}