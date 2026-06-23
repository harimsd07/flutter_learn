import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class InkWellDemo extends StatelessWidget {
  const InkWellDemo({super.key});

  static const String _codeSnippet = '''
InkWell(
  onTap: () {},
  borderRadius: BorderRadius.circular(12),
  child: Container(
    padding: EdgeInsets.all(16),
    child: Text('Tap for ripple effect'),
  ),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'inkwell-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('InkWell provides Material ripple feedback:',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('InkWell tapped!')),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  children: [
                    Icon(Icons.touch_app, size: 32),
                    SizedBox(width: 16),
                    Expanded(child: Text('Tap here for ripple effect\nUses InkWell', style: TextStyle(fontSize: 16))),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {},
              onLongPress: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Long pressed!')),
                );
              },
              onDoubleTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Double tapped!')),
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.all(24),
                child: Row(
                  children: [
                    Icon(Icons.back_hand, size: 32),
                    SizedBox(width: 16),
                    Expanded(child: Text('Tap, double tap, or long press\nThis InkWell supports multiple gestures')),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _InkWellLearn(),
    );
  }
}

class _InkWellLearn extends StatelessWidget {
  const _InkWellLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is InkWell?',
          content: 'InkWell is an area of Material that responds to touch with a ripple animation. It provides visual feedback following Material Design guidelines.',
          properties: [
            PropertyRow('onTap', 'GestureTapCallback?', 'null', 'Single tap'),
            PropertyRow('onDoubleTap', 'GestureTapCallback?', 'null', 'Double tap'),
            PropertyRow('onLongPress', 'GestureLongPressCallback?', 'null', 'Long press'),
            PropertyRow('borderRadius', 'BorderRadius?', 'null', 'Clip ripple to shape'),
            PropertyRow('splashColor', 'Color?', 'null', 'Ripple color'),
            PropertyRow('highlightColor', 'Color?', 'null', 'Highlight color'),
          ],
        ),
      ],
    );
  }
}