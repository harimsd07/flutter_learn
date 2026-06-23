import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class FutureBuilderDemo extends StatefulWidget {
  const FutureBuilderDemo({super.key});

  @override
  State<FutureBuilderDemo> createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  bool _shouldFail = false;
  int _fetchCount = 0;

  static const String _codeSnippet = '''
FutureBuilder<Map<String, String>>(
  future: _fetchUserData(shouldFail: shouldFail),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: \${snapshot.error}');
    } else if (snapshot.hasData) {
      final user = snapshot.data!;
      return Column(
        children: [
          Text('Name: \${user['name']}'),
          Text('Role: \${user['role']}'),
        ],
      );
    }
    return Text('Press button to fetch');
  },
)''';

  Future<Map<String, String>> _fetchUserData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (_shouldFail) {
      throw Exception('Database connection timed out. Please try again.');
    }
    return {
      'name': 'Sarah Connor',
      'email': 'sconnor@resistance.net',
      'role': 'Resistance Leader / Engineer',
      'avatar': 'SC',
    };
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'futurebuilder-demo',
      scrollablePreview: false,
      previewTab: _FutureBuilderPreview(
        shouldFail: _shouldFail,
        fetchCount: _fetchCount,
        onFetch: () => setState(() => _fetchCount++),
        onToggleFail: (val) => setState(() => _shouldFail = val),
        fetchFuture: _fetchCount == 0 ? null : _fetchUserData(),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _FutureBuilderLearn(),
    );
  }
}

class _FutureBuilderPreview extends StatelessWidget {
  final bool shouldFail;
  final int fetchCount;
  final VoidCallback onFetch;
  final ValueChanged<bool> onToggleFail;
  final Future<Map<String, String>>? fetchFuture;

  const _FutureBuilderPreview({
    required this.shouldFail,
    required this.fetchCount,
    required this.onFetch,
    required this.onToggleFail,
    required this.fetchFuture,
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
                Text('FutureBuilder Simulation', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'Simulates an asynchronous API network request with a 2-second delay. You can toggle the switch to force a failure state.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
                const Divider(height: 24),
                SwitchListTile(
                  title: const Text('Simulate Request Error'),
                  subtitle: const Text('Forces the future to throw an exception'),
                  value: shouldFail,
                  onChanged: onToggleFail,
                  contentPadding: EdgeInsets.zero,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: onFetch,
                  icon: const Icon(Icons.download_rounded),
                  label: Text(fetchCount == 0 ? 'Fetch User Data' : 'Refetch Data'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: fetchFuture == null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.hourglass_empty_rounded, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 8),
                      const Text('Ready to fetch. Click the button above.', style: TextStyle(color: Colors.grey)),
                    ],
                  )
                : FutureBuilder<Map<String, String>>(
                    future: fetchFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Loading user profile...', style: TextStyle(color: Colors.grey)),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Column(
                            children: [
                              const Icon(Icons.error_outline_rounded, color: Colors.red, size: 36),
                              const SizedBox(height: 8),
                              Text(
                                snapshot.error.toString().replaceAll('Exception: ', ''),
                                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final data = snapshot.data!;
                        return Card(
                          color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: theme.colorScheme.secondaryContainer),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: theme.colorScheme.primary,
                                  child: Text(
                                    data['avatar']!,
                                    style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(data['name']!, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                      Text(data['role']!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.primary)),
                                      const SizedBox(height: 4),
                                      Text(data['email']!, style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade600)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return const Text('State undetermined.');
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class _FutureBuilderLearn extends StatelessWidget {
  const _FutureBuilderLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExplanationCard(
          title: 'What is FutureBuilder?',
          content: 'FutureBuilder is a widget that builds itself based on the latest snapshot of interaction with a Future. It simplifies handling the lifecycle of asynchronous calls (waiting, success, error) and guarantees widget rebuilds when the future completes.',
          properties: [
            PropertyRow('future', 'Future<T>', 'Null', 'The asynchronous task computation this builder should listen to'),
            PropertyRow('builder', 'AsyncWidgetBuilder<T>', 'Required', 'The build strategy based on the connectionState of the Future'),
            PropertyRow('initialData', 'T', 'Null', 'Data that will be used until a non-null future completes'),
          ],
        ),
        ExplanationCard(
          title: 'Connection States',
          content: 'The AsyncSnapshot contains the state of connection:\n• ConnectionState.none: No future specified.\n• ConnectionState.waiting: Asynchronous computation is active.\n• ConnectionState.done: Computation resolved successfully or with error.',
          properties: [],
        ),
      ],
    );
  }
}
