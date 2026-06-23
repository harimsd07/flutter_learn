import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget({super.key});

  static const String _codeSnippet = '''
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Hello from SnackBar!'),
    action: SnackBarAction(
      label: 'UNDO',
      onPressed: () {},
    ),
    duration: Duration(seconds: 3),
    behavior: SnackBarBehavior.floating,
  ),
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'snackbar-widget',
      previewTab: _SnackBarPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _SnackBarLearn(),
    );
  }
}

class _SnackBarPreview extends StatelessWidget {
  const _SnackBarPreview();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Simple SnackBar!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(label: 'OK', onPressed: () {}),
                ),
              );
            },
            child: const Text('Simple SnackBar'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Floating SnackBar with undo'),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  margin: const EdgeInsets.all(16),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Action undone!')),
                      );
                    },
                  ),
                ),
              );
            },
            child: const Text('Floating SnackBar'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Successfully saved!'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Custom Styled SnackBar'),
          ),
        ],
      ),
    );
  }
}

class _SnackBarLearn extends StatelessWidget {
  const _SnackBarLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is SnackBar?',
          content:
              'SnackBar displays a brief message at the bottom of the screen. It is typically used for notifications, confirmations, and undo actions. It automatically dismisses after a duration.',
          properties: [
            PropertyRow('content', 'Widget', 'Required', 'Message content'),
            PropertyRow('action', 'SnackBarAction?', 'null', 'Optional action button'),
            PropertyRow('duration', 'Duration', '4s', 'Display duration'),
            PropertyRow('behavior', 'SnackBarBehavior', 'fixed', 'fixed or floating'),
            PropertyRow('backgroundColor', 'Color?', 'null', 'Background color'),
          ],
        ),
        const ExplanationCard(
          title: 'Best Practices',
          content:
            '- Use ScaffoldMessenger.of(context) to show SnackBars from anywhere\n- Keep content messages short and actionable\n- Provide an undo action for destructive operations\n- Use floating behavior with margin for modern feel',
        ),
      ],
    );
  }
}