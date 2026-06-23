import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class PaddingWidget extends StatelessWidget {
  const PaddingWidget({super.key});

  static const String _codeSnippet = '''
Padding(
  padding: EdgeInsets.all(20),
  child: Text('Padded Text'),
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'padding-widget',
      previewTab: _PaddingPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _PaddingLearn(),
    );
  }
}

class _PaddingPreview extends StatelessWidget {
  const _PaddingPreview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('EdgeInsets variants:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _buildExample('EdgeInsets.all(20)', () => const EdgeInsets.all(20), 'All sides'),
        _buildExample('EdgeInsets.symmetric(horizontal: 30, vertical: 10)', () => const EdgeInsets.symmetric(horizontal: 30, vertical: 10), 'Symmetric'),
        _buildExample('EdgeInsets.only(left: 40, top: 10)', () => const EdgeInsets.only(left: 40, top: 10), 'Only specific sides'),
        _buildExample('EdgeInsets.fromLTRB(10, 20, 30, 40)', () => const EdgeInsets.fromLTRB(10, 20, 30, 40), 'LTRB'),
      ],
    );
  }

  Widget _buildExample(String label, EdgeInsets Function() padding, String type) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(6),
            color: Colors.grey.shade100,
            child: Text('$type: $label', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue.shade50,
            child: Padding(
              padding: padding(),
              child: Container(
                padding: const EdgeInsets.all(12),
                color: Colors.blue,
                child: const Text('Content', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaddingLearn extends StatelessWidget {
  const _PaddingLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Padding?',
          content:
              'Padding adds empty space around a child widget. It uses EdgeInsetsGeometry to specify the amount of space on each side.',
          properties: [
            PropertyRow('padding', 'EdgeInsetsGeometry', 'Required', 'The amount of space to add'),
            PropertyRow('child', 'Widget', 'Required', 'The child widget to pad'),
          ],
        ),
        const ExplanationCard(
          title: 'EdgeInsets Types',
          content:
              '''- EdgeInsets.all(value): Same padding on all sides
- EdgeInsets.symmetric(horizontal: x, vertical: y): Symmetric
- EdgeInsets.only(left, top, right, bottom): Specific sides
- EdgeInsets.fromLTRB(l, t, r, b): Left, top, right, bottom''',
        ),
      ],
    );
  }
}