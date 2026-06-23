import 'package:flutter/material.dart';

import '../models/widget_item.dart';
import '../models/widget_category.dart';
import '../theme/app_colors.dart';

class WidgetData {
  WidgetData._();

  static final List<WidgetCategory> categories = [
    WidgetCategory(
      id: 'basic',
      name: 'Basic Widgets',
      description: 'Fundamental Flutter layout and display widgets',
      icon: Icons.widgets_outlined,
      color: AppColors.basicCategory,
      items: basicWidgets,
    ),
    WidgetCategory(
      id: 'material',
      name: 'Material Widgets',
      description: 'Material Design component widgets',
      icon: Icons.design_services_outlined,
      color: AppColors.materialCategory,
      items: materialWidgets,
    ),
    WidgetCategory(
      id: 'input-forms',
      name: 'Input & Forms',
      description: 'Text input, toggles, selectors, and form validation',
      icon: Icons.edit_outlined,
      color: AppColors.inputCategory,
      items: inputWidgets,
    ),
    WidgetCategory(
      id: 'lists-grids',
      name: 'Lists & Grids',
      description: 'Scrollable lists, grids, and slivers',
      icon: Icons.list_alt_outlined,
      color: AppColors.listCategory,
      items: listGridWidgets,
    ),
    WidgetCategory(
      id: 'navigation',
      name: 'Navigation',
      description: 'Tab bars, pages, navigation rail, and drawers',
      icon: Icons.navigation_outlined,
      color: AppColors.navCategory,
      items: navigationWidgets,
    ),
    WidgetCategory(
      id: 'animations',
      name: 'Animations',
      description: 'Implicit and explicit animations, transitions',
      icon: Icons.animation_outlined,
      color: AppColors.animCategory,
      items: animationWidgets,
    ),
    WidgetCategory(
      id: 'state-management',
      name: 'State Management',
      description: 'setState, ValueNotifier, and state patterns',
      icon: Icons.settings_suggest_outlined,
      color: AppColors.stateCategory,
      items: stateManagementWidgets,
    ),
    WidgetCategory(
      id: 'cupertino',
      name: 'Cupertino Widgets',
      description: 'iOS-style widgets following Apple HIG',
      icon: Icons.apple,
      color: AppColors.cupertinoCategory,
      items: cupertinoWidgets,
    ),
    WidgetCategory(
      id: 'advanced',
      name: 'Advanced Demos',
      description: 'Async programming, HTTP networking, and responsive design',
      icon: Icons.integration_instructions_outlined,
      color: AppColors.advancedCategory,
      items: advancedWidgets,
    ),
  ];

  static final List<WidgetItem> basicWidgets = [
    const WidgetItem(id: 'text-widget', name: 'Text Widget', categoryId: 'basic', description: 'Displays text with customizable styling', icon: Icons.text_fields, difficulty: 'Beginner', routePath: '/widget/basic/text-widget', tags: ['text', 'style', 'typography']),
    const WidgetItem(id: 'row-column-widget', name: 'Row & Column Widget', categoryId: 'basic', description: 'Arrange children horizontally or vertically', icon: Icons.view_column_outlined, difficulty: 'Beginner', routePath: '/widget/basic/row-column-widget', tags: ['row', 'column', 'layout', 'flex']),
    const WidgetItem(id: 'container-widget', name: 'Container Widget', categoryId: 'basic', description: 'Box model widget with padding, margin, decoration', icon: Icons.crop_square, difficulty: 'Beginner', routePath: '/widget/basic/container-widget', tags: ['container', 'box', 'decoration', 'margin', 'padding']),
    const WidgetItem(id: 'center-widget', name: 'Center Widget', categoryId: 'basic', description: 'Centers its child within parent', icon: Icons.center_focus_strong, difficulty: 'Beginner', routePath: '/widget/basic/center-widget', tags: ['center', 'alignment']),
    const WidgetItem(id: 'padding-widget', name: 'Padding Widget', categoryId: 'basic', description: 'Adds spacing around its child', icon: Icons.padding, difficulty: 'Beginner', routePath: '/widget/basic/padding-widget', tags: ['padding', 'spacing', 'edgeinsets']),
    const WidgetItem(id: 'sizedbox-widget', name: 'SizedBox Widget', categoryId: 'basic', description: 'Fixed-size box or spacer with optional child', icon: Icons.height, difficulty: 'Beginner', routePath: '/widget/basic/sizedbox-widget', tags: ['sizedbox', 'spacing', 'size']),
    const WidgetItem(id: 'expanded-widget', name: 'Expanded Widget', categoryId: 'basic', description: 'Expands child to fill available space in Row/Column', icon: Icons.expand, difficulty: 'Beginner', routePath: '/widget/basic/expanded-widget', tags: ['expanded', 'flex', 'layout']),
    const WidgetItem(id: 'stack-positioned-widget', name: 'Stack & Positioned Widget', categoryId: 'basic', description: 'Overlay children with precise positioning', icon: Icons.layers, difficulty: 'Intermediate', routePath: '/widget/basic/stack-positioned-widget', tags: ['stack', 'positioned', 'overlay', 'layers']),
  ];

