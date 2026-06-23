import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class CheckboxDemo extends StatefulWidget {
  const CheckboxDemo({super.key});

  @override
  State<CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<CheckboxDemo> {
  bool _checked1 = false;
  bool _checked2 = true;
  bool? _tristate = false;

  static const String _codeSnippet = '''
Checkbox(
  value: _isChecked,
  onChanged: (val) => setState(() => _isChecked = val!),
  activeColor: Colors.blue,
)

CheckboxListTile(
  title: Text('Enable feature'),
  value: _isChecked,
  onChanged: (val) => setState(() => _isChecked = val!),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'checkbox-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Checkbox(value: _checked1, onChanged: (v) => setState(() => _checked1 = v!)),
              const Text('Standalone Checkbox'),
            ],
          ),
          CheckboxListTile(
            title: const Text('Enable notifications'),
            subtitle: const Text('Receive push notifications'),
            value: _checked2,
            onChanged: (v) => setState(() => _checked2 = v!),
            secondary: const Icon(Icons.notifications),
          ),
          CheckboxListTile(
            title: const Text('Tristate Checkbox'),
            subtitle: Text('Current value: $_tristate'),
            value: _tristate,
            tristate: true,
            onChanged: (v) => setState(() => _tristate = v),
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _CheckboxLearn(),
    );
  }
}

class _CheckboxLearn extends StatelessWidget {
  const _CheckboxLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Checkbox?',
          content: 'Checkbox allows users to select a boolean value. Use CheckboxListTile to combine with a label.',
          properties: [
            PropertyRow('value', 'bool?', 'Required', 'Current checked state'),
            PropertyRow('onChanged', 'ValueChanged<bool?>?', 'null', 'Called on change'),
            PropertyRow('tristate', 'bool', 'false', 'Allow null (3rd state)'),
            PropertyRow('activeColor', 'Color?', 'null', 'Color when checked'),
          ],
        ),
      ],
    );
  }
}