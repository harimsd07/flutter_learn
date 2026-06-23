import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class TextFormFieldDemo extends StatefulWidget {
  const TextFormFieldDemo({super.key});

  @override
  State<TextFormFieldDemo> createState() => _TextFormFieldDemoState();
}

class _TextFormFieldDemoState extends State<TextFormFieldDemo> {
  final _formKey = GlobalKey<FormState>();

  static const String _codeSnippet = '''
Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          return null;
        },
        decoration: InputDecoration(labelText: 'Name'),
      ),
      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {}
        },
        child: Text('Submit'),
      ),
    ],
  ),
)''';  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'textformfield-widget',
      scrollablePreview: false,
      previewTab: _buildPreview(),
      codeSnippet: _codeSnippet,
      learnTab: const _FormLearn(),
    );
  }
  Widget _buildPreview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (v) => v == null || v.isEmpty ? 'Name is required' : null,
              decoration: const InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              validator: (v) {
                if (v == null || v.isEmpty) return 'Email is required';
                if (!v.contains('@')) return 'Enter a valid email';
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form is valid!')),
                  );
                }
              },
              child: const Text('Validate Form'),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormLearn extends StatelessWidget {
  const _FormLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is TextFormField?',
          content: 'TextFormField wraps TextField and integrates with Form for validation. It provides a validator callback and works with FormState.validate() to show errors.',
          properties: [
            PropertyRow('validator', 'FormFieldValidator<String>?', 'null', 'Validation function'),
            PropertyRow('onSaved', 'FormFieldSetter<String>?', 'null', 'Called on Form.save()'),
            PropertyRow('initialValue', 'String?', 'null', 'Starting value'),
            PropertyRow('autovalidateMode', 'AutovalidateMode', 'disabled', 'When to validate'),
          ],
        ),
        const ExplanationCard(
          title: 'Form + FormState',
          content:
            '- Form: Wraps form fields with a key\n- FormState.validate(): Triggers all validators\n- FormState.save(): Calls onSaved on all fields\n- FormState.reset(): Resets all fields',
        ),
      ],
    );
  }
}