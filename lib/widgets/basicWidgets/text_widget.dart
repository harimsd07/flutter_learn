import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key});

  static const String _codeSnippet = '''
Text(
  'Hello, Flutter!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'text-widget',
      previewTab: _TextPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _TextLearn(),
    );
  }
}

class _TextPreview extends StatelessWidget {
  const _TextPreview();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hello, Flutter!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(height: 24),
          Container(
            width: 200,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'This text demonstrates overflow with a long string! ' * 4,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Custom styled text',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.teal,
              fontStyle: FontStyle.italic,
              letterSpacing: 2,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextLearn extends StatelessWidget {
  const _TextLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is the Text Widget?',
          content:
              'The Text widget displays a string of text with a single style. It is one of the most fundamental widgets in Flutter, used everywhere from buttons to labels.',
          properties: [
            PropertyRow('data', 'String', 'Required', 'The text to display'),
            PropertyRow('style', 'TextStyle?', 'null', 'Font size, weight, color, etc.'),
            PropertyRow('textAlign', 'TextAlign?', 'null', 'Horizontal alignment'),
            PropertyRow('maxLines', 'int?', 'null', 'Maximum number of lines'),
            PropertyRow('overflow', 'TextOverflow?', 'null', 'How to handle overflow'),
          ],
        ),
      ],
    );
  }
}