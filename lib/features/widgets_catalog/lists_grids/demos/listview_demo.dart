import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class ListViewDemo extends StatelessWidget {
  const ListViewDemo({super.key});

  static const String _codeSnippet = '''
ListView(
  children: [
    ListTile(title: Text('Item 1')),
    ListTile(title: Text('Item 2')),
    ListTile(title: Text('Item 3')),
  ],
)

ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(
    title: Text(items[index]),
  ),
)

ListView.separated(
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(title: Text(items[index])),
  separatorBuilder: (context, index) => Divider(),
)''';

  @override
  Widget build(BuildContext context) {
    final items = List.generate(20, (i) => 'Item ${i + 1}');
    return DemoScaffold(
      widgetId: 'listview-widget',
      scrollablePreview: false,
      previewTab: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Basic'),
                Tab(text: 'Builder'),
                Tab(text: 'Separated'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: items.take(6).map((i) => ListTile(leading: const Icon(Icons.label), title: Text(i))).toList(),
                  ),
                  ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) => ListTile(
                      leading: CircleAvatar(child: Text('${i + 1}')),
                      title: Text(items[i]),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                  ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (_, i) => ListTile(title: Text(items[i])),
                    separatorBuilder: (_, __) => const Divider(height: 1),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _ListViewLearn(),
    );
  }
}

class _ListViewLearn extends StatelessWidget {
  const _ListViewLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is ListView?',
          content: 'ListView is a scrollable list of widgets. Use ListView.builder for large or infinite lists for better performance.',
          properties: [
            PropertyRow('children', 'List<Widget>', '[]', 'List of widgets (basic)'),
            PropertyRow('itemCount', 'int?', 'null', 'Number of items (builder)'),
            PropertyRow('itemBuilder', 'IndexedWidgetBuilder', 'Required', 'Build each item'),
            PropertyRow('scrollDirection', 'Axis', 'vertical', 'Scroll direction'),
            PropertyRow('padding', 'EdgeInsetsGeometry?', 'null', 'Outer padding'),
          ],
        ),
        const ExplanationCard(
          title: 'When to use which?',
          content:
            '- ListView: Small fixed lists (< 20 items)\n- ListView.builder: Large/dynamic lists (recycles items)\n- ListView.separated: Lists with dividers between items\n- ListView.custom: Most customizable with SliverChildDelegate',
        ),
      ],
    );
  }
}