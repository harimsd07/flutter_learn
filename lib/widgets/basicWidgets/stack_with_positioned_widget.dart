import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class StackWithPositionedWidget extends StatelessWidget {
  const StackWithPositionedWidget({super.key});

  static const String _codeSnippet = '''
Stack(
  children: [
    Container(color: Colors.red, height: 200, width: 200),
    Positioned(
      top: 20,
      left: 30,
      child: Container(color: Colors.blue, height: 50, width: 50),
    ),
  ],
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'stack-positioned-widget',
      scrollablePreview: false,
      previewTab: _StackPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _StackLearn(),
    );
  }
}

class _StackPreview extends StatelessWidget {
  const _StackPreview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Basic Stack with Positioned:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Center(
          child: Stack(
            children: [
              Container(height: 200, width: 200, color: Colors.red.shade200),
              const Positioned(
                top: 20,
                left: 30,
                child: ColoredBox(color: Colors.blue, child: SizedBox(height: 50, width: 50)),
              ),
              const Positioned(
                bottom: 30,
                right: 20,
                child: ColoredBox(color: Colors.green, child: SizedBox(height: 60, width: 40)),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  color: Colors.purple,
                  child: const Text('Badge', style: TextStyle(color: Colors.white, fontSize: 11)),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text('Stack with alignment:',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(height: 150, width: 150, decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.orange.shade100)),
              const Icon(Icons.star, size: 40, color: Colors.orange),
              const Positioned(
                top: 10,
                right: 10,
                child: Text('★', style: TextStyle(fontSize: 18, color: Colors.red)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StackLearn extends StatelessWidget {
  const _StackLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Stack?',
          content:
              'Stack overlays its children on top of each other. The first child is at the bottom and last child is on top. Use Positioned for precise placement within a Stack.',
          properties: [
            PropertyRow('alignment', 'AlignmentGeometry', 'topStart', 'How non-positioned children are aligned'),
            PropertyRow('fit', 'StackFit', 'loose', 'How non-positioned children are sized'),
            PropertyRow('children', 'List<Widget>', 'Required', 'Widgets to overlay'),
          ],
        ),
        const ExplanationCard(
          title: 'Positioned Properties',
          content:
              '- top, bottom, left, right: Distance from respective edge\n- width, height: Fixed size (use with top+bottom or left+right)\n- Positioned.fill: Fills the entire Stack',
        ),
      ],
    );
  }
}