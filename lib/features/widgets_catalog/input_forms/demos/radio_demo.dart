import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class RadioDemo extends StatefulWidget {
  const RadioDemo({super.key});

  @override
  State<RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<RadioDemo> {
  String _groupValue = 'option1';

  static const String _codeSnippet = '''
Radio<String>(
  value: 'option1',
  groupValue: _groupValue,
  onChanged: (val) => setState(() => _groupValue = val!),
)

RadioListTile<String>(
  title: Text('Option 1'),
  value: 'option1',
  groupValue: _groupValue,
  onChanged: (val) => setState(() => _groupValue = val!),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'radio-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Select your favorite framework:', style: TextStyle(fontWeight: FontWeight.bold)),
          RadioListTile<String>(
            title: const Text('Flutter'),
            subtitle: const Text('Cross-platform UI'),
            value: 'flutter',
            groupValue: _groupValue,
            onChanged: (v) => setState(() => _groupValue = v!),
          ),
          RadioListTile<String>(
            title: const Text('React Native'),
            subtitle: const Text('JavaScript based'),
            value: 'react',
            groupValue: _groupValue,
            onChanged: (v) => setState(() => _groupValue = v!),
          ),
          RadioListTile<String>(
            title: const Text('Xamarin'),
            subtitle: const Text('C# based'),
            value: 'xamarin',
            groupValue: _groupValue,
            onChanged: (v) => setState(() => _groupValue = v!),
          ),
          const SizedBox(height: 16),
          Text('Selected: $_groupValue', style: const TextStyle(color: Colors.grey)),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _RadioLearn(),
    );
  }
}

class _RadioLearn extends StatelessWidget {
  const _RadioLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Radio?',
          content: 'Radio buttons allow selecting a single option from a group. All radios sharing the same groupValue are mutually exclusive.',
          properties: [
            PropertyRow('value', 'T', 'Required', 'This radio\'s value'),
            PropertyRow('groupValue', 'T?', 'Required', 'Currently selected value'),
            PropertyRow('onChanged', 'ValueChanged<T?>?', 'null', 'Called on selection'),
          ],
        ),
      ],
    );
  }
}