  static final List<WidgetItem> materialWidgets = [
    const WidgetItem(id: 'scaffold-widget', name: 'Scaffold Widget', categoryId: 'material', description: 'Material Design visual layout structure', icon: Icons.web, difficulty: 'Beginner', routePath: '/widget/material/scaffold-widget', tags: ['scaffold', 'structure', 'appbar', 'drawer']),
    const WidgetItem(id: 'appbar-widget', name: 'AppBar Widget', categoryId: 'material', description: 'Top app bar with title, actions, and navigation', icon: Icons.tab, difficulty: 'Beginner', routePath: '/widget/material/appbar-widget', tags: ['appbar', 'title', 'actions', 'leading']),
    const WidgetItem(id: 'fab-widget', name: 'FloatingActionButton Widget', categoryId: 'material', description: 'Prominent circular button for primary action', icon: Icons.add_circle_outline, difficulty: 'Beginner', routePath: '/widget/material/fab-widget', tags: ['fab', 'floating', 'action', 'button']),
    const WidgetItem(id: 'card-widget', name: 'Card Widget', categoryId: 'material', description: 'Material Design card with elevation and rounded corners', icon: Icons.credit_card, difficulty: 'Beginner', routePath: '/widget/material/card-widget', tags: ['card', 'elevation', 'surface']),
    const WidgetItem(id: 'listtile-widget', name: 'ListTile Widget', categoryId: 'material', description: 'Single fixed-height row with leading, title, subtitle, trailing', icon: Icons.list_alt, difficulty: 'Beginner', routePath: '/widget/material/listtile-widget', tags: ['listtile', 'list', 'tile']),
    const WidgetItem(id: 'bottomnav-widget', name: 'BottomNavigationBar Widget', categoryId: 'material', description: 'Bottom navigation bar for top-level views', icon: Icons.navigation, difficulty: 'Intermediate', routePath: '/widget/material/bottomnav-widget', tags: ['bottomnavigation', 'navigation', 'tabs']),
    const WidgetItem(id: 'snackbar-widget', name: 'SnackBar Widget', categoryId: 'material', description: 'Brief message displayed at bottom of screen', icon: Icons.info_outline, difficulty: 'Beginner', routePath: '/widget/material/snackbar-widget', tags: ['snackbar', 'toast', 'notification']),
    const WidgetItem(id: 'alertdialog-widget', name: 'AlertDialog Widget', categoryId: 'material', description: 'Modal dialog for user confirmation', icon: Icons.warning_amber_outlined, difficulty: 'Beginner', routePath: '/widget/material/alertdialog-widget', tags: ['alertdialog', 'dialog', 'modal', 'confirmation']),
  ];

