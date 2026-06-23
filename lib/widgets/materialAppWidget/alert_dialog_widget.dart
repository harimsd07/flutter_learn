import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class AlertdialogWidget extends StatelessWidget {
  const AlertdialogWidget({super.key});

  static const String _codeSnippet = '''
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Delete Item?'),
    content: Text('Are you sure you want to delete this item?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          Navigator.pop(context);
          // Perform delete action
        },
        child: Text('Delete'),
      ),
    ],
  ),
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'alertdialog-widget',
      previewTab: _AlertDialogPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _AlertDialogLearn(),
    );
  }
}

class _AlertDialogPreview extends StatelessWidget {
  const _AlertDialogPreview();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => _showConfirmDialog(context),
            child: const Text('Show Confirmation Dialog'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _showSimpleDialog(context),
            child: const Text('Show SimpleDialog'),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Item?'),
        content: const Text('Are you sure you want to delete this item? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item deleted!')),
              );
            },
            child: Text('Delete', style: TextStyle(color: Colors.red.shade400)),
          ),
        ],
      ),
    );
  }

  void _showSimpleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Choose an option'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Photo selected')),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.photo),
              title: Text('Photo'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gallery selected')),
              );
            },
            child: const ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertDialogLearn extends StatelessWidget {
  const _AlertDialogLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is AlertDialog?',
          content:
              'AlertDialog is a Material Design dialog that informs the user about situations requiring acknowledgment or action. It has a title, content, and list of action buttons.',
          properties: [
            PropertyRow('title', 'Widget?', 'null', 'Dialog title'),
            PropertyRow('content', 'Widget?', 'null', 'Dialog body content'),
            PropertyRow('actions', 'List<Widget>', '[]', 'Action buttons'),
            PropertyRow('contentPadding', 'EdgeInsetsGeometry?', 'null', 'Content padding'),
          ],
        ),
        const ExplanationCard(
          title: 'Dialog Types',
          content:
            '- AlertDialog: Full dialog with title and actions (most common)\n- SimpleDialog: List of options to choose from\n- showDialog(): General dialog function\n- showModalBottomSheet(): Bottom sheet dialog\n- showGeneralDialog(): Most customizable dialog',
        ),
      ],
    );
  }
}