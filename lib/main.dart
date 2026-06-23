import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/services/persistence_service.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/app_shell.dart';
import 'features/favorites/favorites_screen.dart';
import 'features/home/home_screen.dart';
import 'features/progress/progress_screen.dart';
import 'features/search/search_screen.dart';
import 'features/settings/settings_screen.dart';
import 'features/guides/flutter_setup_guide_screen.dart';

// ── Widget demo imports ──────────────────────────────────────────────────────
import 'widgets/basicWidgets/text_widget.dart';
import 'widgets/basicWidgets/row_column.dart';
import 'widgets/basicWidgets/container_widget.dart';
import 'widgets/basicWidgets/center_widget.dart';
import 'widgets/basicWidgets/padding_widget.dart';
import 'widgets/basicWidgets/sizedbox_widget.dart';
import 'widgets/basicWidgets/expanded_widget.dart';
import 'widgets/basicWidgets/stack_with_positioned_widget.dart';
import 'widgets/materialAppWidget/scaffold_widget.dart';
import 'widgets/materialAppWidget/appbar_widget.dart';
import 'widgets/materialAppWidget/floating_action_button_widget.dart';
import 'widgets/materialAppWidget/card_widget.dart';
import 'widgets/materialAppWidget/list_tile_widget.dart';
import 'widgets/materialAppWidget/bottom_navigation_widget.dart';
import 'widgets/materialAppWidget/snackbar_widget.dart';
import 'widgets/materialAppWidget/alert_dialog_widget.dart';
import 'features/widgets_catalog/input_forms/demos/textfield_demo.dart';
import 'features/widgets_catalog/input_forms/demos/textformfield_demo.dart';
import 'features/widgets_catalog/input_forms/demos/checkbox_demo.dart';
import 'features/widgets_catalog/input_forms/demos/radio_demo.dart';
import 'features/widgets_catalog/input_forms/demos/switch_demo.dart';
import 'features/widgets_catalog/input_forms/demos/slider_demo.dart';
import 'features/widgets_catalog/input_forms/demos/dropdown_demo.dart';
import 'features/widgets_catalog/input_forms/demos/gesture_detector_demo.dart';
import 'features/widgets_catalog/input_forms/demos/inkwell_demo.dart';
import 'features/widgets_catalog/lists_grids/demos/listview_demo.dart';
import 'features/widgets_catalog/lists_grids/demos/gridview_demo.dart';
import 'features/widgets_catalog/lists_grids/demos/reorderable_listview_demo.dart';
import 'features/widgets_catalog/lists_grids/demos/sliver_demo.dart';
import 'features/widgets_catalog/navigation/demos/tabbar_demo.dart';
import 'features/widgets_catalog/navigation/demos/pageview_demo.dart';
import 'features/widgets_catalog/navigation/demos/navigation_rail_demo.dart';
import 'features/widgets_catalog/animations/demos/animated_container_demo.dart';
import 'features/widgets_catalog/animations/demos/animated_opacity_demo.dart';
import 'features/widgets_catalog/animations/demos/hero_demo.dart';
import 'features/widgets_catalog/state_management/demos/setstate_demo.dart';
import 'features/widgets_catalog/state_management/demos/valuenotifier_demo.dart';
import 'features/widgets_catalog/cupertino/demos/cupertino_button_demo.dart';
import 'features/widgets_catalog/cupertino/demos/cupertino_textfield_demo.dart';
import 'features/widgets_catalog/cupertino/demos/cupertino_alertdialog_demo.dart';
import 'features/widgets_catalog/cupertino/demos/cupertino_switch_demo.dart';
import 'features/widgets_catalog/cupertino/demos/cupertino_navbar_demo.dart';
import 'features/widgets_catalog/advanced/demos/futurebuilder_demo.dart';
import 'features/widgets_catalog/advanced/demos/streambuilder_demo.dart';
import 'features/widgets_catalog/advanced/demos/http_get_demo.dart';
import 'features/widgets_catalog/advanced/demos/mediaquery_demo.dart';
import 'features/widgets_catalog/advanced/demos/layoutbuilder_demo.dart';

