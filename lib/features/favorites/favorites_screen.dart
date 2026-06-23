import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/data/widget_data.dart';
import '../../../core/widgets/menu_item_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.favoriteIds});

  final Set<String> favoriteIds;

  @override
  Widget build(BuildContext context) {
    final favorites = WidgetData.allItems.where((w) => favoriteIds.contains(w.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('No favorites yet', style: TextStyle(fontSize: 18, color: Colors.grey)),
                            SizedBox(height: 8),
                            Text('Tap the heart icon on any widget to add it here',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          : ListView(
              children: favorites.map((item) => MenuItemCard(
                title: item.name,
                description: item.description,
                icon: item.icon,
                difficulty: item.difficulty,
                onTap: () {
                  try {
                    context.push(item.routePath);
                  } catch (_) {}
                },
              )).toList(),
            ),
    );
  }
}