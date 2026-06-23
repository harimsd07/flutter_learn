import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class AnimatedOpacityDemo extends StatefulWidget {
  const AnimatedOpacityDemo({super.key});

  @override
  State<AnimatedOpacityDemo> createState() => _AnimatedOpacityDemoState();
}

class _AnimatedOpacityDemoState extends State<AnimatedOpacityDemo> {
  bool _visible = true;

  static const String _codeSnippet = '''
AnimatedOpacity(
  opacity: _visible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 500),
  child: Container(
    width: 150, height: 150,
    color: Colors.blue,
    child: Center(child: Text('Fade Me')),
  ),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'animatedopacity-widget',
      previewTab: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                width: 150, height: 150,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text('Fade Me', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => setState(() => _visible = !_visible),
              child: Text(_visible ? 'Fade Out' : 'Fade In'),
            ),
          ],
        ),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _AnimatedOpacityLearn(),
    );
  }
}

class _AnimatedOpacityLearn extends StatelessWidget {
  const _AnimatedOpacityLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is AnimatedOpacity?',
          content: 'AnimatedOpacity animates changes in opacity. Use it for fade-in/fade-out effects without needing an AnimationController.',
          properties: [
            PropertyRow('opacity', 'double', 'Required', 'Target opacity (0.0-1.0)'),
            PropertyRow('duration', 'Duration', 'Required', 'Animation duration'),
            PropertyRow('curve', 'Curve', 'Curves.linear', 'Animation easing'),
            PropertyRow('child', 'Widget?', 'null', 'The widget to fade'),
          ],
        ),
      ],
    );
  }
}