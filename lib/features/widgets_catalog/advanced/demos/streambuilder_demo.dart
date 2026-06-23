import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class StreamBuilderDemo extends StatefulWidget {
  const StreamBuilderDemo({super.key});

  @override
  State<StreamBuilderDemo> createState() => _StreamBuilderDemoState();
}

class _StreamBuilderDemoState extends State<StreamBuilderDemo> {
  late StreamController<int> _streamController;
  Timer? _timer;
  int _counter = 0;
  bool _isRunning = false;

  static const String _codeSnippet = '''
StreamBuilder<int>(
  stream: _countStream,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Text('Awaiting stream pulses...');
    } else if (snapshot.hasData) {
      return Text('Pulse Count: \${snapshot.data}');
    }
    return Text('Stream Closed');
  },
)''';

  @override
  void initState() {
    super.initState();
    _initStream();
  }

  void _initStream() {
    _streamController = StreamController<int>.broadcast(
      onListen: () {
        if (_isRunning) _startTimer();
      },
      onCancel: _stopTimer,
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _counter++;
      if (!_streamController.isClosed) {
        _streamController.add(_counter);
      }
    });
    setState(() => _isRunning = true);
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() => _isRunning = false);
  }

  void _resetStream() {
    _stopTimer();
    setState(() {
      _counter = 0;
    });
    if (!_streamController.isClosed) {
      _streamController.add(_counter);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'streambuilder-demo',
      scrollablePreview: false,
      previewTab: _StreamBuilderPreview(
        stream: _streamController.stream,
        isRunning: _isRunning,
        counter: _counter,
        onStart: _startTimer,
        onStop: _stopTimer,
        onReset: _resetStream,
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _StreamBuilderLearn(),
    );
  }
}

class _StreamBuilderPreview extends StatelessWidget {
  final Stream<int> stream;
  final bool isRunning;
  final int counter;
  final VoidCallback onStart;
  final VoidCallback onStop;
  final VoidCallback onReset;

  const _StreamBuilderPreview({
    required this.stream,
    required this.isRunning,
    required this.counter,
    required this.onStart,
    required this.onStop,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('StreamBuilder Control Panel', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'Streams emit sequences of asynchronous events. Use the controls below to start, pause, and reset a periodic integer stream.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
                const Divider(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: isRunning ? onStop : onStart,
                      icon: Icon(isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded),
                      label: Text(isRunning ? 'Pause' : 'Start'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isRunning ? Colors.orange.shade50 : null,
                        foregroundColor: isRunning ? Colors.orange.shade700 : null,
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: onReset,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
        Center(
          child: StreamBuilder<int>(
            stream: stream,
            initialData: counter,
            builder: (context, snapshot) {
              final ConnectionState state = snapshot.connectionState;
              
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: isRunning 
                          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.5)
                          : Colors.grey.shade100,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isRunning ? theme.colorScheme.primary : Colors.grey.shade300,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${snapshot.data ?? 0}',
                        style: theme.textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isRunning ? theme.colorScheme.primary : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isRunning ? Colors.green : Colors.grey,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isRunning ? 'Stream Active' : 'Stream Paused',
                        style: TextStyle(
                          color: isRunning ? Colors.green.shade700 : Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'ConnectionState: ${state.toString().split('.').last}',
                    style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StreamBuilderLearn extends StatelessWidget {
  const _StreamBuilderLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExplanationCard(
          title: 'What is StreamBuilder?',
          content: 'StreamBuilder is a widget that builds itself based on the latest snapshot of interaction with a Stream. Unlike Futures, which emit a single value, Streams can emit multiple values over time, making StreamBuilder perfect for real-time web socket connections, reactive state streams, or periodic updates.',
          properties: [
            PropertyRow('stream', 'Stream<T>', 'Null', 'The asynchronous stream of events this builder should listen to'),
            PropertyRow('builder', 'AsyncWidgetBuilder<T>', 'Required', 'The build strategy based on the connectionState and data of the Stream'),
            PropertyRow('initialData', 'T', 'Null', 'Data that will be used until the first stream event is received'),
          ],
        ),
        ExplanationCard(
          title: 'Futures vs Streams',
          content: '• Futures: Represents a single value or error available in the future. (Use-cases: HTTP Requests, reading files).\n• Streams: Represents a sequence of asynchronous events. (Use-cases: Chat rooms, timer tickers, system notification buses).',
          properties: [],
        ),
      ],
    );
  }
}
