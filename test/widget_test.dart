import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterlearn/core/data/widget_data.dart';
import 'package:flutterlearn/core/models/widget_item.dart';
import 'package:flutterlearn/core/models/widget_category.dart';

void main() {
  group('WidgetData', () {
    test('categories should contain basic and material', () {
      final ids = WidgetData.categories.map((c) => c.id).toList();
      expect(ids, contains('basic'));
      expect(ids, contains('material'));
    });

    test('total widget count should be correct', () {
      expect(WidgetData.totalCount, WidgetData.categories.fold(0, (sum, c) => sum + c.items.length));
    });

    test('basic widgets should have 8 items', () {
      final basic = WidgetData.categories.firstWhere((c) => c.id == 'basic');
      expect(basic.items.length, 8);
    });

    test('material widgets should have 8 items', () {
      final material = WidgetData.categories.firstWhere((c) => c.id == 'material');
      expect(material.items.length, 8);
    });

    test('findById should return correct widget', () {
      final item = WidgetData.findById('text-widget');
      expect(item, isNotNull);
      expect(item!.name, 'Text Widget');
    });

    test('findById should return null for non-existent widget', () {
      expect(WidgetData.findById('nonexistent'), isNull);
    });

    test('search should find widgets by name', () {
      final results = WidgetData.search('text');
      expect(results.any((w) => w.id == 'text-widget'), isTrue);
    });

    test('search should find widgets by description', () {
      final results = WidgetData.search('overlay');
      expect(results.any((w) => w.id == 'stack-positioned-widget'), isTrue);
    });

    test('categories should contain all expected categories', () {
      final ids = WidgetData.categories.map((c) => c.id).toList();
      expect(ids, containsAll(['basic', 'material', 'input-forms', 'lists-grids', 'navigation', 'animations', 'state-management', 'cupertino']));
    });

    test('search should be case insensitive', () {
      final results = WidgetData.search('TEXT');
      expect(results.any((w) => w.id == 'text-widget'), isTrue);
    });

    test('search should find widgets by tag', () {
      final results = WidgetData.search('ios');
      expect(results.any((w) => w.categoryId == 'cupertino'), isTrue);
    });

    test('all route paths should be unique', () {
      final paths = WidgetData.allItems.map((w) => w.routePath).toList();
      expect(paths.toSet().length, paths.length);
    });

    test('all widget ids should be unique', () {
      final ids = WidgetData.allItems.map((w) => w.id).toList();
      expect(ids.toSet().length, ids.length);
    });
  });

  group('WidgetItem', () {
    test('should create with correct values', () {
      const item = WidgetItem(
        id: 'test',
        name: 'Test Widget',
        categoryId: 'basic',
        description: 'A test widget',
        icon: Icons.star,
        difficulty: 'Beginner',
        routePath: '/test',
        tags: ['test'],
      );
      expect(item.id, 'test');
      expect(item.name, 'Test Widget');
      expect(item.difficulty, 'Beginner');
    });
  });

  group('WidgetCategory', () {
    test('totalItems should return item count', () {
      const category = WidgetCategory(
        id: 'test',
        name: 'Test',
        description: 'Test category',
        icon: Icons.folder,
        color: Color(0xFFFFFFFF),
        items: [
          WidgetItem(
            id: 't1',
            name: 'T1',
            categoryId: 'test',
            description: 'd1',
            icon: Icons.star,
            difficulty: 'Beginner',
            routePath: '/t1',
            tags: [],
          ),
          WidgetItem(
            id: 't2',
            name: 'T2',
            categoryId: 'test',
            description: 'd2',
            icon: Icons.star,
            difficulty: 'Intermediate',
            routePath: '/t2',
            tags: [],
          ),
        ],
      );
      expect(category.totalItems, 2);
    });
  });
}