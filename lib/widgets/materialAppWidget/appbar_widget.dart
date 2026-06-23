import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class AppbarWidget extends StatelessWidget {
  const AppbarWidget({super.key});

  static const String _codeSnippet = '''
AppBar(
  title: Text('AppBar Widget'),
  centerTitle: true,
  actions: [
    IconButton(icon: Icon(Icons.search), onPressed: () {}),
    IconButton(icon: Icon(Icons.settings), onPressed: () {}),
  ],
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'appbar-widget',
      scrollablePreview: false,
      previewTab: _AppBarPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _AppBarLearn(),
    );
  }
}

class _AppBarPreview extends StatelessWidget {
  const _AppBarPreview();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Demo'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Menu tapped!')),
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search tapped!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('More tapped!')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('AppBar Features:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          _featureCard('leading', 'Menu icon on the left side'),
          _featureCard('title', 'Title text in the center'),
          _featureCard('actions', 'Search and more icons on the right'),
          _featureCard('bottom', '(Optional) TabBar or PreferredSize Widget below title'),
          const SizedBox(height: 24),
          const Text('Try tapping the icons in the AppBar above!',
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _featureCard(String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Text(title[0].toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontFamily: 'monospace')),
        subtitle: Text(description),
      ),
    );
  }
}

class _AppBarLearn extends StatelessWidget {
  const _AppBarLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is AppBar?',
          content:
              'AppBar is a Material Design top bar that displays information and actions. It typically contains a title, optional leading widget, and a list of action widgets.',
          properties: [
            PropertyRow('title', 'Widget?', 'null', 'Primary title widget'),
            PropertyRow('leading', 'Widget?', 'null', 'Left-most widget (back button)'),
            PropertyRow('actions', 'List<Widget>', '[]', 'Widgets on the right'),
            PropertyRow('centerTitle', 'bool', 'false', 'Center the title'),
            PropertyRow('bottom', 'PreferredSizeWidget?', 'null', 'Bottom area (TabBar)'),
            PropertyRow('flexibleSpace', 'Widget?', 'null', 'Background layer'),
          ],
        ),
      ],
    );
  }
}