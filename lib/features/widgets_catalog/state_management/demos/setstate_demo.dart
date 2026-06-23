import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class SetStateDemo extends StatefulWidget {
  const SetStateDemo({super.key});

  @override
  State<SetStateDemo> createState() => _SetStateDemoState();
}

class _SetStateDemoState extends State<SetStateDemo> {
  int _counter = 0;
  bool _isFavorite = false;
  String _text = 'Hello';

  static const String _codeSnippet = '''
class _MyWidgetState extends State<MyWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: \$_counter'),
        ElevatedButton(
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'setstate-demo',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Counter (setState)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  Text('$_counter', style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () => setState(() => _counter++), child: const Text('+1')),
                      const SizedBox(width: 8),
                      ElevatedButton(onPressed: () => setState(() => _counter--), child: const Text('-1')),
                      const SizedBox(width: 8),
                      TextButton(onPressed: () => setState(() => _counter = 0), child: const Text('Reset')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('Favorite (setState)'),
              trailing: IconButton(
                icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: _isFavorite ? Colors.red : Colors.grey),
                onPressed: () => setState(() => _isFavorite = !_isFavorite),
              ),
              subtitle: Text('State: ${_isFavorite ? "favorited" : "not favorited"}'),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('Text Input (setState)', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextField(
                    decoration: const InputDecoration(hintText: 'Type something...'),
                    onChanged: (v) => setState(() => _text = v),
                  ),
                  const SizedBox(height: 8),
                  Text('You typed: $_text'),
                ],
              ),
            ),
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _SetStateLearn(),
    );
  }
}

class _SetStateLearn extends StatelessWidget {
  const _SetStateLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is setState?',
          content: 'setState() notifies Flutter that the internal state of a StatefulWidget has changed, causing the widget to rebuild with the new values.',
          properties: [
            PropertyRow('setState', 'VoidCallback', 'Required', 'Function containing state changes'),
            PropertyRow('state', 'State<T>', 'Framework', 'Current state object'),
          ],
        ),
        const ExplanationCard(
          title: 'When to Use setState',
          content:
            '- Only for LOCAL state within a single widget\n- When state changes are simple (counters, toggles)\n- When no other widget needs to know about this state\n\nAvoid setState when:\n- Multiple widgets need the same state\n- State needs to survive screen changes\n- State is complex or has many dependencies',
        ),
      ],
    );
  }
}