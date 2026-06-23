import 'package:flutter/cupertino.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class CupertinoTextFieldDemo extends StatelessWidget {
  const CupertinoTextFieldDemo({super.key});

  static const String _codeSnippet = '''
CupertinoTextField(
  placeholder: 'Enter text',
  padding: EdgeInsets.all(12),
  decoration: BoxDecoration(
    border: Border.all(color: CupertinoColors.systemGrey),
    borderRadius: BorderRadius.circular(8),
  ),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'cupertino-textfield-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('CupertinoTextField variants:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Basic:'),
          const SizedBox(height: 8),
          const CupertinoTextField(
            placeholder: 'Enter your name',
            padding: EdgeInsets.all(12),
          ),
          const SizedBox(height: 16),
          const Text('With prefix:'),
          const SizedBox(height: 8),
          const CupertinoTextField(
            prefix: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(CupertinoIcons.person),
            ),
            placeholder: 'Username',
            padding: EdgeInsets.all(12),
          ),
          const SizedBox(height: 16),
          const Text('Search style:'),
          const SizedBox(height: 8),
          CupertinoTextField(
            prefix: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(CupertinoIcons.search),
            ),
            placeholder: 'Search',
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: CupertinoColors.systemGrey6,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 16),
          const Text('With clear button:'),
          const SizedBox(height: 8),
          const CupertinoTextField(
            placeholder: 'Type to see clear button',
            padding: EdgeInsets.all(12),
            clearButtonMode: OverlayVisibilityMode.editing,
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _CupertinoTextFieldLearn(),
    );
  }
}

class _CupertinoTextFieldLearn extends StatelessWidget {
  const _CupertinoTextFieldLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is CupertinoTextField?',
          content: 'CupertinoTextField is an iOS-style text input. It uses iOS-style placeholder text and decorations instead of Material UnderlineInputBorder.',
          properties: [
            PropertyRow('placeholder', 'String?', 'null', 'Placeholder text'),
            PropertyRow('padding', 'EdgeInsetsGeometry', 'null', 'Inner padding'),
            PropertyRow('decoration', 'BoxDecoration?', 'null', 'Container decoration'),
            PropertyRow('prefix', 'Widget?', 'null', 'Widget before text'),
            PropertyRow('suffix', 'Widget?', 'null', 'Widget after text'),
            PropertyRow('clearButtonMode', 'OverlayVisibilityMode', 'never', 'When to show clear button'),
          ],
        ),
      ],
    );
  }
}