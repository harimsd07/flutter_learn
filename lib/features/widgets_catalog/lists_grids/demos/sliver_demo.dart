import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class SliverDemo extends StatelessWidget {
  const SliverDemo({super.key});

  static const String _codeSnippet = '''
CustomScrollView(
  slivers: [
    SliverAppBar(title: Text('Sliver Header')),
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ListTile(title: Text('Item \$index')),
        childCount: 5,
      ),
    ),
  ],
)''';

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'sliver-widget',
      scrollablePreview: false,
      previewTab: _SliverPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _SliverLearn(),
    );
  }
}

class _SliverPreview extends StatelessWidget {
  const _SliverPreview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Slivers'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade300],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Center(
                  child: Icon(Icons.star, size: 60, color: Colors.white70),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('SliverList:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => ListTile(
                leading: CircleAvatar(child: Text('${i + 1}')),
                title: Text('List Item ${i + 1}'),
              ),
              childCount: 10,
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text('SliverGrid:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            delegate: SliverChildBuilderDelegate(
              (_, i) => Card(
                color: Colors.blue.shade50,
                child: Center(child: Text('Grid ${i + 1}')),
              ),
              childCount: 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverLearn extends StatelessWidget {
  const _SliverLearn();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sliver Widgets',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Slivers are portions of a scrollable area that you can configure to behave in unique ways, such as a floating app bar, list, or grid, all scrolling together.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}