  static final List<WidgetItem> inputWidgets = [
    const WidgetItem(id: 'textfield-widget', name: 'TextField Widget', categoryId: 'input-forms', description: 'Text input with keyboard and decoration', icon: Icons.text_fields, difficulty: 'Beginner', routePath: '/widget/input-forms/textfield-widget', tags: ['textfield', 'input', 'keyboard', 'form']),
    const WidgetItem(id: 'textformfield-widget', name: 'TextFormField Widget', categoryId: 'input-forms', description: 'TextField integrated with Form for validation', icon: Icons.verified_user_outlined, difficulty: 'Intermediate', routePath: '/widget/input-forms/textformfield-widget', tags: ['form', 'validation', 'textformfield']),
    const WidgetItem(id: 'checkbox-widget', name: 'Checkbox Widget', categoryId: 'input-forms', description: 'Boolean selection with check mark', icon: Icons.check_box_outlined, difficulty: 'Beginner', routePath: '/widget/input-forms/checkbox-widget', tags: ['checkbox', 'boolean', 'toggle']),
    const WidgetItem(id: 'radio-widget', name: 'Radio Widget', categoryId: 'input-forms', description: 'Single selection from mutually exclusive options', icon: Icons.radio_button_checked, difficulty: 'Beginner', routePath: '/widget/input-forms/radio-widget', tags: ['radio', 'selection', 'mutually exclusive']),
    const WidgetItem(id: 'switch-widget', name: 'Switch Widget', categoryId: 'input-forms', description: 'Toggle switch for on/off state', icon: Icons.toggle_on, difficulty: 'Beginner', routePath: '/widget/input-forms/switch-widget', tags: ['switch', 'toggle', 'on off']),
    const WidgetItem(id: 'slider-widget', name: 'Slider Widget', categoryId: 'input-forms', description: 'Select a value from a continuous or discrete range', icon: Icons.linear_scale, difficulty: 'Beginner', routePath: '/widget/input-forms/slider-widget', tags: ['slider', 'range', 'value']),
    const WidgetItem(id: 'dropdown-widget', name: 'DropdownButton Widget', categoryId: 'input-forms', description: 'Drop-down menu for selecting a single option', icon: Icons.arrow_drop_down, difficulty: 'Beginner', routePath: '/widget/input-forms/dropdown-widget', tags: ['dropdown', 'menu', 'select']),
    const WidgetItem(id: 'gesturedetector-widget', name: 'GestureDetector Widget', categoryId: 'input-forms', description: 'Detect taps, drags, and pinch gestures', icon: Icons.touch_app, difficulty: 'Intermediate', routePath: '/widget/input-forms/gesturedetector-widget', tags: ['gesture', 'tap', 'drag', 'pinch']),
    const WidgetItem(id: 'inkwell-widget', name: 'InkWell Widget', categoryId: 'input-forms', description: 'Tap area with Material ripple effect', icon: Icons.back_hand, difficulty: 'Beginner', routePath: '/widget/input-forms/inkwell-widget', tags: ['inkwell', 'ripple', 'tap', 'material']),
  ];

  static final List<WidgetItem> listGridWidgets = [
    const WidgetItem(id: 'listview-widget', name: 'ListView Widget', categoryId: 'lists-grids', description: 'Scrollable list with builder and separated variants', icon: Icons.list, difficulty: 'Beginner', routePath: '/widget/lists-grids/listview-widget', tags: ['listview', 'scroll', 'builder']),
    const WidgetItem(id: 'gridview-widget', name: 'GridView Widget', categoryId: 'lists-grids', description: '2D scrollable grid of widgets', icon: Icons.grid_view, difficulty: 'Beginner', routePath: '/widget/lists-grids/gridview-widget', tags: ['gridview', 'grid', 'columns']),
    const WidgetItem(id: 'reorderable-listview-widget', name: 'ReorderableListView', categoryId: 'lists-grids', description: 'Drag-to-reorder list items', icon: Icons.reorder, difficulty: 'Intermediate', routePath: '/widget/lists-grids/reorderable-listview-widget', tags: ['reorder', 'drag', 'list']),
    const WidgetItem(id: 'sliver-widget', name: 'Slivers (CustomScrollView)', categoryId: 'lists-grids', description: 'Advanced scrolling with SliverAppBar and mixed slivers', icon: Icons.view_headline, difficulty: 'Advanced', routePath: '/widget/lists-grids/sliver-widget', tags: ['sliver', 'customscrollview', 'sliverappbar']),
  ];

