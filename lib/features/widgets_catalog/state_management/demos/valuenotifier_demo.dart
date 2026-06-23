import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class ValueNotifierDemo extends StatefulWidget {
  const ValueNotifierDemo({super.key});

  @override
  State<ValueNotifierDemo> createState() => _ValueNotifierDemoState();
}

class _ValueNotifierDemoState extends State<ValueNotifierDemo> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final ValueNotifier<bool> _isDark = ValueNotifier<bool>(false);

  static const String _codeSnippet = '''
final ValueNotifier<int> _counter = ValueNotifier(0);

ValueListenableBuilder<int>(
  valueListenable: _counter,
  builder: (context, value, child) {
    return Text('Count: \$value');
  },
)

// Update:
_counter.value++;
// Dispose:
_counter.dispose();
)''';

  @override
  void dispose() {
    _counter.dispose();
    _isDark.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'valuenotifier-demo',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text('ValueNotifier + ValueListenableBuilder',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),
                  ValueListenableBuilder<int>(
                    valueListenable: _counter,
                    builder: (_, value, __) => Text(
                      '$value',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(onPressed: () => _counter.value++, child: const Text('+1')),
                      const SizedBox(width: 8),
                      ElevatedButton(onPressed: () => _counter.value--, child: const Text('-1')),
                      const SizedBox(width: 8),
                      TextButton(onPressed: () => _counter.value = 0, child: const Text('Reset')),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: SwitchListTile(
              title: const Text('Dark Mode Toggle'),
              subtitle: const Text('Using ValueNotifier<bool>'),
              value: true,
              onChanged: (v) => _isDark.value = v,
              secondary: ValueListenableBuilder<bool>(
                valueListenable: _isDark,
                builder: (_, val, __) => Icon(val ? Icons.dark_mode : Icons.light_mode, size: 32),
              ),
            ),
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _ValueNotifierLearn(),
    );
  }
}

class _ValueNotifierLearn extends StatelessWidget {
  const _ValueNotifierLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is ValueNotifier?',
          content: 'ValueNotifier holds a single value and notifies listeners when it changes. Use with ValueListenableBuilder to rebuild only the part of the UI that depends on the value.',
          properties: [
            PropertyRow('value', 'T', 'Required', 'The current value'),
            PropertyRow('valueListenable', 'ValueListenable<T>', 'Required', 'In builder'),
            PropertyRow('builder', 'ValueWidgetBuilder<T>', 'Required', 'Rebuilds on changes'),
            PropertyRow('child', 'Widget?', 'null', 'Constant child in builder'),
          ],
        ),
        const ExplanationCard(
          title: 'Key Benefits',
          content:
            '- Only rebuilds the subtree that needs it (efficient)\n- Simpler than full state management for single values\n- Must call dispose() to prevent memory leaks\n- Good for: counters, toggles, form fields',
        ),
      ],
    );
  }
}