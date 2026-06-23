import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class AnimatedContainerDemo extends StatefulWidget {
  const AnimatedContainerDemo({super.key});

  @override
  State<AnimatedContainerDemo> createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  bool _expanded = false;

  static const String _codeSnippet = '''
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  curve: Curves.easeInOut,
  width: _expanded ? 200 : 100,
  height: _expanded ? 200 : 100,
  decoration: BoxDecoration(
    color: _expanded ? Colors.blue : Colors.red,
    borderRadius: BorderRadius.circular(_expanded ? 32 : 8),
  ),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'animatedcontainer-widget',
      previewTab: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: _expanded ? 200 : 100,
              height: _expanded ? 200 : 100,
              decoration: BoxDecoration(
                color: _expanded ? Colors.blue : Colors.red,
                borderRadius: BorderRadius.circular(_expanded ? 32 : 8),
                boxShadow: [
                  BoxShadow(
                    color: (_expanded ? Colors.blue : Colors.red).withValues(alpha: 0.4),
                    blurRadius: _expanded ? 16 : 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  _expanded ? 'Expanded' : 'Small',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => setState(() => _expanded = !_expanded),
              child: Text(_expanded ? 'Shrink' : 'Expand'),
            ),
          ],
        ),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _AnimatedContainerLearn(),
    );
  }
}

class _AnimatedContainerLearn extends StatelessWidget {
  const _AnimatedContainerLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is AnimatedContainer?',
          content: 'AnimatedContainer automatically animates changes to its properties (size, color, decoration, etc). It is an implicit animation — Flutter handles the animation for you.',
          properties: [
            PropertyRow('duration', 'Duration', 'Required', 'Animation duration'),
            PropertyRow('curve', 'Curve', 'Curves.linear', 'Animation easing'),
            PropertyRow('width', 'double?', 'null', 'Animated width'),
            PropertyRow('height', 'double?', 'null', 'Animated height'),
            PropertyRow('decoration', 'Decoration?', 'null', 'Animated decoration'),
            PropertyRow('padding', 'EdgeInsetsGeometry?', 'null', 'Animated padding'),
          ],
        ),
        const ExplanationCard(
          title: 'Implicit vs Explicit Animations',
          content:
            '- Implicit: You set target values, Flutter animates. Easy!\n  (AnimatedContainer, AnimatedOpacity, etc.)\n- Explicit: You control the AnimationController yourself.\n  (More control, more code)',
        ),
      ],
    );
  }
}