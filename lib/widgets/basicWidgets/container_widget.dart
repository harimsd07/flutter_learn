import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({super.key});

  static const String _codeSnippet = '''
Container(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 2)),
    ],
  ),
  child: Text('Flutter Box'),
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'container-widget',
      previewTab: _ContainerPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _ContainerLearn(),
    );
  }
}

class _ContainerPreview extends StatelessWidget {
  const _ContainerPreview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Basic containers with decoration:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue),
          ),
          child: const Text('Container with border and radius'),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.green.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(2, 2)),
            ],
          ),
          child: const Text('Container with shadow'),
        ),
        Container(
          width: double.infinity,
          height: 80,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Text('Gradient container', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}

class _ContainerLearn extends StatelessWidget {
  const _ContainerLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Container?',
          content:
              'Container is a convenience widget that combines common painting, positioning, and sizing. It can have padding, margin, decoration, and constraints.',
          properties: [
            PropertyRow('width / height', 'double?', 'null', 'Fixed dimensions'),
            PropertyRow('padding', 'EdgeInsetsGeometry?', 'null', 'Inner spacing'),
            PropertyRow('margin', 'EdgeInsetsGeometry?', 'null', 'Outer spacing'),
            PropertyRow('decoration', 'Decoration?', 'null', 'Background, border, shadow'),
            PropertyRow('child', 'Widget?', 'null', 'Child widget'),
          ],
        ),
      ],
    );
  }
}