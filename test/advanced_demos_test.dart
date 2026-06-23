import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterlearn/features/widgets_catalog/advanced/demos/futurebuilder_demo.dart';
import 'package:flutterlearn/features/widgets_catalog/advanced/demos/streambuilder_demo.dart';
import 'package:flutterlearn/features/widgets_catalog/advanced/demos/mediaquery_demo.dart';
import 'package:flutterlearn/features/widgets_catalog/advanced/demos/layoutbuilder_demo.dart';

void main() {
  group('Advanced Demos Tests', () {
    testWidgets('FutureBuilderDemo renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: FutureBuilderDemo(),
        ),
      ));

      // Verify the title is present (e.g. in the scaffold or explanation card)
      expect(find.byType(FutureBuilderDemo), findsOneWidget);
      expect(find.text('FutureBuilder Widget'), findsWidgets);
    });

    testWidgets('StreamBuilderDemo renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: StreamBuilderDemo(),
        ),
      ));

      expect(find.byType(StreamBuilderDemo), findsOneWidget);
      expect(find.text('StreamBuilder Control Panel'), findsWidgets);
      expect(find.text('Start'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
    });

    testWidgets('MediaQueryDemo renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: MediaQueryDemo(),
        ),
      ));

      expect(find.byType(MediaQueryDemo), findsOneWidget);
      expect(find.text('Screen Width', skipOffstage: false), findsWidgets);
      expect(find.text('Screen Height', skipOffstage: false), findsWidgets);
      expect(find.text('Orientation', skipOffstage: false), findsWidgets);
    });

    testWidgets('LayoutBuilderDemo renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: LayoutBuilderDemo(),
        ),
      ));

      expect(find.byType(LayoutBuilderDemo), findsOneWidget);
      expect(find.text('LayoutBuilder Constraint Visualizer'), findsOneWidget);
      expect(find.byType(Slider), findsOneWidget);
    });
  });
}
