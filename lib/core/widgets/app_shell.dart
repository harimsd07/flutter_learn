import 'package:flutter/material.dart';

/// AppShell wraps the HomeScreen with a Drawer providing global navigation.
/// It receives state from main.dart and passes it down.
class AppShell extends StatelessWidget {
  final Widget child;
  final ThemeMode themeMode;
  final Set<String> favoriteIds;
  final Set<String> visitedIds;
  final ValueChanged<ThemeMode> onThemeChanged;
  final VoidCallback? onResetProgress;

  const AppShell({
    super.key,
    required this.child,
    required this.themeMode,
    required this.favoriteIds,
    required this.visitedIds,
    required this.onThemeChanged,
    this.onResetProgress,
  });

  @override
  Widget build(BuildContext context) {
    // AppShell is transparent — it just passes the child through.
    // The Drawer and bottom nav are managed inside HomeScreen.
    // This shell is available for future global overlays.
    return child;
  }
}