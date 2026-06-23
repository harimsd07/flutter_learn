import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class GridViewDemo extends StatelessWidget {
  const GridViewDemo({super.key});

  static const String _codeSnippet = '''
GridView.count(
  crossAxisCount: 2,
  children: [
    Card(child: Text('Item 1')),
    Card(child: Text('Item 2')),
  ],
)

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
  ),
  itemCount: 20,
  itemBuilder: (context, index) => Card(child: Text('Item \$index')),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'gridview-widget',
      scrollablePreview: false,
      previewTab: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [Tab(text: 'Grid.count'), Tab(text: 'Grid.builder')],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(12),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    children: List.generate(
                      8,
                      (i) => Card(
                        color: Colors.primaries[i % Colors.primaries.length].shade100,
                        child: Center(
                          child: Text('Item ${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: 18,
                    itemBuilder: (_, i) => Card(
                      color: Colors.primaries[i % Colors.primaries.length].shade50,
                      child: Center(child: Text('Grid ${i + 1}')),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _GridViewLearn(),
    );
  }
}

class _GridViewLearn extends StatelessWidget {
  const _GridViewLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is GridView?',
          content: 'GridView displays widgets in a 2D scrollable grid. Like ListView but with multiple columns.',
          properties: [
            PropertyRow('crossAxisCount', 'int', 'Required', 'Columns count'),
            PropertyRow('mainAxisSpacing', 'double', '0', 'Vertical spacing'),
            PropertyRow('crossAxisSpacing', 'double', '0', 'Horizontal spacing'),
            PropertyRow('childAspectRatio', 'double', '1', 'Width/height ratio'),
          ],
        ),
        const ExplanationCard(
          title: 'SliverGridDelegate Types',
          content:
            '- SliverGridDelegateWithFixedCrossAxisCount: Fixed number of columns\n- SliverGridDelegateWithMaxCrossAxisExtent: Columns based on max width\n- Use GridView.count for fixed columns\n- Use GridView.extent for max-width-based columns',
        ),
      ],
    );
  }
}