import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class MediaQueryDemo extends StatelessWidget {
  const MediaQueryDemo({super.key});

  static const String _codeSnippet = '''
@override
Widget build(BuildContext context) {
  final mediaQuery = MediaQuery.of(context);
  final screenWidth = mediaQuery.size.width;
  final screenHeight = mediaQuery.size.height;
  final orientation = mediaQuery.orientation;

  return Container(
    width: screenWidth > 600 ? 500 : double.infinity,
    color: orientation == Orientation.portrait 
        ? Colors.blue 
        : Colors.green,
  );
}''';

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'mediaquery-demo',
      scrollablePreview: false,
      previewTab: _MediaQueryPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _MediaQueryLearn(),
    );
  }
}

class _MediaQueryPreview extends StatelessWidget {
  const _MediaQueryPreview();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    final size = mediaQuery.size;
    final orientation = mediaQuery.orientation;
    final isLandscape = orientation == Orientation.landscape;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('MediaQuery Live Inspector', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'Queries current device screen size, padding, and display features in real time. Try resizing the application window to see values update.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        GridView.count(
          crossAxisCount: isLandscape ? 4 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            _buildStatCard('Screen Width', '${size.width.toStringAsFixed(1)} dp', Icons.swap_horiz, theme),
            _buildStatCard('Screen Height', '${size.height.toStringAsFixed(1)} dp', Icons.swap_vert, theme),
            _buildStatCard('Orientation', orientation.toString().split('.').last.toUpperCase(), isLandscape ? Icons.screen_rotation : Icons.screen_lock_portrait, theme),
            _buildStatCard('Pixel Ratio', '${mediaQuery.devicePixelRatio}', Icons.aspect_ratio, theme),
            _buildStatCard('Text Scale', mediaQuery.textScaler.scale(1.0).toStringAsFixed(1), Icons.text_fields_rounded, theme),
            _buildStatCard('Platform Theme', mediaQuery.platformBrightness == Brightness.dark ? 'DARK' : 'LIGHT', Icons.brightness_6, theme),
          ],
        ),
        const SizedBox(height: 24),
        Text('Dynamic Layout Response', style: theme.textTheme.titleMedium),
        const SizedBox(height: 12),
        Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isLandscape 
                  ? [Colors.teal.shade300, Colors.teal.shade600] 
                  : [Colors.indigo.shade300, Colors.indigo.shade600],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isLandscape ? Icons.landscape_rounded : Icons.portrait_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      isLandscape 
                          ? 'Landscape Mode Active (Teal)' 
                          : 'Portrait Mode Active (Indigo)',
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, ThemeData theme) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 24, color: theme.colorScheme.primary),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class _MediaQueryLearn extends StatelessWidget {
  const _MediaQueryLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExplanationCard(
          title: 'What is MediaQuery?',
          content: 'MediaQuery provides information about the current screen size, orientation, and user settings (like dark mode preference, text scale factor, and safe area paddings). Using `MediaQuery.of(context)` registers the widget to rebuild automatically whenever the screen configuration changes.',
          properties: [
            PropertyRow('size', 'Size', 'Required', 'The width and height of the screen in logical pixels'),
            PropertyRow('orientation', 'Orientation', 'Required', 'Device direction: Orientation.portrait or Orientation.landscape'),
            PropertyRow('devicePixelRatio', 'double', 'Required', 'Number of physical pixels for each logical pixel'),
            PropertyRow('padding', 'EdgeInsets', 'Required', 'System safe area padding (e.g. notch, status bars)'),
          ],
        ),
        ExplanationCard(
          title: 'Responsive Rules of Thumb',
          content: '• Build fluid layouts that adapt using percentages or flex widgets.\n• Avoid hardcoding static widths. Use `MediaQuery.of(context).size.width` to set conditional constraints.\n• Always design layouts to work cleanly in both landscape and portrait orientations.',
          properties: [],
        ),
      ],
    );
  }
}
