import 'package:flutter/material.dart';

class WidgetItem {
  final String id;
  final String name;
  final String categoryId;
  final String description;
  final IconData icon;
  final String difficulty;
  final String routePath;
  final List<String> tags;

  const WidgetItem({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.icon,
    required this.difficulty,
    required this.routePath,
    required this.tags,
  });
}