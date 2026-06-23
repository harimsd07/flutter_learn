# 🏗️ Flutter Widget App — Architecture Design Document

> This document defines the **target architecture** for the fully-developed FlutterLearn app. Any AI tool or developer picking up this project should treat this as the source of truth for design decisions.

---

## 1. Architecture Pattern

### Pattern: Feature-Driven Architecture + Clean Separation

The app follows a **Feature-first folder structure** (also called vertical slicing), where code is organized by feature rather than by type. This makes the project scale cleanly as new widget categories are added.

```
lib/
├── core/          ← Shared utilities, theme, router, base widgets
├── features/      ← Each feature (home, search, a widget category) is self-contained
├── providers/     ← Global app state (theme, progress, favorites)
└── main.dart      ← Entry point only
```

---

## 2. Folder Structure (Detailed)

```
lib/
│
├── main.dart
│   └── Bootstraps app, sets up ProviderScope + MaterialApp.router
│
├── core/
│   ├── theme/
│   │   ├── app_theme.dart          ← ThemeData for light + dark mode
│   │   ├── app_colors.dart         ← All color constants
│   │   └── app_text_styles.dart    ← All TextStyle constants
│   │
│   ├── router/
│   │   └── app_router.dart         ← GoRouter config with all routes
│   │
│   ├── models/
│   │   ├── widget_item.dart        ← Data model for a single widget demo
│   │   └── widget_category.dart    ← Data model for a category
│   │
│   ├── data/
│   │   └── widget_data.dart        ← Static data: all widget names, routes, icons
│   │
│   └── widgets/                    ← Reusable UI components used across features
│       ├── demo_scaffold.dart       ← Standard Scaffold used in every demo
│       ├── demo_tab_view.dart       ← 3-tab view (Preview / Code / Learn)
│       ├── code_snippet_block.dart  ← Syntax-highlighted code block
│       ├── explanation_card.dart    ← Styled explanation text card
│       ├── property_table.dart      ← Properties reference table
│       ├── menu_item_card.dart      ← Reusable category grid/list item
│       └── section_header.dart      ← Section divider with label
│
├── features/
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── widgets/
│   │       ├── category_grid.dart
│   │       └── continue_card.dart   ← "Continue where you left off" widget
│   │
│   ├── widgets_catalog/
│   │   ├── basic/
│   │   │   ├── basic_category_screen.dart
│   │   │   └── demos/
│   │   │       ├── text_demo.dart
│   │   │       ├── row_column_demo.dart
│   │   │       ├── container_demo.dart
│   │   │       ├── center_demo.dart
│   │   │       ├── padding_demo.dart
│   │   │       ├── sizedbox_demo.dart
│   │   │       ├── expanded_demo.dart
│   │   │       └── stack_positioned_demo.dart
│   │   │
│   │   ├── material/
│   │   │   ├── material_category_screen.dart
│   │   │   └── demos/
│   │   │       ├── scaffold_demo.dart
│   │   │       ├── appbar_demo.dart
│   │   │       ├── fab_demo.dart
│   │   │       ├── card_demo.dart
│   │   │       ├── list_tile_demo.dart
│   │   │       ├── bottom_nav_demo.dart
│   │   │       ├── snackbar_demo.dart
│   │   │       └── alert_dialog_demo.dart
│   │   │
│   │   ├── input_forms/
│   │   │   └── demos/ ...
│   │   │
│   │   ├── lists_grids/
│   │   │   └── demos/ ...
│   │   │
│   │   ├── navigation/
│   │   │   └── demos/ ...
│   │   │
│   │   ├── animations/
│   │   │   └── demos/ ...
│   │   │
│   │   ├── state_management/
│   │   │   └── demos/ ...
│   │   │
│   │   ├── async_flutter/
│   │   │   └── demos/ ...
│   │   │
│   │   ├── networking/
│   │   │   └── demos/ ...
│   │   │
│   │   ├── persistence/
│   │   │   └── demos/ ...
│   │   │
│   │   └── responsive/
│   │       └── demos/ ...
│   │
│   ├── search/
│   │   └── search_screen.dart
│   │
│   ├── favorites/
│   │   └── favorites_screen.dart
│   │
│   ├── progress/
│   │   └── progress_screen.dart
│   │
│   └── settings/
│       └── settings_screen.dart
│
└── providers/
    ├── theme_provider.dart         ← Dark/light mode toggle
    ├── progress_provider.dart      ← Track visited demos
    └── favorites_provider.dart     ← Bookmarked demos
```

