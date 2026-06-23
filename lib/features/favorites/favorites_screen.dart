import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/data/widget_data.dart';
import '../../../core/widgets/menu_item_card.dart';
import '../../../core/services/persistence_service.dart';
import '../../../core/theme/app_colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key, required this.favoriteIds});

  final Set<String> favoriteIds;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.pageBackground,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Favorites',
          style: GoogleFonts.dmSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: ValueListenableBuilder<Set<String>>(
        valueListenable: PersistenceService.favoritesNotifier,
        builder: (context, favoritesSet, _) {
          final favorites = WidgetData.allItems.where((w) => favoritesSet.contains(w.id)).toList();

          if (favorites.isEmpty) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border_rounded,
                              size: 80,
                              color: isDark ? AppColors.darkTextSecondary : Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No favorites yet',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.darkTextPrimary : Colors.grey.shade700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap the heart icon on any widget to add it here',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextSecondary : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = favorites[index];
              return MenuItemCard(
                title: item.name,
                description: item.description,
                icon: item.icon,
                difficulty: item.difficulty,
                isFavorite: true,
                onFavoriteToggle: () async {
                  final service = await PersistenceService.init();
                  await service.toggleFavorite(item.id);
                },
                onTap: () {
                  try {
                    context.push(item.routePath);
                  } catch (_) {}
                },
              );
            },
          );
        },
      ),
    );
  }
}