import 'package:flutter/material.dart';

import 'widget_item.dart';

class WidgetCategory {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final List<WidgetItem> items;

  const WidgetCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.items,
  });

  int get totalItems => items.length;
}