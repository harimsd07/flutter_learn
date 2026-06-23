import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/data/widget_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key, required this.visitedIds});

  final Set<String> visitedIds;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = WidgetData.totalCount;
    final visited = visitedIds.length;
    final pct = total > 0 ? visited / total : 0.0;
    final percentage = (pct * 100).round();

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.pageBackground,
      appBar: AppBar(
        title: Text('My Progress', style: AppTextStyles.titleLarge(color: Colors.white)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.go('/'),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Summary Ring Card ──────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: isDark ? AppColors.darkBorder : const Color(0x12000000)),
              boxShadow: isDark ? null : [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Your Learning Journey',
                  style: AppTextStyles.titleLarge(
                      color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E)),
                ),
                const SizedBox(height: 24),
                // Ring chart
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CircularProgressIndicator(
                        value: pct,
                        strokeWidth: 12,
                        strokeCap: StrokeCap.round,
                        backgroundColor: isDark ? AppColors.darkBorder : const Color(0xFFE3F2FD),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '$percentage%',
                              style: GoogleFonts.dmSans(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: isDark ? AppColors.darkTextPrimary : AppColors.primary,
                              ),
                            ),
                            Text(
                              'complete',
                              style: AppTextStyles.bodySmall(
                                  color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '$visited of $total widgets explored',
                  style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
                ),
                const SizedBox(height: 16),
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatPill(label: 'Explored', value: '$visited',
                        color: AppColors.primary, isDark: isDark),
                    _StatPill(label: 'Remaining', value: '${total - visited}',
                        color: AppColors.intermediate, isDark: isDark),
                    _StatPill(label: 'Total', value: '$total',
                        color: AppColors.beginner, isDark: isDark),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Text(
            'Category Breakdown',
            style: AppTextStyles.titleMedium(
                color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E)),
          ),
          const SizedBox(height: 12),

          // ── Per-category rows ──────────────────────────────────────────────
          ...WidgetData.categories.map((cat) {
            final catTotal = cat.items.length;
            final catVisited = cat.items.where((i) => visitedIds.contains(i.id)).length;
            final catPct = catTotal > 0 ? catVisited / catTotal : 0.0;
            final done = catVisited == catTotal;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: isDark ? AppColors.darkBorder : const Color(0x12000000)),
                ),
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: cat.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(cat.icon, color: cat.color, size: 18),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            cat.name,
                            style: AppTextStyles.titleMedium(
                                color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E)),
                          ),
                        ),
                        if (done)
                          const Icon(Icons.check_circle_rounded,
                              size: 18, color: AppColors.beginner),
                        const SizedBox(width: 6),
                        Text(
                          '$catVisited/$catTotal',
                          style: AppTextStyles.bodySmall(
                              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: catPct,
                        minHeight: 5,
                        backgroundColor:
                            isDark ? AppColors.darkBorder : const Color(0xFFEEF2FF),
                        valueColor: AlwaysStoppedAnimation<Color>(cat.color),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.label, required this.value,
      required this.color, required this.isDark});
  final String label;
  final String value;
  final Color color;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.dmSans(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall(
              color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8)),
        ),
      ],
    );
  }
}