import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class PageViewDemo extends StatelessWidget {
  const PageViewDemo({super.key});

  static const String _codeSnippet = '''
PageView(
  scrollDirection: Axis.horizontal,
  children: [
    Container(color: Colors.blue, child: Center(child: Text('Page 1'))),
    Container(color: Colors.purple, child: Center(child: Text('Page 2'))),
  ],
)''';

  @override
  Widget build(BuildContext context) {
    return const DemoScaffold(
      widgetId: 'pageview-widget',
      scrollablePreview: false,
      previewTab: _PageViewPreview(),
      codeSnippet: _codeSnippet,
      learnTab: _PageViewLearn(),
    );
  }
}

class _PageViewPreview extends StatelessWidget {
  const _PageViewPreview();

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.green, Colors.blue, Colors.orange, Colors.purple];
    final pages = ['Welcome', 'Discover', 'Features', 'Community', 'Get Started'];
    return Scaffold(
      body: PageView(
        children: List.generate(5, (i) => Container(
          color: colors[i].shade100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                [Icons.waving_hand, Icons.explore, Icons.star, Icons.people, Icons.rocket_launch][i],
                size: 80,
                color: colors[i],
              ),
              const SizedBox(height: 24),
              Text(pages[i], style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: colors[i])),
              const SizedBox(height: 16),
              Text('Swipe for next page (${i + 1}/5)', style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        )),
      ),
    );
  }
}

class _PageViewLearn extends StatelessWidget {
  const _PageViewLearn();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PageView Widget',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'A scrollable list that works page by page. It is useful for creating swipeable onboarding screens, slides, or paging interfaces.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}