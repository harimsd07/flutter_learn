import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class CupertinoNavigationBarDemo extends StatelessWidget {
  const CupertinoNavigationBarDemo({super.key});

  static const String _codeSnippet = '''
CupertinoNavigationBar(
  middle: Text('iOS Profile Settings'),
  trailing: Icon(CupertinoIcons.share),
)''';

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'cupertino-navbar-widget',
      scrollablePreview: false,
      previewTab: _CupertinoNavigationBarPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _CupertinoNavigationBarLearn(),
    );
  }
}

class _CupertinoNavigationBarPreview extends StatelessWidget {
  const _CupertinoNavigationBarPreview();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('CupertinoNavBar'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.back),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Back button pressed')),
            );
          },
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.share),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Share pressed')),
                );
              },
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.line_horizontal_3),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Menu pressed')),
                );
              },
            ),
          ],
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.device_phone_portrait, size: 80, color: CupertinoColors.activeBlue),
                SizedBox(height: 24),
                Text('CupertinoNavigationBar', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text('iOS-style navigation bar with translucent background and blur effect', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CupertinoNavigationBarLearn extends StatelessWidget {
  const _CupertinoNavigationBarLearn();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CupertinoNavigationBar Widget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'An iOS-styled navigation bar. It has a translucent background and is typically placed at the top of a CupertinoPageScaffold.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}