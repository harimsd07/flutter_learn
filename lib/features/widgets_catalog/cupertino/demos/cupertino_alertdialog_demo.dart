import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class CupertinoAlertDialogDemo extends StatelessWidget {
  const CupertinoAlertDialogDemo({super.key});

  static const String _codeSnippet = '''
showCupertinoDialog(
  context: context,
  builder: (context) => CupertinoAlertDialog(
    title: Text('Confirm'),
    content: Text('Are you sure?'),
    actions: [
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text('Cancel'),
        onPressed: () => Navigator.pop(context),
      ),
      CupertinoDialogAction(
        isDestructiveAction: true,
        child: Text('Delete'),
        onPressed: () => Navigator.pop(context),
      ),
    ],
  ),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'cupertino-alertdialog-widget',
      previewTab: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CupertinoButton.filled(
              onPressed: () => _showCupertinoDialog(context),
              child: const Text('Show CupertinoAlertDialog'),
            ),
            const SizedBox(height: 16),
            CupertinoButton(
              onPressed: () => _showCupertinoActionSheet(context),
              child: const Text('Show ActionSheet'),
            ),
          ],
        ),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _CupertinoAlertDialogLearn(),
    );
  }

  void _showCupertinoDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Delete Item?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item deleted!')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCupertinoActionSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: const Text('Choose Action'),
        message: const Text('Select an option below'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Camera selected')),
              );
            },
            child: const Text('Take Photo'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gallery selected')),
              );
            },
            child: const Text('Choose from Gallery'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}

class _CupertinoAlertDialogLearn extends StatelessWidget {
  const _CupertinoAlertDialogLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is CupertinoAlertDialog?',
          content: 'CupertinoAlertDialog is an iOS-style alert dialog. Use CupertinoDialogAction for buttons with isDefaultAction and isDestructiveAction properties.',
          properties: [
            PropertyRow('title', 'Widget?', 'null', 'Dialog title'),
            PropertyRow('content', 'Widget?', 'null', 'Dialog body'),
            PropertyRow('actions', 'List<Widget>', '[]', 'Action buttons'),
          ],
        ),
        const ExplanationCard(
          title: 'CupertinoActionSheet',
          content:
            '- iOS-style action sheet with options\n- Shows at bottom of screen\n- Has cancel button at bottom\n- Use showCupertinoModalPopup() to display',
        ),
      ],
    );
  }
}