import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class NavigationRailDemo extends StatefulWidget {
  const NavigationRailDemo({super.key});

  static const String _codeSnippet = '''
NavigationRail(
  selectedIndex: 0,
  destinations: [
    NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
    NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
  ],
)''';

  @override
  State<NavigationRailDemo> createState() => _NavigationRailDemoState();
}

class _NavigationRailDemoState extends State<NavigationRailDemo> {
  int _selectedIndex = 0;

  static const _pages = ['Home Screen', 'Search Screen', 'Settings Screen'];
  static const _icons = [Icons.home, Icons.search, Icons.settings];

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'navigationrail-widget',
      scrollablePreview: false,
      previewTab: Row(
        children: [
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (i) => setState(() => _selectedIndex = i),
            labelType: NavigationRailLabelType.all,
            leading: const Padding(
              padding: EdgeInsets.only(top: 16),
              child: FlutterLogo(size: 32),
            ),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
              NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_icons[_selectedIndex], size: 64, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 16),
                  Text(_pages[_selectedIndex], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ],
      ),
      codeSnippet: NavigationRailDemo._codeSnippet,
      learnTab: const _NavigationRailLearn(),
    );
  }
}

class _NavigationRailLearn extends StatelessWidget {
  const _NavigationRailLearn();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'NavigationRail Widget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'A Material Design widget that is meant to be displayed at the left or right of an app to navigate between a small number of views, typically between three and five.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}