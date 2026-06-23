import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class ExpandedWidget extends StatelessWidget {
  const ExpandedWidget({super.key});

  static const String _codeSnippet = '''
Column(
  children: [
    Expanded(
      flex: 2,
      child: Container(color: Colors.red),
    ),
    Expanded(
      flex: 1,
      child: Container(color: Colors.blue),
    ),
  ],
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'expanded-widget',
      scrollablePreview: false,
      previewTab: _ExpandedPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _ExpandedLearn(),
    );
  }
}

class _ExpandedPreview extends StatelessWidget {
  const _ExpandedPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.red.shade200,
            child: const Center(child: Text('flex: 2', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue.shade200,
            child: const Center(child: Text('flex: 1', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.green.shade200,
            child: const Center(child: Text('flex: 3', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          ),
        ),
      ],
    );
  }
}

class _ExpandedLearn extends StatelessWidget {
  const _ExpandedLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Expanded?',
          content:
              'Expanded expands a child of a Row or Column to fill the available space along the main axis. The flex property determines how much space it takes relative to other Expanded siblings.',
          properties: [
            PropertyRow('flex', 'int', '1', 'Flex factor relative to siblings'),
            PropertyRow('child', 'Widget', 'Required', 'The widget to expand'),
          ],
        ),
        const ExplanationCard(
          title: 'Important Notes',
          content:
              '- Expanded only works inside Row, Column, or Flex\n- The child should NOT have its own height/width constraints — Expanded overrides them\n- Use flex to proportionally divide space between siblings',
        ),
      ],
    );
  }
}