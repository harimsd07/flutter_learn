import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class SwitchDemo extends StatefulWidget {
  const SwitchDemo({super.key});

  @override
  State<SwitchDemo> createState() => _SwitchDemoState();
}

class _SwitchDemoState extends State<SwitchDemo> {
  bool _wifi = true;
  bool _bluetooth = false;
  bool _airplane = false;

  static const String _codeSnippet = '''
Switch(
  value: _isEnabled,
  onChanged: (val) => setState(() => _isEnabled = val),
  activeColor: Colors.blue,
)

SwitchListTile(
  title: Text('Wi-Fi'),
  value: _wifi,
  onChanged: (val) => setState(() => _wifi = val),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'switch-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Wi-Fi'),
            subtitle: const Text('Connected to HomeNetwork'),
            value: _wifi,
            onChanged: (v) => setState(() => _wifi = v),
            secondary: const Icon(Icons.wifi),
          ),
          SwitchListTile(
            title: const Text('Bluetooth'),
            subtitle: const Text('Not connected'),
            value: _bluetooth,
            onChanged: (v) => setState(() => _bluetooth = v),
            secondary: const Icon(Icons.bluetooth),
          ),
          SwitchListTile(
            title: const Text('Airplane Mode'),
            subtitle: const Text('Disable all wireless'),
            value: _airplane,
            onChanged: (v) => setState(() => _airplane = v),
            secondary: const Icon(Icons.airplanemode_active),
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _SwitchLearn(),
    );
  }
}

class _SwitchLearn extends StatelessWidget {
  const _SwitchLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Switch?',
          content: 'Switch toggles between on/off states. SwitchListTile combines a switch with a label and subtitle.',
          properties: [
            PropertyRow('value', 'bool', 'Required', 'Current on/off state'),
            PropertyRow('onChanged', 'ValueChanged<bool>?', 'null', 'Called on toggle'),
            PropertyRow('activeColor', 'Color?', 'null', 'Color when active'),
            PropertyRow('thumbIcon', 'Widget?', 'null', 'Icon on thumb'),
          ],
        ),
      ],
    );
  }
}