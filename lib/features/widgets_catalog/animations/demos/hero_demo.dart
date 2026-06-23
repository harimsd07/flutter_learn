import 'package:flutter/material.dart';

import '../../../../core/widgets/demo_scaffold.dart';

class HeroDemo extends StatelessWidget {
  const HeroDemo({super.key});

  static const String _codeSnippet = '''
// Screen 1
Hero(
  tag: 'image-hero',
  child: Image.asset('my_image.png'),
)

// Screen 2
Hero(
  tag: 'image-hero',  // Same tag
  child: Image.asset('my_image.png'),
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'hero-widget',
      scrollablePreview: false,
      previewTab: Scaffold(
        body: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          children: List.generate(6, (i) {
            final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.teal];
            final icons = [Icons.star, Icons.favorite, Icons.diamond, Icons.pets, Icons.bolt, Icons.rocket];
            return Hero(
              tag: 'item-$i',
              child: Card(
                color: colors[i].shade100,
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _HeroDetail(index: i))),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(icons[i], size: 48, color: colors[i]),
                        const SizedBox(height: 8),
                        Text('Item ${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const Text('Tap for Hero', style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _HeroLearn(),
    );
  }
}

class _HeroDetail extends StatelessWidget {
  final int index;
  const _HeroDetail({required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.teal];
    final icons = [Icons.star, Icons.favorite, Icons.diamond, Icons.pets, Icons.bolt, Icons.rocket];
    return Scaffold(
      appBar: AppBar(title: Text('Item ${index + 1} Detail')),
      body: Center(
        child: Hero(
          tag: 'item-$index',
          child: Card(
            color: colors[index].shade100,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icons[index], size: 100, color: colors[index]),
                  const SizedBox(height: 16),
                  Text('Item ${index + 1}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Go back to see the Hero animation!', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Go Back')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroLearn extends StatelessWidget {
  const _HeroLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ExplanationCard(
          title: 'What is Hero?',
          content: 'Hero creates a shared element transition between two screens. When both screens use a Hero with the same tag, Flutter animates the element from one position/size to the other.',
          properties: [
            PropertyRow('tag', 'Object', 'Required', 'Unique identifier for this hero'),
            PropertyRow('child', 'Widget', 'Required', 'The widget to animate'),
            PropertyRow('flightShuttleBuilder', 'FlightShuttleBuilder?', 'null', 'Custom transition widget'),
          ],
        ),
        const ExplanationCard(
          title: 'Best Practices',
          content:
            '- Tags must be unique across the widget tree\n- Works best with images and cards\n- Both the source and destination need a Hero with the same tag\n- Use MaterialPageRoute for the transition to work',
        ),
      ],
    );
  }
}