---

## 3. Data Models

### `WidgetItem` Model

```dart
// lib/core/models/widget_item.dart

class WidgetItem {
  final String id;            // unique slug, e.g. 'text-widget'
  final String name;          // display name, e.g. 'Text Widget'
  final String categoryId;    // parent category
  final String description;   // one-line description
  final IconData icon;         // icon for menu card
  final String difficulty;    // 'Beginner' | 'Intermediate' | 'Advanced'
  final String routePath;     // GoRouter path
  final List<String> tags;    // for search

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
```

### `WidgetCategory` Model

```dart
// lib/core/models/widget_category.dart

class WidgetCategory {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final List<WidgetItem> items;

  const WidgetCategory({...});

  int get totalItems => items.length;
}
```

---

## 4. Navigation (GoRouter)

### Route Map

```
/                          → HomeScreen
/category/:id              → CategoryScreen (dynamic)
/widget/:categoryId/:id    → WidgetDemoScreen (dynamic)
/search                    → SearchScreen
/favorites                 → FavoritesScreen
/progress                  → ProgressScreen
/settings                  → SettingsScreen
```

### Router Config

```dart
// lib/core/router/app_router.dart

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/category/:id',
      builder: (context, state) => CategoryScreen(
        categoryId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(
      path: '/widget/:categoryId/:id',
      builder: (context, state) => WidgetDemoScreen(
        categoryId: state.pathParameters['categoryId']!,
        widgetId: state.pathParameters['id']!,
      ),
    ),
    GoRoute(path: '/search', builder: (_, __) => const SearchScreen()),
    GoRoute(path: '/favorites', builder: (_, __) => const FavoritesScreen()),
    GoRoute(path: '/progress', builder: (_, __) => const ProgressScreen()),
    GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
  ],
);
```

---

## 5. State Management (Riverpod)

### Theme Provider

```dart
// lib/providers/theme_provider.dart

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  void toggle() {
    state = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}
```

### Progress Provider

```dart
// lib/providers/progress_provider.dart

final progressProvider = StateNotifierProvider<ProgressNotifier, Set<String>>((ref) {
  return ProgressNotifier();
});

class ProgressNotifier extends StateNotifier<Set<String>> {
  ProgressNotifier() : super({});

  void markVisited(String widgetId) {
    state = {...state, widgetId};
    _persist(); // save to SharedPreferences
  }

  bool isVisited(String widgetId) => state.contains(widgetId);
}
```

### Favorites Provider

```dart
// lib/providers/favorites_provider.dart

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier();
});

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  void toggle(String widgetId) {
    if (state.contains(widgetId)) {
      state = state.difference({widgetId});
    } else {
      state = {...state, widgetId};
    }
    _persist();
  }

  bool isFavorite(String widgetId) => state.contains(widgetId);
}
```

---

## 6. Core Widget: `DemoScaffold`

Every widget demo screen uses this instead of raw `Scaffold`:

```dart
// lib/core/widgets/demo_scaffold.dart

class DemoScaffold extends StatelessWidget {
  final String title;
  final String widgetId;
  final Widget previewTab;
  final String codeSnippet;
  final Widget learnTab;

  const DemoScaffold({
    super.key,
    required this.title,
    required this.widgetId,
    required this.previewTab,
    required this.codeSnippet,
    required this.learnTab,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [FavoriteButton(widgetId: widgetId)],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.play_circle_outline), text: 'Preview'),
              Tab(icon: Icon(Icons.code), text: 'Code'),
              Tab(icon: Icon(Icons.menu_book_outlined), text: 'Learn'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            previewTab,
            CodeSnippetBlock(code: codeSnippet),
            learnTab,
          ],
        ),
      ),
    );
  }
}
```

---

## 7. Theme Design

### Color Palette (Flutter Brand)