  static final List<WidgetItem> navigationWidgets = [
    const WidgetItem(id: 'tabbar-widget', name: 'TabBar Widget', categoryId: 'navigation', description: 'Tabbed navigation with swipeable pages', icon: Icons.tab, difficulty: 'Intermediate', routePath: '/widget/navigation/tabbar-widget', tags: ['tabbar', 'tabs', 'swipe']),
    const WidgetItem(id: 'pageview-widget', name: 'PageView Widget', categoryId: 'navigation', description: 'Swipeable full-screen pages', icon: Icons.view_carousel, difficulty: 'Intermediate', routePath: '/widget/navigation/pageview-widget', tags: ['pageview', 'swipe', 'carousel']),
    const WidgetItem(id: 'navigationrail-widget', name: 'NavigationRail Widget', categoryId: 'navigation', description: 'Side navigation for tablets and desktop', icon: Icons.vertical_split, difficulty: 'Intermediate', routePath: '/widget/navigation/navigationrail-widget', tags: ['navigationrail', 'sidebar', 'desktop']),
  ];

  static final List<WidgetItem> animationWidgets = [
    const WidgetItem(id: 'animatedcontainer-widget', name: 'AnimatedContainer', categoryId: 'animations', description: 'Implicitly animate Container properties', icon: Icons.auto_awesome, difficulty: 'Beginner', routePath: '/widget/animations/animatedcontainer-widget', tags: ['animatedcontainer', 'implicit', 'animate']),
    const WidgetItem(id: 'animatedopacity-widget', name: 'AnimatedOpacity', categoryId: 'animations', description: 'Implicitly animate opacity for fade effects', icon: Icons.opacity, difficulty: 'Beginner', routePath: '/widget/animations/animatedopacity-widget', tags: ['animatedopacity', 'fade', 'opacity']),
    const WidgetItem(id: 'hero-widget', name: 'Hero Widget', categoryId: 'animations', description: 'Shared element transition between screens', icon: Icons.local_fire_department, difficulty: 'Intermediate', routePath: '/widget/animations/hero-widget', tags: ['hero', 'transition', 'shared element']),
  ];

  static final List<WidgetItem> stateManagementWidgets = [
    const WidgetItem(id: 'setstate-demo', name: 'setState', categoryId: 'state-management', description: 'Flutter built-in state management for local state', icon: Icons.sync, difficulty: 'Beginner', routePath: '/widget/state-management/setstate-demo', tags: ['setstate', 'stateful', 'local state']),
    const WidgetItem(id: 'valuenotifier-demo', name: 'ValueNotifier', categoryId: 'state-management', description: 'Simple reactive state with ValueListenableBuilder', icon: Icons.notifications_active, difficulty: 'Intermediate', routePath: '/widget/state-management/valuenotifier-demo', tags: ['valuenotifier', 'reactive', 'builder']),
  ];

