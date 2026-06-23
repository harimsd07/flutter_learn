import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  int _currentIndex = 0;

  static const List<Widget> _pages = [
    _HomeTab(),
    _SearchTab(),
    _SettingsTab(),
  ];

  static const String _codeSnippet = '''
BottomNavigationBar(
  currentIndex: _currentIndex,
  onTap: (index) => setState(() => _currentIndex = index),
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ],
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'bottomnav-widget',
      scrollablePreview: false,
      previewTab: Scaffold(
        appBar: AppBar(title: const Text('Bottom Navigation Demo')),
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: Theme.of(context).colorScheme.primary,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _BottomNavLearn(),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Home Screen', style: TextStyle(fontSize: 20)));
  }
}

class _SearchTab extends StatelessWidget {
  const _SearchTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Search Screen', style: TextStyle(fontSize: 20)));
  }
}

class _SettingsTab extends StatelessWidget {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Screen', style: TextStyle(fontSize: 20)));
  }
}

class _BottomNavLearn extends StatelessWidget {
  const _BottomNavLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is BottomNavigationBar?',
          content:
              'BottomNavigationBar provides navigation between 3-5 top-level views. Each tab is represented by a BottomNavigationBarItem with an icon and label.',
          properties: [
            PropertyRow('items', 'List<BNBI>', 'Required', 'Navigation items'),
            PropertyRow('currentIndex', 'int', '0', 'Currently selected item'),
            PropertyRow('onTap', 'ValueChanged<int>?', 'null', 'Called on tap'),
            PropertyRow('selectedItemColor', 'Color?', 'null', 'Color for selected item'),
            PropertyRow('type', 'BottomNavigationBarType', 'fixed', 'fixed or shifting'),
          ],
        ),
        const ExplanationCard(
          title: 'Implementation Note',
          content:
            'You must use a StatefulWidget to track currentIndex and call setState() in onTap to switch the displayed page. Use IndexedStack to preserve state across tab switches.',
        ),
      ],
    );
  }
}