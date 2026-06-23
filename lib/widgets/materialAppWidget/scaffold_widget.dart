import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class ScaffoldWidget extends StatelessWidget {
  const ScaffoldWidget({super.key});

  static const String _codeSnippet = '''
Scaffold(
  appBar: AppBar(title: Text('My App')),
  body: Center(child: Text('Welcome!')),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  drawer: Drawer(
    child: ListView(
      children: [
        DrawerHeader(child: Text('Menu')),
        ListTile(title: Text('Home')),
      ],
    ),
  ),
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'scaffold-widget',
      scrollablePreview: false,
      previewTab: _ScaffoldPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _ScaffoldLearn(),
    );
  }
}

class _ScaffoldPreview extends StatelessWidget {
  const _ScaffoldPreview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scaffold Preview')),
      body: const Center(
        child: Text('This is the body content'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB pressed!')),
          );
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, size: 35, color: Colors.blue)),
                  SizedBox(height: 8),
                  Text('Menu', style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScaffoldLearn extends StatelessWidget {
  const _ScaffoldLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Scaffold?',
          content:
              'Scaffold implements the basic Material Design visual layout structure. It provides slots for AppBar, body, FAB, Drawer, BottomNavigationBar, and more.',
          properties: [
            PropertyRow('appBar', 'PreferredSizeWidget?', 'null', 'Top app bar'),
            PropertyRow('body', 'Widget?', 'null', 'Primary content'),
            PropertyRow('floatingActionButton', 'Widget?', 'null', 'FAB button'),
            PropertyRow('drawer', 'Widget?', 'null', 'Left-side drawer'),
            PropertyRow('endDrawer', 'Widget?', 'null', 'Right-side drawer'),
            PropertyRow('bottomNavigationBar', 'Widget?', 'null', 'Bottom nav bar'),
          ],
        ),
      ],
    );
  }
}