```dart
// lib/core/theme/app_colors.dart

class AppColors {
  // Primary — Flutter blue
  static const primary = Color(0xFF0175C2);
  static const primaryLight = Color(0xFF54C5F8);
  static const primaryDark = Color(0xFF01579B);

  // Accent
  static const accent = Color(0xFF13B9FD);

  // Category colors
  static const basicCategory = Color(0xFF4CAF50);       // Green
  static const materialCategory = Color(0xFF2196F3);    // Blue
  static const inputCategory = Color(0xFFFF9800);       // Orange
  static const listCategory = Color(0xFF9C27B0);        // Purple
  static const navCategory = Color(0xFF00BCD4);         // Cyan
  static const animCategory = Color(0xFFFF5722);        // Deep Orange
  static const stateCategory = Color(0xFF607D8B);       // Blue Grey
  static const asyncCategory = Color(0xFF795548);       // Brown
  static const networkCategory = Color(0xFF3F51B5);     // Indigo
  static const persistCategory = Color(0xFF009688);     // Teal
  static const responsiveCategory = Color(0xFFE91E63);  // Pink

  // Difficulty
  static const beginner = Color(0xFF4CAF50);
  static const intermediate = Color(0xFFFFC107);
  static const advanced = Color(0xFFF44336);
}
```

---

## 8. Demo Screen Template

Every widget demo follows this exact template:

```dart
// Example: lib/features/widgets_catalog/basic/demos/text_demo.dart

import 'package:flutter/material.dart';
import 'package:widget_app/core/widgets/demo_scaffold.dart';
import 'package:widget_app/core/widgets/explanation_card.dart';
import 'package:widget_app/core/widgets/property_table.dart';

class TextDemo extends StatelessWidget {
  const TextDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Text Widget',
      widgetId: 'text-widget',
      previewTab: const _TextPreview(),
      codeSnippet: _codeSnippet,
      learnTab: const _TextLearn(),
    );
  }

  static const String _codeSnippet = '''
Text(
  'Hello, Flutter!',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
''';
}

class _TextPreview extends StatefulWidget {
  const _TextPreview();
  @override
  State<_TextPreview> createState() => _TextPreviewState();
}

class _TextPreviewState extends State<_TextPreview> {
  double _fontSize = 16;
  FontWeight _weight = FontWeight.normal;
  Color _color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Live preview
      Center(child: Text('Hello, Flutter!',
        style: TextStyle(fontSize: _fontSize, fontWeight: _weight, color: _color))),
      // Controls
      Slider(value: _fontSize, min: 12, max: 48,
        onChanged: (v) => setState(() => _fontSize = v)),
      // ... more controls
    ]);
  }
}

class _TextLearn extends StatelessWidget {
  const _TextLearn();

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      const ExplanationCard(
        title: 'What is Text?',
        content: 'The Text widget displays a string of text with a single style.',
      ),
      const PropertyTable(properties: [
        ['data', 'String', 'Required', 'The text to display'],
        ['style', 'TextStyle?', 'null', 'How to style the text'],
        ['textAlign', 'TextAlign?', 'null', 'Horizontal text alignment'],
        ['maxLines', 'int?', 'null', 'Max number of lines'],
        ['overflow', 'TextOverflow?', 'null', 'What happens on overflow'],
      ]),
    ]);
  }
}
```

---

## 9. Testing Strategy

### Unit Tests
- Test data models (`WidgetItem`, `WidgetCategory`)
- Test provider logic (progress, favorites, theme)

### Widget Tests
- Each demo screen renders without errors
- Tab switching works on `DemoScaffold`
- Favorite button toggles state

### Integration Tests
- Full navigation flow: Home → Category → Demo → Back
- Search finds correct results
- Progress persists after app restart

### Test File Structure

```
test/
├── unit/
│   ├── models/
│   │   ├── widget_item_test.dart
│   │   └── widget_category_test.dart
│   └── providers/
│       ├── progress_provider_test.dart
│       └── favorites_provider_test.dart
├── widget/
│   ├── core/
│   │   ├── demo_scaffold_test.dart
│   │   └── code_snippet_block_test.dart
│   └── features/
│       ├── home_screen_test.dart
│       └── basic/
│           └── text_demo_test.dart
└── integration/
    └── navigation_flow_test.dart
```

---

## 10. Dependencies (Final `pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8

  # Navigation
  go_router: ^14.0.0

  # State management
  flutter_riverpod: ^2.5.0

  # Persistence
  shared_preferences: ^2.2.3

  # Code display
  flutter_highlight: ^0.7.0
  highlight: ^0.7.0

  # Typography
  google_fonts: ^6.2.1

  # Animations
  flutter_animate: ^4.5.0

  # Icons
  lucide_icons: ^0.0.4  # or use material_symbols_icons

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  mockito: ^5.4.4
  build_runner: ^2.4.8
```

---

*Architecture Document version 1.0 — Generated 2026-06-22*