  static final List<WidgetItem> cupertinoWidgets = [
    const WidgetItem(id: 'cupertino-button-widget', name: 'CupertinoButton', categoryId: 'cupertino', description: 'iOS-style button with opacity feedback', icon: Icons.smart_button, difficulty: 'Beginner', routePath: '/widget/cupertino/cupertino-button-widget', tags: ['cupertino', 'button', 'ios']),
    const WidgetItem(id: 'cupertino-textfield-widget', name: 'CupertinoTextField', categoryId: 'cupertino', description: 'iOS-style text input field', icon: Icons.keyboard, difficulty: 'Beginner', routePath: '/widget/cupertino/cupertino-textfield-widget', tags: ['cupertino', 'textfield', 'ios']),
    const WidgetItem(id: 'cupertino-alertdialog-widget', name: 'CupertinoAlertDialog', categoryId: 'cupertino', description: 'iOS-style alert dialog and action sheet', icon: Icons.warning, difficulty: 'Intermediate', routePath: '/widget/cupertino/cupertino-alertdialog-widget', tags: ['cupertino', 'dialog', 'alert', 'ios']),
    const WidgetItem(id: 'cupertino-switch-widget', name: 'CupertinoSwitch', categoryId: 'cupertino', description: 'iOS-style toggle switch', icon: Icons.toggle_on, difficulty: 'Beginner', routePath: '/widget/cupertino/cupertino-switch-widget', tags: ['cupertino', 'switch', 'ios']),
    const WidgetItem(id: 'cupertino-navbar-widget', name: 'CupertinoNavigationBar', categoryId: 'cupertino', description: 'iOS-style navigation bar with blur effect', icon: Icons.navigation, difficulty: 'Intermediate', routePath: '/widget/cupertino/cupertino-navbar-widget', tags: ['cupertino', 'navbar', 'ios']),
  ];

  static final List<WidgetItem> advancedWidgets = [
    const WidgetItem(id: 'futurebuilder-demo', name: 'FutureBuilder Widget', categoryId: 'advanced', description: 'Handle asynchronous tasks with loading states', icon: Icons.hourglass_empty, difficulty: 'Intermediate', routePath: '/widget/advanced/futurebuilder-demo', tags: ['future', 'async', 'futurebuilder']),
    const WidgetItem(id: 'streambuilder-demo', name: 'StreamBuilder Widget', categoryId: 'advanced', description: 'Consume stream data reactively in real time', icon: Icons.stream, difficulty: 'Intermediate', routePath: '/widget/advanced/streambuilder-demo', tags: ['stream', 'async', 'streambuilder']),
    const WidgetItem(id: 'http-get-demo', name: 'HTTP GET Networking', categoryId: 'advanced', description: 'Fetch data from REST API using http package', icon: Icons.cloud_sync_outlined, difficulty: 'Intermediate', routePath: '/widget/advanced/http-get-demo', tags: ['http', 'network', 'api', 'json']),
    const WidgetItem(id: 'mediaquery-demo', name: 'MediaQuery Widget', categoryId: 'advanced', description: 'Build responsive layouts based on screen size info', icon: Icons.aspect_ratio_outlined, difficulty: 'Intermediate', routePath: '/widget/advanced/mediaquery-demo', tags: ['mediaquery', 'responsive', 'screen size']),
    const WidgetItem(id: 'layoutbuilder-demo', name: 'LayoutBuilder Widget', categoryId: 'advanced', description: 'Build layouts depending on parent constraints', icon: Icons.developer_mode_outlined, difficulty: 'Intermediate', routePath: '/widget/advanced/layoutbuilder-demo', tags: ['layoutbuilder', 'responsive', 'constraints']),
  ];

  static WidgetItem? findById(String id) {
    for (final cat in categories) {
      for (final item in cat.items) {
        if (item.id == id) return item;
      }
    }
    return null;
  }

  static WidgetCategory? findCategoryById(String id) {
    for (final cat in categories) {
      if (cat.id == id) return cat;
    }
    return null;
  }

  static List<WidgetItem> search(String query) {
    final lower = query.toLowerCase();
    final results = <WidgetItem>[];
    for (final cat in categories) {
      for (final item in cat.items) {
        if (item.name.toLowerCase().contains(lower) ||
            item.description.toLowerCase().contains(lower) ||
            item.tags.any((t) => t.contains(lower))) {
          results.add(item);
        }
      }
    }
    return results;
  }

  static List<WidgetItem> get allItems => [
    ...basicWidgets,
    ...materialWidgets,
    ...inputWidgets,
    ...listGridWidgets,
    ...navigationWidgets,
    ...animationWidgets,
    ...stateManagementWidgets,
    ...cupertinoWidgets,
    ...advancedWidgets,
  ];

  static int get totalCount => allItems.length;
}