import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class GestureDetectorDemo extends StatefulWidget {
  const GestureDetectorDemo({super.key});

  @override
  State<GestureDetectorDemo> createState() => _GestureDetectorDemoState();
}

class _GestureDetectorDemoState extends State<GestureDetectorDemo> {
  String _message = 'Try gestures on the box below';
  Color _color = Colors.blue;
  double _scale = 1.0;

  static const String _codeSnippet = '''
GestureDetector(
  onTap: () => setState(() => _message = 'Tapped!'),
  onDoubleTap: () => setState(() => _message = 'Double tapped!'),
  onLongPress: () => setState(() => _message = 'Long pressed!'),
  onPanUpdate: (details) => setState(() => _offset += details.delta),
  child: Container(
    width: 200, height: 200,
    color: Colors.blue,
    child: Center(child: Text('Tap me')),
  ),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'gesturedetector-widget',
      previewTab: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_message, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => setState(() {
              _message = 'Single Tap!';
              _color = Colors.green;
            }),
            onDoubleTap: () => setState(() {
              _message = 'Double Tap!';
              _color = Colors.orange;
            }),
            onLongPress: () => setState(() {
              _message = 'Long Press!';
              _color = Colors.purple;
            }),
            onScaleUpdate: (details) => setState(() => _scale = details.scale),
            child: Transform.scale(
              scale: _scale.clamp(0.5, 2.0),
              child: Container(
                width: 150, height: 150,
                decoration: BoxDecoration(color: _color, borderRadius: BorderRadius.circular(16)),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.touch_app, size: 40, color: Colors.white),
                      SizedBox(height: 8),
                      Text('Tap / Double / Long', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          TextButton(onPressed: () => setState(() {
            _message = 'Try gestures on the box below';
            _color = Colors.blue;
            _scale = 1.0;
          }), child: const Text('Reset')),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _GestureLearn(),
    );
  }
}

class _GestureLearn extends StatelessWidget {
  const _GestureLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is GestureDetector?',
          content: 'GestureDetector detects user gestures like taps, drags, and pinches. It does not have a visual representation — it only adds gesture detection to its child.',
          properties: [
            PropertyRow('onTap', 'GestureTapCallback?', 'null', 'Single tap'),
            PropertyRow('onDoubleTap', 'GestureTapCallback?', 'null', 'Double tap'),
            PropertyRow('onLongPress', 'GestureLongPressCallback?', 'null', 'Long press'),
            PropertyRow('onPanUpdate', 'GestureDragUpdateCallback?', 'null', 'Drag'),
            PropertyRow('onScaleUpdate', 'GestureScaleUpdateCallback?', 'null', 'Pinch/scale'),
          ],
        ),
        const ExplanationCard(
          title: 'GestureDetector vs InkWell',
          content:
            '- GestureDetector: No ripple effect, catches all gesture types\n- InkWell: Material ripple effect, only onTap and onLongPress\n- Use InkWell when you want Material feedback\n- Use GestureDetector for advanced gesture handling',
        ),
      ],
    );
  }
}