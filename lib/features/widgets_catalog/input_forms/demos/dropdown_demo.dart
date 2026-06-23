import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({super.key});

  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<DropdownDemo> {
  String? _selectedColor = 'Blue';

  static const String _codeSnippet = '''
DropdownButton<String>(
  value: _selectedColor,
  items: ['Red', 'Green', 'Blue'].map((color) =>
    DropdownMenuItem(value: color, child: Text(color))
  ).toList(),
  onChanged: (val) => setState(() => _selectedColor = val),
)''';

  @override
  Widget build(BuildContext context) {
    const colors = ['Red', 'Green', 'Blue', 'Yellow', 'Purple'];
    return DemoScaffold(
      widgetId: 'dropdown-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Favorite Color:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: _selectedColor,
            isExpanded: true,
            items: colors.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
            onChanged: (v) => setState(() => _selectedColor = v),
          ),
          const SizedBox(height: 24),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: _colorFromName(_selectedColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Selected: $_selectedColor',
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _DropdownLearn(),
    );
  }

  Color _colorFromName(String? name) {
    switch (name) {
      case 'Red': return Colors.red;
      case 'Green': return Colors.green;
      case 'Blue': return Colors.blue;
      case 'Yellow': return Colors.yellow.shade700;
      case 'Purple': return Colors.purple;
      default: return Colors.grey;
    }
  }
}

class _DropdownLearn extends StatelessWidget {
  const _DropdownLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is DropdownButton?',
          content: 'DropdownButton displays a menu of options that drops down when tapped. Only one option can be selected at a time.',
          properties: [
            PropertyRow('value', 'T?', 'null', 'Currently selected value'),
            PropertyRow('items', 'List<DDMI<T>>', 'Required', 'DropdownMenuItem list'),
            PropertyRow('onChanged', 'ValueChanged<T?>?', 'null', 'Called on selection'),
            PropertyRow('isExpanded', 'bool', 'false', 'Expand to full width'),
          ],
        ),
      ],
    );
  }
}