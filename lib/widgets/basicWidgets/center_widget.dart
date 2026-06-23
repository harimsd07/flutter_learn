import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class CenterWidget extends StatelessWidget {
  const CenterWidget({super.key});

  static const String _codeSnippet = '''
Center(
  child: Text('Hello, Flutter!'),
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'center-widget',
      previewTab: _CenterPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _CenterLearn(),
    );
  }
}

class _CenterPreview extends StatelessWidget {
  const _CenterPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            color: Colors.grey.shade200,
            child: const Center(
              child: Text(
                'Centered text',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          color: Colors.blue.shade50,
          child: const Text('Above: Center makes child centered in parent',
              textAlign: TextAlign.center),
        ),
        Expanded(
          flex: 1,
          child: Container(
            width: double.infinity,
            color: Colors.orange.shade50,
            child: const Text('Not centered text (compare)'),
          ),
        ),
      ],
    );
  }
}

class _CenterLearn extends StatelessWidget {
  const _CenterLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Center?',
          content:
              'Center is a widget that centers its child within itself. It is equivalent to Align(alignment: Alignment.center). Use it when you need to center a single child within its parent.',
          properties: [
            PropertyRow('child', 'Widget?', 'null', 'The widget to center'),
            PropertyRow('widthFactor', 'double?', 'null', 'Width multiplier'),
            PropertyRow('heightFactor', 'double?', 'null', 'Height multiplier'),
          ],
        ),
      ],
    );
  }
}