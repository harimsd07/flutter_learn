import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({super.key});

  static const String _codeSnippet = '''
TabBar(
  tabs: [
    Tab(icon: Icon(Icons.home), text: 'Home'),
    Tab(icon: Icon(Icons.search), text: 'Search'),
    Tab(icon: Icon(Icons.person), text: 'Profile'),
  ],
)''';

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'tabbar-widget',
      scrollablePreview: false,
      previewTab: _TabBarPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _TabBarLearn(),
    );
  }
}

class _TabBarPreview extends StatelessWidget {
  const _TabBarPreview();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TabBar Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.search), text: 'Search'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.home, size: 64, color: Colors.blue),
                  SizedBox(height: 16),
                  Text('Home Tab', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, size: 64, color: Colors.green),
                  SizedBox(height: 16),
                  Text('Search Tab', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person, size: 64, color: Colors.purple),
                  SizedBox(height: 16),
                  Text('Profile Tab', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarLearn extends StatelessWidget {
  const _TabBarLearn();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TabBar Widget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'A Material Design widget that displays a horizontal row of tabs. It is typically paired with a TabBarView to switch content between different pages.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}