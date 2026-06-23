import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class RowColumnWidget extends StatelessWidget {
  const RowColumnWidget({super.key});

  static const String _codeSnippet = '''
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Apple'),
    SizedBox(width: 20),
    Text('Banana'),
    SizedBox(width: 20),
    Text('Orange'),
  ],
);

Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Item 1'),
    SizedBox(height: 10),
    Text('Item 2'),
    SizedBox(height: 10),
    Text('Item 3'),
  ],
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'row-column-widget',
      previewTab: _RowColumnPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _RowColumnLearn(),
    );
  }
}

class _RowColumnPreview extends StatelessWidget {
  const _RowColumnPreview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Row with different alignments:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        _buildRow(MainAxisAlignment.start, 'start'),
        _buildRow(MainAxisAlignment.center, 'center'),
        _buildRow(MainAxisAlignment.end, 'end'),
        _buildRow(MainAxisAlignment.spaceEvenly, 'spaceEvenly'),
        _buildRow(MainAxisAlignment.spaceBetween, 'spaceBetween'),
        const SizedBox(height: 24),
        const Text('Column with different alignments:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(color: Colors.red.shade100, padding: const EdgeInsets.all(8), child: const Text('Item 1')),
              Container(color: Colors.green.shade100, padding: const EdgeInsets.all(8), child: const Text('Item 2')),
              Container(color: Colors.blue.shade100, padding: const EdgeInsets.all(8), child: const Text('Item 3')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(MainAxisAlignment alignment, String label) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: alignment,
              children: [
                Container(width: 40, height: 30, color: Colors.red, child: const Center(child: Text('A', style: TextStyle(color: Colors.white, fontSize: 11)))),
                Container(width: 40, height: 30, color: Colors.green, child: const Center(child: Text('B', style: TextStyle(color: Colors.white, fontSize: 11)))),
                Container(width: 40, height: 30, color: Colors.blue, child: const Center(child: Text('C', style: TextStyle(color: Colors.white, fontSize: 11)))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RowColumnLearn extends StatelessWidget {
  const _RowColumnLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What are Row & Column?',
          content: 'Row and Column are flex widgets that arrange their children in horizontal (Row) or vertical (Column) direction. They are the building blocks of Flutter layout.',
          properties: [
            PropertyRow('children', 'List<Widget>', 'Required', 'The widgets to arrange'),
            PropertyRow('mainAxisAlignment', 'MainAxisAlignment', 'start', 'How children are placed along the main axis'),
            PropertyRow('crossAxisAlignment', 'CrossAxisAlignment', 'center', 'How children are placed along the cross axis'),
            PropertyRow('mainAxisSize', 'MainAxisSize', 'max', 'How much space to take on main axis'),
          ],
        ),
      ],
    );
  }
}