import 'package:flutter/material.dart';

import '../../core/widgets/demo_scaffold.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key});

  static const String _codeSnippet = '''
Card(
  elevation: 5,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  child: Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        child: Image.network('https://picsum.photos/300/200',
          height: 120, width: double.infinity, fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(Icons.broken_image, size: 50),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Card Title', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Card description goes here'),
          ],
        ),
      ),
    ],
  ),
)''';

  static const String codeSnippet = _codeSnippet;

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'card-widget',
      previewTab: _CardPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _CardLearn(),
    );
  }
}

class _CardPreview extends StatelessWidget {
  const _CardPreview();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  'https://picsum.photos/400/200',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.broken_image, size: 40, color: Colors.grey),
                          SizedBox(height: 4),
                          Text('Image not available', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                  ),
                  loadingBuilder: (_, child, progress) {
                    if (progress == null) return child;
                    return SizedBox(
                      height: 120,
                      child: Center(child: CircularProgressIndicator(value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes! : null)),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Premium Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('This card has an image, title, description, and action button.',
                        style: TextStyle(color: Colors.grey)),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(onPressed: null, child: Text('Action')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Interactive card tapped!')),
            );
          },
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Interactive Card', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      Chip(label: Text('Flutter')),
                      Chip(label: Text('Dart')),
                      Chip(label: Text('UI')),
                      Chip(label: Text('Material')),
                    ],
                  ),
                  SizedBox(height: 12),
                  LinearProgressIndicator(value: 0.7, backgroundColor: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CardLearn extends StatelessWidget {
  const _CardLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Card?',
          content:
              'Card is a Material Design card with slightly rounded corners and an elevation shadow. It is commonly used to present related information in a distinct container.',
          properties: [
            PropertyRow('elevation', 'double?', 'null', 'Shadow depth'),
            PropertyRow('shape', 'ShapeBorder?', 'null', 'Shape of the card'),
            PropertyRow('color', 'Color?', 'null', 'Background color'),
            PropertyRow('child', 'Widget?', 'null', 'Card content'),
            PropertyRow('margin', 'EdgeInsetsGeometry?', 'null', 'Outer margin'),
          ],
        ),
        const ExplanationCard(
          title: 'Common Usage',
          content:
            '- Combine with InkWell for tap effects\n- Use ClipRRect to clip child widgets to card shape\n- Combine with ListTile for list-style content\n- Use Column/Row inside for complex layouts',
        ),
      ],
    );
  }
}