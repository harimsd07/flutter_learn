import 'package:flutter/material.dart';
import '../../../../core/widgets/demo_scaffold.dart';

class LayoutBuilderDemo extends StatefulWidget {
  const LayoutBuilderDemo({super.key});

  @override
  State<LayoutBuilderDemo> createState() => _LayoutBuilderDemoState();
}

class _LayoutBuilderDemoState extends State<LayoutBuilderDemo> {
  double _containerWidth = 400.0;

  static const String _codeSnippet = '''
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 300) {
      return Row(
        children: [
          Icon(Icons.star),
          Text('Wide Layout'),
        ],
      );
    } else {
      return Column(
        children: [
          Icon(Icons.star),
          Text('Narrow Layout'),
        ],
      );
    }
  },
)''';

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      widgetId: 'layoutbuilder-demo',
      scrollablePreview: false,
      previewTab: _LayoutBuilderPreview(
        containerWidth: _containerWidth,
        onWidthChanged: (val) => setState(() => _containerWidth = val),
      ),
      codeSnippet: _codeSnippet,
      learnTab: const _LayoutBuilderLearn(),
    );
  }
}

class _LayoutBuilderPreview extends StatelessWidget {
  final double containerWidth;
  final ValueChanged<double> onWidthChanged;

  const _LayoutBuilderPreview({
    required this.containerWidth,
    required this.onWidthChanged,
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
                Text('LayoutBuilder Constraint Visualizer', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(
                  'Unlike MediaQuery, which queries the entire screen size, LayoutBuilder queries the parent widget\'s constraints. Adjust the slider to resize the parent box below.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    const Text('Parent Width: ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Slider(
                        min: 150.0,
                        max: 400.0,
                        value: containerWidth,
                        onChanged: onWidthChanged,
                      ),
                    ),
                    Text('${containerWidth.toInt()} px', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Container(
            width: containerWidth,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 280;
                
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      color: theme.colorScheme.primaryContainer,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isWide ? 'Wide Layout (> 280px)' : 'Narrow Layout (<= 280px)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Icon(
                            isWide ? Icons.view_headline : Icons.view_agenda,
                            size: 16,
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: isWide
                            ? Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                spacing: 8,
                                runSpacing: 8,
                                children: _buildGridItems(theme),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: _buildGridItems(theme),
                              ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: Text(
                        'Constraints: maxWidth=${constraints.maxWidth.toInt()}px, maxHeight=${constraints.maxHeight.toInt()}px',
                        style: const TextStyle(fontSize: 10, color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildGridItems(ThemeData theme) {
    return [
      _buildItemBox('Module A', Icons.dashboard, theme),
      _buildItemBox('Module B', Icons.rocket, theme),
      _buildItemBox('Module C', Icons.forum, theme),
    ];
  }

  Widget _buildItemBox(String label, IconData icon, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _LayoutBuilderLearn extends StatelessWidget {
  const _LayoutBuilderLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ExplanationCard(
          title: 'What is LayoutBuilder?',
          content: 'LayoutBuilder is a widget that builds a widget tree depending on the parent widget\'s constraints. This is different from MediaQuery, which returns screen size. LayoutBuilder is the foundation for creating reusable responsive components that change their layouts based on how much space they are allocated.',
          properties: [
            PropertyRow('builder', 'LayoutWidgetBuilder', 'Required', 'Function that takes BoxConstraints and context to build the responsive layout'),
          ],
        ),
        ExplanationCard(
          title: 'BoxConstraints Properties',
          content: '• minWidth / maxWidth: The horizontal bounds allowed by the parent widget.\n• minHeight / maxHeight: The vertical bounds allowed by the parent widget.',
          properties: [],
        ),
      ],
    );
  }
}
