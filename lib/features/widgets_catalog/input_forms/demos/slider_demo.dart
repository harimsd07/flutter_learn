import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class SliderDemo extends StatefulWidget {
  const SliderDemo({super.key});

  @override
  State<SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _volume = 50;
  double _temperature = 20;
  RangeValues _range = const RangeValues(25, 75);

  static const String _codeSnippet = '''
Slider(
  value: _volume,
  min: 0,
  max: 100,
  divisions: 10,
  label: _volume.round().toString(),
  onChanged: (val) => setState(() => _volume = val),
)

RangeSlider(
  values: _range,
  min: 0,
  max: 100,
  onChanged: (vals) => setState(() => _range = vals),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'slider-widget',
      scrollablePreview: false,
      previewTab: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Volume: ${_volume.round()}', style: const TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _volume,
            min: 0,
            max: 100,
            divisions: 10,
            label: _volume.round().toString(),
            onChanged: (v) => setState(() => _volume = v),
          ),
          const SizedBox(height: 16),
          Text('Temperature: ${_temperature.round()}\u00B0C', style: const TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: _temperature,
            min: -20,
            max: 50,
            divisions: 7,
            label: '${_temperature.round()}\u00B0C',
            onChanged: (v) => setState(() => _temperature = v),
          ),
          const SizedBox(height: 16),
          Text('Range: ${_range.start.round()} - ${_range.end.round()}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          RangeSlider(
            values: _range,
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels(_range.start.round().toString(), _range.end.round().toString()),
            onChanged: (v) => setState(() => _range = v),
          ),
        ],
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _SliderLearn(),
    );
  }
}

class _SliderLearn extends StatelessWidget {
  const _SliderLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Slider?',
          content: 'Slider lets users select a value from a continuous or discrete range by dragging a thumb.',
          properties: [
            PropertyRow('value', 'double', 'Required', 'Current value'),
            PropertyRow('min', 'double', '0', 'Minimum value'),
            PropertyRow('max', 'double', '1', 'Maximum value'),
            PropertyRow('divisions', 'int?', 'null', 'Discrete step count'),
            PropertyRow('label', 'String?', 'null', 'Tooltip during drag'),
            PropertyRow('onChanged', 'ValueChanged<double>?', 'null', 'Called on change'),
          ],
        ),
      ],
    );
  }
}