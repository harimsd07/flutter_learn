import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.themeMode,
    required this.onThemeChanged,
    this.onResetProgress,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onThemeChanged;
  final VoidCallback? onResetProgress;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.pageBackground,
      appBar: AppBar(
        title: Text('Settings', style: AppTextStyles.titleLarge(color: Colors.white)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Appearance Group ────────────────────────────────────────────────
          _SectionHeader(title: 'Appearance', isDark: isDark),
          const SizedBox(height: 8),
          _SettingsCard(
            isDark: isDark,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Theme',
                    style: AppTextStyles.titleMedium(
                        color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Choose light, dark, or follow your system setting',
                    style: AppTextStyles.bodySmall(
                        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
                  ),
                  const SizedBox(height: 16),
                  // Segmented button
                  SegmentedButton<ThemeMode>(
                    style: SegmentedButton.styleFrom(
                      backgroundColor: isDark ? AppColors.darkBackground : AppColors.pageBackground,
                      selectedBackgroundColor: AppColors.primary,
                      selectedForegroundColor: Colors.white,
                      foregroundColor: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278),
                      side: BorderSide(
                          color: isDark ? AppColors.darkBorder : const Color(0xFFDDE3F0)),
                      textStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    segments: const [
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: Icon(Icons.light_mode_outlined, size: 16),
                        label: Text('Light'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: Icon(Icons.contrast_outlined, size: 16),
                        label: Text('System'),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: Icon(Icons.dark_mode_outlined, size: 16),
                        label: Text('Dark'),
                      ),
                    ],
                    selected: {themeMode},
                    onSelectionChanged: (s) => onThemeChanged(s.first),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // ── Guides & Resources Group ────────────────────────────────────────
          _SectionHeader(title: 'Guides & Resources', isDark: isDark),
          const SizedBox(height: 8),
          _SettingsCard(
            isDark: isDark,
            child: ListTile(
              leading: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.menu_book_outlined,
                    color: AppColors.primary, size: 18),
              ),
              title: Text(
                'Flutter Setup Guide',
                style: AppTextStyles.titleMedium(
                    color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E)),
              ),
              subtitle: Text(
                'Setup Flutter on Windows, macOS, and Linux',
                style: AppTextStyles.bodySmall(
                    color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
              onTap: () => context.push('/guides/setup'),
            ),
          ),

          const SizedBox(height: 20),

          // ── About Group ─────────────────────────────────────────────────────
          _SectionHeader(title: 'About', isDark: isDark),
          const SizedBox(height: 8),
          _SettingsCard(
            isDark: isDark,
            child: Column(
              children: [
                _InfoRow(
                  icon: Icons.school_outlined,
                  label: 'FlutterLearn',
                  value: 'v1.1.0',
                  isDark: isDark,
                ),
                Divider(height: 1,
                    color: isDark ? AppColors.darkBorder : const Color(0xFFEEF2FF)),
                _InfoRow(
                  icon: Icons.widgets_outlined,
                  label: 'Widget Demos',
                  value: '50 available',
                  isDark: isDark,
                ),
                Divider(height: 1,
                    color: isDark ? AppColors.darkBorder : const Color(0xFFEEF2FF)),
                _InfoRow(
                  icon: Icons.category_outlined,
                  label: 'Categories',
                  value: '9 categories',
                  isDark: isDark,
                ),
              ],
            ),
          ),

          if (onResetProgress != null) ...[
            const SizedBox(height: 20),
            _SectionHeader(title: 'Data', isDark: isDark),
            const SizedBox(height: 8),
            _SettingsCard(
              isDark: isDark,
              child: ListTile(
                leading: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.advanced.withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.restart_alt_rounded,
                      color: AppColors.advanced, size: 18),
                ),
                title: Text(
                  'Reset Progress',
                  style: AppTextStyles.titleMedium(color: AppColors.advanced),
                ),
                subtitle: Text(
                  'Clear all visited widget history',
                  style: AppTextStyles.bodySmall(
                      color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278)),
                ),
                onTap: () => _showResetDialog(context),
              ),
            ),
          ],

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset Progress?'),
        content: const Text(
            'This will clear all your learning progress. This cannot be undone.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.advanced),
            onPressed: () {
              onResetProgress!();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Progress reset!')),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.isDark});
  final String title;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: isDark ? AppColors.darkTextSecondary : const Color(0xFF94A3B8),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.child, required this.isDark});
  final Widget child;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: isDark ? AppColors.darkBorder : const Color(0x12000000)),
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(
      {required this.icon, required this.label, required this.value, required this.isDark});
  final IconData icon;
  final String label;
  final String value;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 18,
              color: isDark ? AppColors.darkTextSecondary : AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: AppTextStyles.bodyMedium(
                    color: isDark ? AppColors.darkTextPrimary : const Color(0xFF1A1A2E))),
          ),
          Text(value,
              style: AppTextStyles.bodySmall(
                  color: isDark ? AppColors.darkTextSecondary : const Color(0xFF5C6278))),
        ],
      ),
    );
  }
}