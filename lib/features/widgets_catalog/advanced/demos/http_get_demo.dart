import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../core/widgets/demo_scaffold.dart';

class HttpGetDemo extends StatefulWidget {
  const HttpGetDemo({super.key});

  @override
  State<HttpGetDemo> createState() => _HttpGetDemoState();
}

class _HttpGetDemoState extends State<HttpGetDemo> {
  Future<List<Map<String, dynamic>>>? _postsFuture;

  static const String _codeSnippet = '''
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchPosts() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5');
  final response = await http.get(url);
  
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load posts');
  }
}''';

  Future<List<Map<String, dynamic>>> _fetchPostsFromApi() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_limit=5');
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      return list.map((item) => Map<String, dynamic>.from(item)).toList();
    } else {
      throw Exception('HTTP error status: ${response.statusCode}');
    }
  }

  void _triggerFetch() {
    setState(() {
      _postsFuture = _fetchPostsFromApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'http-get-demo',
      scrollablePreview: false,
      previewTab: _HttpGetPreview(
        postsFuture: _postsFuture,
        onFetch: _triggerFetch,
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _HttpGetLearn(),
    );
  }
}

class _HttpGetPreview extends StatelessWidget {
  final Future<List<Map<String, dynamic>>>? postsFuture;
  final VoidCallback onFetch;

  const _HttpGetPreview({
    required this.postsFuture,
    required this.onFetch,
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
                Text('HTTP Network Request', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'Loads 5 real mock blog posts from JSONPlaceholder, a free REST API. Click the button to initiate the network transaction.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
                const Divider(height: 24),
                ElevatedButton.icon(
                  onPressed: onFetch,
                  icon: const Icon(Icons.cloud_download_rounded),
                  label: Text(postsFuture == null ? 'Load Posts' : 'Refresh Feed'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        postsFuture == null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Icon(Icons.network_ping, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text('Tap "Load Posts" to trigger API fetch', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              )
            : FutureBuilder<List<Map<String, dynamic>>>(
                future: postsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 16),
                            Text('Fetching mock API posts...', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
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
                          const Icon(Icons.signal_wifi_off_rounded, color: Colors.red, size: 36),
                          const SizedBox(height: 8),
                          Text(
                            'Failed to fetch: ${snapshot.error}',
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final list = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: list.map((post) {
                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: Colors.grey.shade200),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: theme.colorScheme.primaryContainer,
                                      child: Text(
                                        '${post['id']}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: theme.colorScheme.onPrimaryContainer,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text('Post', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 11)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post['title'] ?? '',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post['body'] ?? '',
                                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade700),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return const Text('State undetermined.');
                },
              ),
      ],
    );
  }
}

class _HttpGetLearn extends StatelessWidget {
  const _HttpGetLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExplanationCard(
          title: 'What is HTTP Networking in Flutter?',
          content: 'Flutter applications load dynamic content by performing standard HTTP network requests to REST API endpoints. The `http` package is the standard, developer-friendly way to make client requests (GET, POST, PUT, DELETE) and handle responses.',
          properties: [
            PropertyRow('Uri.parse()', 'Uri', 'Required', 'Utility to validate and parse standard URL strings into Uri models'),
            PropertyRow('http.get()', 'Future<Response>', 'Required', 'Sends an HTTP GET request to the parsed Uri, returning a Promise resolved to Response'),
            PropertyRow('jsonDecode()', 'Map/List', 'Required', 'Decodes a raw JSON string returned in response.body into a structured Dart Map or List'),
          ],
        ),
        ExplanationCard(
          title: 'Lifecycle of API requests',
          content: 'When requesting data from API: \n1. Display a loading spinner to the user (e.g. CircularProgressIndicator).\n2. Load and parse the response asynchronously.\n3. Display the fetched models inside a List or grid. \n4. Gracefully catch network connectivity errors and display a clean fail banner.',
          properties: [],
        ),
      ],
    );
  }
}
