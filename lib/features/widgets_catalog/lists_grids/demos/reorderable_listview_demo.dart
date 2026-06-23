import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class ReorderableListDemo extends StatelessWidget {
  const ReorderableListDemo({super.key});

  static const String _codeSnippet = '''
ReorderableListView(
  onReorder: (oldIndex, newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
  },
  children: items.map((item) => ListTile(
    key: ValueKey(item),
    title: Text(item),
    leading: Icon(Icons.drag_handle),
  )).toList(),
)''';

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'reorderable-listview-widget',
      scrollablePreview: false,
      previewTab: _ReorderablePreview(),
      codeSnippet: _codeSnippet,
      learnTab: _ReorderableLearn(),
    );
  }
}

class _ReorderablePreview extends StatefulWidget {
  const _ReorderablePreview();

  @override
  State<_ReorderablePreview> createState() => _ReorderablePreviewState();
}

class _ReorderablePreviewState extends State<_ReorderablePreview> {
  final List<String> _items = List.generate(8, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) newIndex -= 1;
          final item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
      children: _items.map((item) => ListTile(
        key: ValueKey(item),
        title: Text(item),
        leading: const Icon(Icons.drag_handle),
        trailing: const Icon(Icons.reorder),
      )).toList(),
    );
  }
}

class _ReorderableLearn extends StatelessWidget {
  const _ReorderableLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is ReorderableListView?',
          content: 'ReorderableListView allows users to reorder items by dragging them. Each child must have a unique Key.',
          properties: [
            PropertyRow('onReorder', 'ReorderCallback', 'Required', 'Called when item is moved'),
            PropertyRow('children', 'List<Widget>', 'Required', 'List items'),
            PropertyRow('header', 'Widget?', 'null', 'Non-reorderable header'),
          ],
        ),
      ],
    );
  }
}