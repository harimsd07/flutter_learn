# FlutterLearn 📚

> An interactive Flutter widget learning app with live demos, editable code snippets, and structured explanations — across Web, Desktop, iOS & Android.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.7.2-blue?logo=dart)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Tests](https://img.shields.io/badge/tests-27%20passing-brightgreen)]()
[![Analysis](https://img.shields.io/badge/flutter%20analyze-0%20issues-brightgreen)]()

---

## ✨ Features

- 🗂 **50+ Widget Demos** across 9 categories
- ✏️ **Interactive Code Editor** — edit Dart code and press **▶ Run** to see live output
- 🔍 **Full-text + Tag Search** across all widgets
- ❤️ **Favorites** — bookmark widgets for quick access
- 📈 **Progress Tracking** — tracks which widgets you've visited
- 🌗 **Light / Dark / System Theming** — persisted across sessions
- 📱 **Responsive Layout** — split-screen on desktop (≥800px), tabbed on mobile
- 🍎 **Cupertino Widgets** — full iOS-style widget demos
- 🌐 **Multi-platform** — Web, Linux, Windows, macOS, iOS, Android

---

## 📸 App Overview

### Home Screen
The home screen displays 9 category cards. Each card shows the category name, icon, item count, and a color-coded tag. A bottom `NavigationBar` provides access to Search, Favorites, Progress, and Settings.

### Widget Demo Page
Every widget demo opens a dedicated page with three sections:
| Section | Description |
|---|---|
| **Preview** | Live rendered widget output |
| **Code** | Editable Dart code snippet with Run, Reset, and Copy buttons |
| **Learn** | Explanation cards with property tables |

---

## 🗂 Widget Categories

| Category | Count | Examples |
|---|---|---|
| 🧱 Basic Widgets | 8 | Text, Container, Row/Column, Padding, SizedBox, Expanded, Stack |
| 🎨 Material Widgets | 8 | Scaffold, AppBar, FAB, Card, ListTile, BottomNav, SnackBar, AlertDialog |
| ✏️ Input & Forms | 9 | TextField, Checkbox, Radio, Switch, Slider, Dropdown, GestureDetector, InkWell |
| 📋 Lists & Grids | 4 | ListView, GridView, ReorderableListView, Slivers |
| 🧭 Navigation | 3 | TabBar, PageView, NavigationRail |
| 🎞 Animations | 3 | AnimatedContainer, AnimatedOpacity, Hero |
| ⚙️ State Management | 2 | setState, ValueNotifier |
| 🍎 Cupertino | 5 | CupertinoButton, TextField, AlertDialog, Switch, NavigationBar |
| 🚀 Advanced Demos | 5 | FutureBuilder, StreamBuilder, HTTP GET, MediaQuery, LayoutBuilder |

---

## 🏗 Architecture

The project uses a **Feature-Driven, Layered Architecture**:

```
lib/
├── main.dart                  # App root, GoRouter, global state
├── core/
│   ├── data/                  # Static widget catalog (widget_data.dart)
│   ├── models/                # WidgetItem, WidgetCategory models
│   ├── services/              # PersistenceService (SharedPreferences)
│   ├── theme/                 # AppTheme (light/dark), AppColors
│   └── widgets/               # DemoScaffold, DynamicPreview, DynamicCodeParser
├── features/
│   ├── home/                  # HomeScreen
│   ├── search/                # SearchScreen
│   ├── favorites/             # FavoritesScreen
│   ├── progress/              # ProgressScreen
│   ├── settings/              # SettingsScreen
│   └── widgets_catalog/       # All demo screens (9 subcategory dirs)
└── widgets/
    ├── basicWidgets/          # 8 basic widget demo pages
    └── materialAppWidget/     # 8 material widget demo pages
```

### Key Components

| Component | File | Role |
|---|---|---|
| `DemoScaffold` | `core/widgets/demo_scaffold.dart` | Wrapper for all demo pages; handles responsive layout |
| `DynamicCodeParser` | `core/widgets/demo_scaffold.dart` | Parses Dart code via RegExp to extract widget properties |
| `DynamicPreview` | `core/widgets/demo_scaffold.dart` | Renders a live widget based on parsed properties |
| `PersistenceService` | `core/services/persistence_service.dart` | Saves theme, favorites, visited IDs to SharedPreferences |
| `WidgetData` | `core/data/widget_data.dart` | Static catalog of all 50 widgets and 9 categories |

---

## ⚡ How the Live Code Editor Works

1. Each demo page passes a Dart `codeSnippet` string to `DemoScaffold`
2. The code snippet is displayed in an editable `TextField` (monospace, theme-aware)
3. The user edits the code freely — the preview **stays frozen**
4. Pressing **▶ Run** triggers `_runCode()`:
   - `_renderedCode` is updated with the current editor text
   - `DynamicPreview` rebuilds using `DynamicCodeParser` to extract changed values
   - A "Preview updated!" snackbar confirms the re-render
5. **Reset** restores the original snippet and preview instantly

```
Edit Code → Press ▶ Run → DynamicCodeParser parses → DynamicPreview re-renders
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (3.x or later)
- Dart SDK ^3.7.2 (bundled with Flutter)

### Install & Run

```bash
# 1. Clone the repository
git clone https://github.com/your-username/flutter-learn.git
cd flutter-learn

# 2. Install dependencies
flutter pub get

# 3. Run on web (recommended)
flutter run -d web-server --web-port=8080
# Then open http://localhost:8080 in your browser

# 4. Run on Linux desktop
flutter run -d linux

# 5. Run on Chrome (if available)
CHROME_EXECUTABLE=/path/to/chrome flutter run -d chrome
```

### Build for Production

```bash
# Web
flutter build web

# Linux
flutter build linux --release

# Android
flutter build apk --release
```

---

## 🧪 Testing

```bash
# Run all tests (27 tests, 100% pass rate)
flutter test

# Static analysis (0 issues)
flutter analyze
```

| Test File | Tests | Coverage Area |
|---|---|---|
| `widget_test.dart` | 15 | WidgetData catalog integrity, models, search |
| `persistence_service_test.dart` | 8 | Theme, favorites, visited CRUD and reset |
| `advanced_demos_test.dart` | 4 | FutureBuilder, StreamBuilder, MediaQuery, LayoutBuilder rendering |

---

## 📦 Dependencies

```yaml
dependencies:
  flutter:               # UI framework
  cupertino_icons: ^1.0.8  # iOS icons
  go_router: ^14.8.1     # Declarative routing
  shared_preferences: ^2.3.2  # Local persistence
  http: ^1.2.0           # HTTP networking (advanced demo)

dev_dependencies:
  flutter_test:          # Testing framework
  flutter_lints: ^5.0.0  # Lint rules
```

---

## 🗺 Roadmap

- [ ] Syntax highlighting in the code editor
- [ ] More Advanced Demos (CustomPainter, Isolates, Provider)
- [ ] Offline-capable PWA build
- [ ] Dark/Light code editor themes (VS Code, Dracula, Solarized)
- [ ] Export learned widgets as a personal cheat sheet PDF
- [ ] Community-contributed widget snippets

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -m 'Add my feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Open a Pull Request

Please make sure `flutter analyze` and `flutter test` both pass before submitting.

---

## 📄 License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

---

<div align="center">
  Built with ❤️ using Flutter
</div>