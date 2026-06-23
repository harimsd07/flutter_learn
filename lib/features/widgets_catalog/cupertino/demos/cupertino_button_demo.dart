import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class CupertinoButtonDemo extends StatelessWidget {
  const CupertinoButtonDemo({super.key});

  static const String _codeSnippet = '''
CupertinoButton(
  onPressed: () {},
  child: Text('Default'),
)

CupertinoButton.filled(
  onPressed: () {},
  child: Text('Filled'),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'cupertino-button-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('CupertinoButton variants:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Center(
            child: CupertinoButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Default CupertinoButton pressed!')),
                );
              },
              child: const Text('Default Button'),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: CupertinoButton.filled(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Filled CupertinoButton pressed!')),
                );
              },
              child: const Text('Filled Button'),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Size variants:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text('Small', style: TextStyle(fontSize: 12)),
              ),
              CupertinoButton(
                onPressed: () {},
                child: const Text('Default'),
              ),
              CupertinoButton(
                onPressed: () {},
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: const Text('Large', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _CupertinoButtonLearn(),
    );
  }
}

class _CupertinoButtonLearn extends StatelessWidget {
  const _CupertinoButtonLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is CupertinoButton?',
          content: 'CupertinoButton is an iOS-style button. It has a subtle opacity change on press instead of Material ripple effects.',
          properties: [
            PropertyRow('child', 'Widget', 'Required', 'Button label/content'),
            PropertyRow('onPressed', 'VoidCallback?', 'null', 'Tap handler'),
            PropertyRow('color', 'Color?', 'null', 'Background color'),
            PropertyRow('disabledColor', 'Color?', 'null', 'Color when disabled'),
            PropertyRow('borderRadius', 'BorderRadius', '8', 'Corner radius'),
            PropertyRow('sizeStyle', 'CupertinoButtonSize', 'medium', 'Size variant'),
          ],
        ),
      ],
    );
  }
}