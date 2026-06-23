import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class CupertinoSwitchDemo extends StatefulWidget {
  const CupertinoSwitchDemo({super.key});

  @override
  State<CupertinoSwitchDemo> createState() => _CupertinoSwitchDemoState();
}

class _CupertinoSwitchDemoState extends State<CupertinoSwitchDemo> {
  bool _wifi = true;
  bool _bluetooth = false;
  bool _airplane = false;

  static const String _codeSnippet = '''
CupertinoSwitch(
  value: _isEnabled,
  onChanged: (val) => setState(() => _isEnabled = val),
  activeColor: CupertinoColors.activeBlue,
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'cupertino-switch-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSwitchTile('Wi-Fi', 'Connected to HomeNetwork', Icons.wifi, _wifi, (v) => setState(() => _wifi = v)),
          _buildSwitchTile('Bluetooth', 'Not connected', Icons.bluetooth, _bluetooth, (v) => setState(() => _bluetooth = v)),
          _buildSwitchTile('Airplane Mode', 'Disable wireless', Icons.airplanemode_active, _airplane, (v) => setState(() => _airplane = v)),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _CupertinoSwitchLearn(),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return CupertinoListTile(
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 13, color: Colors.grey)),
      leading: Icon(icon),
      trailing: CupertinoSwitch(value: value, onChanged: onChanged, activeTrackColor: CupertinoColors.activeBlue),
    );
  }
}

class _CupertinoSwitchLearn extends StatelessWidget {
  const _CupertinoSwitchLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is CupertinoSwitch?',
          content: 'CupertinoSwitch is an iOS-style toggle switch. It has the familiar green/blue thumb on a track design native to iOS.',
          properties: [
            PropertyRow('value', 'bool', 'Required', 'Current on/off state'),
            PropertyRow('onChanged', 'ValueChanged<bool>?', 'null', 'Called on toggle'),
            PropertyRow('activeColor', 'Color?', 'green', 'Track color when on'),
            PropertyRow('thumbColor', 'Color?', 'white', 'Thumb color'),
          ],
        ),
      ],
    );
  }
}