void main() {
  runApp(const FlutterLearnApp());
}

class FlutterLearnApp extends StatefulWidget {
  const FlutterLearnApp({super.key});

  @override
  State<FlutterLearnApp> createState() => _FlutterLearnAppState();
}

class _FlutterLearnAppState extends State<FlutterLearnApp> {
  PersistenceService? _persistenceService;
  ThemeMode _themeMode = ThemeMode.system;
  final Set<String> _favoriteIds = {};
  final Set<String> _visitedIds = {};
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _initPersistence();
  }

  Future<void> _initPersistence() async {
    final service = await PersistenceService.init();
    PersistenceService.favoritesNotifier.addListener(() {
      if (mounted) {
        setState(() {
          _favoriteIds.clear();
          _favoriteIds.addAll(PersistenceService.favoritesNotifier.value);
        });
      }
    });
    setState(() {
      _persistenceService = service;
      _themeMode = service.getThemeMode();
      _favoriteIds.addAll(service.getFavoriteIds());
      _visitedIds.addAll(service.getVisitedIds());
      _initialized = true;
    });
  }

  void _toggleFavorite(String id) {
    _persistenceService?.toggleFavorite(id);
  }

  void _markVisited(String id) {
    if (!_visitedIds.contains(id)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_visitedIds.contains(id)) {
          setState(() {
            _visitedIds.add(id);
            _persistenceService?.saveVisitedIds(_visitedIds);
          });
        }
      });
    }
  }

  void _changeTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
      _persistenceService?.saveThemeMode(mode);
    });
  }

  void _resetProgress() {
    setState(() {
      _visitedIds.clear();
      _favoriteIds.clear();
      _persistenceService?.clearAll();
    });
  }

  GoRouter get _router => GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => AppShell(
              themeMode: _themeMode,
              favoriteIds: _favoriteIds,
              visitedIds: _visitedIds,
              onThemeChanged: _changeTheme,
              onResetProgress: _resetProgress,
              child: HomeScreen(
                favoriteIds: _favoriteIds,
                visitedIds: _visitedIds,
                onToggleFavorite: _toggleFavorite,
              ),
            ),
            routes: [
              // ── Feature screens ──────────────────────────────────────────
              GoRoute(
                path: 'search',
                builder: (_, __) => const SearchScreen(),
              ),
              GoRoute(
                path: 'favorites',
                builder: (_, __) => FavoritesScreen(favoriteIds: _favoriteIds),
              ),
              GoRoute(
                path: 'progress',
                builder: (_, __) => ProgressScreen(visitedIds: _visitedIds),
              ),
              GoRoute(
                path: 'settings',
                builder: (_, __) => SettingsScreen(
                  themeMode: _themeMode,
                  onThemeChanged: _changeTheme,
                  onResetProgress: _resetProgress,
                ),
              ),
              GoRoute(
                path: 'guides/setup',
                builder: (_, __) => const FlutterSetupGuideScreen(),
              ),
              // ── Basic Widgets ─────────────────────────────────────────────
              GoRoute(path: 'widget/basic/text-widget', builder: (_, __) { _markVisited('text-widget'); return const TextWidget(); }),
              GoRoute(path: 'widget/basic/row-column-widget', builder: (_, __) { _markVisited('row-column-widget'); return const RowColumnWidget(); }),
              GoRoute(path: 'widget/basic/container-widget', builder: (_, __) { _markVisited('container-widget'); return const ContainerWidget(); }),
              GoRoute(path: 'widget/basic/center-widget', builder: (_, __) { _markVisited('center-widget'); return const CenterWidget(); }),
              GoRoute(path: 'widget/basic/padding-widget', builder: (_, __) { _markVisited('padding-widget'); return const PaddingWidget(); }),
              GoRoute(path: 'widget/basic/sizedbox-widget', builder: (_, __) { _markVisited('sizedbox-widget'); return const SizedboxWidget(); }),
              GoRoute(path: 'widget/basic/expanded-widget', builder: (_, __) { _markVisited('expanded-widget'); return const ExpandedWidget(); }),
              GoRoute(path: 'widget/basic/stack-positioned-widget', builder: (_, __) { _markVisited('stack-positioned-widget'); return const StackWithPositionedWidget(); }),
              // ── Material Widgets ──────────────────────────────────────────
              GoRoute(path: 'widget/material/scaffold-widget', builder: (_, __) { _markVisited('scaffold-widget'); return const ScaffoldWidget(); }),
              GoRoute(path: 'widget/material/appbar-widget', builder: (_, __) { _markVisited('appbar-widget'); return const AppbarWidget(); }),
              GoRoute(path: 'widget/material/fab-widget', builder: (_, __) { _markVisited('fab-widget'); return const FloatingActionButtonWidget(); }),
              GoRoute(path: 'widget/material/card-widget', builder: (_, __) { _markVisited('card-widget'); return const CardWidget(); }),
              GoRoute(path: 'widget/material/listtile-widget', builder: (_, __) { _markVisited('listtile-widget'); return const ListtileWidget(); }),
              GoRoute(path: 'widget/material/bottomnav-widget', builder: (_, __) { _markVisited('bottomnav-widget'); return const BottomNavigationWidget(); }),
              GoRoute(path: 'widget/material/snackbar-widget', builder: (_, __) { _markVisited('snackbar-widget'); return const SnackbarWidget(); }),
              GoRoute(path: 'widget/material/alertdialog-widget', builder: (_, __) { _markVisited('alertdialog-widget'); return const AlertdialogWidget(); }),
              // ── Input & Forms ─────────────────────────────────────────────
              GoRoute(path: 'widget/input-forms/textfield-widget', builder: (_, __) { _markVisited('textfield-widget'); return const TextFieldDemo(); }),
              GoRoute(path: 'widget/input-forms/textformfield-widget', builder: (_, __) { _markVisited('textformfield-widget'); return const TextFormFieldDemo(); }),
              GoRoute(path: 'widget/input-forms/checkbox-widget', builder: (_, __) { _markVisited('checkbox-widget'); return const CheckboxDemo(); }),
              GoRoute(path: 'widget/input-forms/radio-widget', builder: (_, __) { _markVisited('radio-widget'); return const RadioDemo(); }),
              GoRoute(path: 'widget/input-forms/switch-widget', builder: (_, __) { _markVisited('switch-widget'); return const SwitchDemo(); }),
              GoRoute(path: 'widget/input-forms/slider-widget', builder: (_, __) { _markVisited('slider-widget'); return const SliderDemo(); }),
              GoRoute(path: 'widget/input-forms/dropdown-widget', builder: (_, __) { _markVisited('dropdown-widget'); return const DropdownDemo(); }),
              GoRoute(path: 'widget/input-forms/gesturedetector-widget', builder: (_, __) { _markVisited('gesturedetector-widget'); return const GestureDetectorDemo(); }),
              GoRoute(path: 'widget/input-forms/inkwell-widget', builder: (_, __) { _markVisited('inkwell-widget'); return const InkWellDemo(); }),
              // ── Lists & Grids ─────────────────────────────────────────────
              GoRoute(path: 'widget/lists-grids/listview-widget', builder: (_, __) { _markVisited('listview-widget'); return const ListViewDemo(); }),
              GoRoute(path: 'widget/lists-grids/gridview-widget', builder: (_, __) { _markVisited('gridview-widget'); return const GridViewDemo(); }),
              GoRoute(path: 'widget/lists-grids/reorderable-listview-widget', builder: (_, __) { _markVisited('reorderable-listview-widget'); return const ReorderableListDemo(); }),
              GoRoute(path: 'widget/lists-grids/sliver-widget', builder: (_, __) { _markVisited('sliver-widget'); return const SliverDemo(); }),
              // ── Navigation ────────────────────────────────────────────────
              GoRoute(path: 'widget/navigation/tabbar-widget', builder: (_, __) { _markVisited('tabbar-widget'); return const TabBarDemo(); }),
              GoRoute(path: 'widget/navigation/pageview-widget', builder: (_, __) { _markVisited('pageview-widget'); return const PageViewDemo(); }),
              GoRoute(path: 'widget/navigation/navigationrail-widget', builder: (_, __) { _markVisited('navigationrail-widget'); return const NavigationRailDemo(); }),
              // ── Animations ────────────────────────────────────────────────
              GoRoute(path: 'widget/animations/animatedcontainer-widget', builder: (_, __) { _markVisited('animatedcontainer-widget'); return const AnimatedContainerDemo(); }),
              GoRoute(path: 'widget/animations/animatedopacity-widget', builder: (_, __) { _markVisited('animatedopacity-widget'); return const AnimatedOpacityDemo(); }),
              GoRoute(path: 'widget/animations/hero-widget', builder: (_, __) { _markVisited('hero-widget'); return const HeroDemo(); }),
              // ── State Management ──────────────────────────────────────────
              GoRoute(path: 'widget/state-management/setstate-demo', builder: (_, __) { _markVisited('setstate-demo'); return const SetStateDemo(); }),
              GoRoute(path: 'widget/state-management/valuenotifier-demo', builder: (_, __) { _markVisited('valuenotifier-demo'); return const ValueNotifierDemo(); }),
              // ── Cupertino ─────────────────────────────────────────────────
              GoRoute(path: 'widget/cupertino/cupertino-button-widget', builder: (_, __) { _markVisited('cupertino-button-widget'); return const CupertinoButtonDemo(); }),
              GoRoute(path: 'widget/cupertino/cupertino-textfield-widget', builder: (_, __) { _markVisited('cupertino-textfield-widget'); return const CupertinoTextFieldDemo(); }),
              GoRoute(path: 'widget/cupertino/cupertino-alertdialog-widget', builder: (_, __) { _markVisited('cupertino-alertdialog-widget'); return const CupertinoAlertDialogDemo(); }),
              GoRoute(path: 'widget/cupertino/cupertino-switch-widget', builder: (_, __) { _markVisited('cupertino-switch-widget'); return const CupertinoSwitchDemo(); }),
              GoRoute(path: 'widget/cupertino/cupertino-navbar-widget', builder: (_, __) { _markVisited('cupertino-navbar-widget'); return const CupertinoNavigationBarDemo(); }),
              // ── Advanced Demos ────────────────────────────────────────────
              GoRoute(path: 'widget/advanced/futurebuilder-demo', builder: (_, __) { _markVisited('futurebuilder-demo'); return const FutureBuilderDemo(); }),
              GoRoute(path: 'widget/advanced/streambuilder-demo', builder: (_, __) { _markVisited('streambuilder-demo'); return const StreamBuilderDemo(); }),
              GoRoute(path: 'widget/advanced/http-get-demo', builder: (_, __) { _markVisited('http-get-demo'); return const HttpGetDemo(); }),
              GoRoute(path: 'widget/advanced/mediaquery-demo', builder: (_, __) { _markVisited('mediaquery-demo'); return const MediaQueryDemo(); }),
              GoRoute(path: 'widget/advanced/layoutbuilder-demo', builder: (_, __) { _markVisited('layoutbuilder-demo'); return const LayoutBuilderDemo(); }),
            ],
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _BrandSplashScreen(),
      );
    }
    return MaterialApp.router(
      title: 'FlutterLearn',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class _BrandSplashScreen extends StatelessWidget {
  const _BrandSplashScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027),
              Color(0xFF203A43),
              Color(0xFF2C5364),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Central Brand Identity
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Glowing circular logo container
                    Container(
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withValues(alpha: 0.15),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: FlutterLogo(
                          size: 72,
                          style: FlutterLogoStyle.markOnly,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Title
                    const Text(
                      'FlutterLearn',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            color: Colors.black38,
                            offset: Offset(0, 4),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Subtitle
                    Text(
                      'Interactive Widget Catalog & Demos',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Modern Progress Indicator
                    SizedBox(
                      width: 160,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF0288D1),
                        ),
                        minHeight: 3.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Footer
              Positioned(
                bottom: 24,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'Made for Flutter Developers',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.4),
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}