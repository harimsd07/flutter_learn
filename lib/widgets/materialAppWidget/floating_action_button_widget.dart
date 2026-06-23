import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class FloatingActionButtonWidget extends StatefulWidget {
  const FloatingActionButtonWidget({super.key});

  @override
  State<FloatingActionButtonWidget> createState() => _FloatingActionButtonWidgetState();
}

class _FloatingActionButtonWidgetState extends State<FloatingActionButtonWidget> {
  int _counter = 0;

  static const String _codeSnippet = '''
FloatingActionButton(
  onPressed: () {
    setState(() => _counter++);
  },
  backgroundColor: Colors.blue,
  child: Icon(Icons.add),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'fab-widget',
      previewTab: _buildPreview(context),
      codeSnippet: _codeSnippet,
      learnTab: const _FabLearn(),
    );
  }

  Widget _buildPreview(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Button pressed $_counter times',
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Try the FABs at the bottom!',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'reset',
            onPressed: () => setState(() => _counter = 0),
            tooltip: 'Reset',
            backgroundColor: Colors.red,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () => setState(() => _counter++),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

class _FabLearn extends StatelessWidget {
  const _FabLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is FloatingActionButton?',
          content:
              'A FloatingActionButton (FAB) is a circular button that floats above the content to promote a primary action. It is typically placed in a Scaffold\'s floatingActionButton slot.',
          properties: [
            PropertyRow('onPressed', 'VoidCallback?', 'null', 'Called when tapped'),
            PropertyRow('child', 'Widget?', 'null', 'Icon or other widget'),
            PropertyRow('tooltip', 'String?', 'null', 'Accessibility label'),
            PropertyRow('backgroundColor', 'Color?', 'null', 'Background color'),
            PropertyRow('mini', 'bool', 'false', 'Smaller size variant'),
          ],
        ),
        const ExplanationCard(
          title: 'FAB Variants',
          content:
            '- FloatingActionButton: Standard size\n- FloatingActionButton.small: Reduced size\n- FloatingActionButton.large: Larger size\n- FloatingActionButton.extended: With label text and icon',
        ),
      ],
    );
  }
}