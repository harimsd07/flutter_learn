import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class ListtileWidget extends StatelessWidget {
  const ListtileWidget({super.key});

  static const String _codeSnippet = '''
ListTile(
  leading: Icon(Icons.person),
  title: Text('John Doe'),
  subtitle: Text('Developer'),
  trailing: Icon(Icons.computer_outlined),
  onTap: () {},
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'listtile-widget',
      scrollablePreview: false,
      previewTab: _ListTilePreview(),
      codeSnippet: _codeSnippet,
      learnTab: _ListTileLearn(),
    );
  }
}

class _ListTilePreview extends StatelessWidget {
  const _ListTilePreview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const CircleAvatar(child: Text('JD')),
          title: const Text('John Doe'),
          subtitle: const Text('Developer'),
          trailing: const Icon(Icons.computer_outlined),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('John Doe tapped!')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const CircleAvatar(child: Text('JS')),
          title: const Text('Jane Smith'),
          subtitle: const Text('Designer'),
          trailing: const Icon(Icons.design_services_outlined),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Jane Smith tapped!')),
            );
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.star, color: Colors.amber),
          title: const Text('Favorites'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Favorites tapped!')),
            );
          },
        ),
        const Divider(),
        CheckboxListTile(
          title: const Text('Enable notifications'),
          subtitle: const Text('Receive push notifications'),
          value: true,
          onChanged: (val) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Checkbox: $val')),
            );
          },
          secondary: const Icon(Icons.notifications),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('Dark mode'),
          subtitle: const Text('Toggle dark theme'),
          value: false,
          onChanged: (val) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Switch: $val')),
            );
          },
          secondary: const Icon(Icons.dark_mode),
        ),
      ],
    );
  }
}

class _ListTileLearn extends StatelessWidget {
  const _ListTileLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is ListTile?',
          content:
              'ListTile is a single fixed-height row with up to 3 lines of text and optional leading and trailing icons. It is commonly used in lists, drawers, and menus.',
          properties: [
            PropertyRow('leading', 'Widget?', 'null', 'Widget on the left'),
            PropertyRow('title', 'Widget?', 'null', 'Primary content'),
            PropertyRow('subtitle', 'Widget?', 'null', 'Secondary content'),
            PropertyRow('trailing', 'Widget?', 'null', 'Widget on the right'),
            PropertyRow('onTap', 'GestureTapCallback?', 'null', 'Tap handler'),
          ],
        ),
        const ExplanationCard(
          title: 'ListTile Variants',
          content:
            '- CheckboxListTile: With checkbox\n- SwitchListTile: With switch\n- RadioListTile: With radio button\n- ExpansionTile: Expandable tile with dropdown',
        ),
      ],
    );
  }
}