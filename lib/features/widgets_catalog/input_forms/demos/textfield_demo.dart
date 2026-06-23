import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class TextFieldDemo extends StatelessWidget {
  const TextFieldDemo({super.key});

  static const String _codeSnippet = '''
TextField(
  decoration: InputDecoration(
    labelText: 'Username',
    hintText: 'Enter your username',
    prefixIcon: Icon(Icons.person),
    border: OutlineInputBorder(),
  ),
  onChanged: (value) {},
)''';
  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'textfield-widget',
      scrollablePreview: false,
      previewTab: _TextFieldPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _TextFieldLearn(),
    );
  }
}

class _TextFieldPreview extends StatelessWidget {
  const _TextFieldPreview();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            onChanged: (v) {},
          ),
          const SizedBox(height: 16),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Message',
              hintText: 'Type your message...',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TextFieldLearn extends StatelessWidget {
  const _TextFieldLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is TextField?',
          content: 'TextField is the most common text input widget in Flutter. It allows users to type text using the system keyboard.',
          properties: [
            PropertyRow('decoration', 'InputDecoration?', 'null', 'Visual configuration'),
            PropertyRow('obscureText', 'bool', 'false', 'Hide text (passwords)'),
            PropertyRow('keyboardType', 'TextInputType', 'text', 'Keyboard type'),
            PropertyRow('maxLines', 'int?', '1', 'Number of lines'),
            PropertyRow('onChanged', 'ValueChanged<String>?', 'null', 'Called on text change'),
            PropertyRow('controller', 'TextEditingController?', 'null', 'Programmatic control'),
          ],
        ),
      ],
    );
  }
}