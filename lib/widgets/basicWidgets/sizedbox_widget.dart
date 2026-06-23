import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class SizedboxWidget extends StatelessWidget {
  const SizedboxWidget({super.key});

  static const String _codeSnippet = '''
SizedBox(height: 50), // Vertical spacing

SizedBox(height: 100, width: 100, child: ColoredBox(color: Colors.blue))''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'sizedbox-widget',
      previewTab: _SizedBoxPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _SizedBoxLearn(),
    );
  }
}

class _SizedBoxPreview extends StatelessWidget {
  const _SizedBoxPreview();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Vertical spacing:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Text above'),
            const SizedBox(height: 50),
            const Text('Text below (after SizedBox(height: 50))'),
            const Divider(height: 32),
            const Text('Horizontal spacing:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 50, height: 50, color: Colors.red),
                const SizedBox(width: 20),
                Container(width: 50, height: 50, color: Colors.green),
                const SizedBox(width: 20),
                Container(width: 50, height: 50, color: Colors.blue),
              ],
            ),
            const Divider(height: 32),
            const Text('Fixed size box:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const SizedBox(
              height: 80,
              width: 120,
              child: Card(
                color: Colors.blue,
                child: Center(
                  child: Text('100x80', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SizedBoxLearn extends StatelessWidget {
  const _SizedBoxLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is SizedBox?',
          content:
              'SizedBox is a box with a specified size. When used without a child, it acts as spacing. With a child, it constrains the child to the given dimensions.',
          properties: [
            PropertyRow('width', 'double?', 'null', 'Fixed width'),
            PropertyRow('height', 'double?', 'null', 'Fixed height'),
            PropertyRow('child', 'Widget?', 'null', 'Optional child widget'),
          ],
        ),
        const ExplanationCard(
          title: 'Special Constructors',
          content:
              '- SizedBox.expand(): Fills all available space\n- SizedBox.shrink(): Takes zero space\n- SizedBox.square(): Creates a square box',
        ),
      ],
    );
  }
}