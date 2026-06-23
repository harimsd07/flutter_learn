# FlutterLearn — UI Polish Design Brief
> For: Antigravity (UI Designer / Design Agency)  
> Prepared by: Irah (Developer)  
> Date: June 2026  
> Purpose: Full UI polish handoff for an existing Flutter educational app

---

## 1. Project Overview

**FlutterLearn** is an interactive Flutter widget learning app targeting beginner-to-intermediate Flutter developers. It is a cross-platform educational tool running on Android, iOS, Web, Linux, Windows, and macOS.

The app allows learners to:
- Browse 50+ Flutter widget demos across 9 categories
- See a live preview of each widget
- Edit Dart code in an in-app code editor and press **Run** to update the preview
- Mark widgets as favorites and track learning progress
- Search widgets by name or tag

This is **not a utility app** — it is a **learning product**. The UI should feel like a polished dev-education platform (think something between Dart.dev, Flutter.dev docs, and a mobile-first Codecademy). The visual language should reinforce "focus, clarity, and progressive learning." Every screen should communicate to the user: *you are making progress, this is safe to explore.*

---

## 2. Current State

The app is fully functional and built. The developer has completed all features. The codebase uses:
- **Flutter 3.x** with **Material 3** (`useMaterial3: true`)
- **Riverpod** for state management
- **GoRouter** for navigation
- **SharedPreferences** for persistence
- **google_fonts** package (available but underused)
- **flutter_animate** package (available but underused)
- **flutter_highlight** package (available, used for code blocks)

The current color system uses Flutter's official brand blue (`#0175C2`) as the primary with no cohesive design token system. Category colors are assigned but used inconsistently. There is no unified type scale, no spacing system, and no micro-interaction polish.

---

## 3. Target Audience

- **Primary:** Beginner-to-intermediate Flutter developers, students, bootcamp learners
- **Age range:** 18–32
- **Context of use:** Mobile (Android/iOS primary), Web secondary
- **Mood when using this app:** Curious, learning, exploring — not rushing

---

## 4. Brand Personality

| Trait | Description |
|---|---|
| **Trustworthy** | Feels professionally built, not a side project |
| **Educational** | Calm, structured, easy to scan |
| **Modern developer tool** | References the visual language of great dev docs |
| **Encouraging** | Progress feels tangible; finishing something feels satisfying |
| **Focused** | No visual noise; every element earns its place |

---

## 5. Color System

### Primary Palette

| Role | Color | Hex | Usage |
|---|---|---|---|
| **Primary** | Deep Flutter Blue | `#0D47A1` | AppBars, primary buttons, active tab indicators, nav highlights |
| **Primary Surface** | Mid Blue | `#1565C0` | Progress strip background, secondary headers |
| **Primary Light** | Sky Blue | `#1976D2` | Hover states, tab bar backgrounds |
| **Page Background (light)** | Blue-tinted off-white | `#F0F4FF` | All screen backgrounds in light mode — NOT pure white |
| **Card Surface (light)** | White | `#FFFFFF` | Category cards, demo page cards, settings rows |
| **Accent / CTA** | Mint Green | `#69F0AE` | The "Run" button ONLY — this color should appear nowhere else except the run action. It creates a pavlovian signal: mint = execute. |
| **Code Editor Surface** | Deep navy | `#1A1F2E` | The code editor panel exclusively. Warmer than pure black. |

### Semantic / Difficulty Colors

These three colors are used strictly and only for difficulty badges:

| Difficulty | Color | Hex |
|---|---|---|
| **Beginner** | Green | `#4CAF50` |
| **Intermediate** | Amber | `#FFC107` |
| **Advanced** | Red | `#F44336` |

### Category Accent Colors

Each of the 9 widget categories has its own accent color. These are used as:
- Icon background tint (10–15% opacity)
- Left border on category cards
- Category header gradient overlay

| Category | Accent Color | Hex |
|---|---|---|
| 🧱 Basic Widgets | Green | `#4CAF50` |
| 🎨 Material Widgets | Blue | `#2196F3` |
| ✏️ Input & Forms | Orange | `#FF9800` |
| 📋 Lists & Grids | Purple | `#9C27B0` |
| 🧭 Navigation | Cyan | `#00BCD4` |
| 🎞 Animations | Deep Orange | `#FF5722` |
| ⚙️ State Management | Blue Grey | `#607D8B` |
| 🍎 Cupertino | Indigo | `#3F51B5` |
| 🚀 Advanced Demos | Pink | `#E91E63` |

### Dark Mode Palette

| Role | Hex |
|---|---|
| Background | `#0A0E1A` |
| Card Surface | `#111827` |
| Border | `#1F2937` |
| Primary | `#90CAF9` (lighter blue, not the same dark primary) |
| Text Primary | `#F1F5F9` |
| Text Secondary | `#94A3B8` |

---

## 6. Typography

### Font Pairing

| Role | Font | Weight | Size Range |
|---|---|---|---|
| **Display / App name** | `DM Sans` (Google Fonts) | 600–700 | 20–28px |
| **Body / UI text** | `Inter` (Google Fonts) | 400–500 | 12–16px |
| **Code editor** | `JetBrains Mono` (Google Fonts) | 400 | 12–13px |
| **Category labels / badges** | `Inter` | 600 | 9–11px |

### Type Scale

| Token | Size | Weight | Use |
|---|---|---|---|
| `displayLarge` | 24px | 600 | App name in header |
| `titleLarge` | 18px | 600 | Screen titles |
| `titleMedium` | 15px | 500 | Category names, widget names |
| `bodyMedium` | 14px | 400 | Body copy, learn tab text |
| `bodySmall` | 12px | 400 | Descriptions, subtitles |
| `labelSmall` | 10px | 600 | Badges, count labels |
| `code` | 12.5px | 400 | Code snippets, monospace |

---

## 7. Screen-by-Screen Design Specifications

### 7.1 Home Screen

**Layout:**

```
┌─────────────────────────────────────┐
│ [AppBar: Deep Blue #0D47A1]         │
│   "FlutterLearn"    [search] [⚙️]   │
│   50 widgets · 9 categories         │
│   [Search bar with icon, bg=glass]  │
├─────────────────────────────────────┤
│ [Progress Strip: #1565C0]           │
│   12 / 50 completed   [====····]    │
├─────────────────────────────────────┤
│ [Continue Card — if visited before] │
│   ↻ Continue: "Text Widget"  →      │
├─────────────────────────────────────┤
│ [Filter chips row: scrollable]      │
│  All  Beginner  Intermediate  ...   │
├─────────────────────────────────────┤
│ [Category Grid: 2 columns]          │
│   [Card] [Card]                     │
│   [Card] [Card]                     │
│   ...                               │
├─────────────────────────────────────┤
│ [Bottom NavigationBar]              │
│   Home  Search  Saved  Progress     │
└─────────────────────────────────────┘
```

**AppBar details:**
- Background: `#0D47A1`
- Title: "FlutterLearn" in `DM Sans 600`, white
- Subtitle below title: "50 widgets · 9 categories" — `Inter 400` 12px, 70% white opacity
- Search bar: `TextField` inside AppBar with `fillColor: rgba(255,255,255,0.15)`, white icon, placeholder white 60% opacity. Border-radius: 10px. No visible border.
- Settings icon: right side, white 70% opacity

**Progress strip (between AppBar and content):**
- Background: `#1565C0`
- Text left: "X / 50 completed" — `Inter 400` 11px, white 85% opacity
- Progress bar right: track white 20% opacity, fill `#69F0AE`, height 4px, borderRadius 4px
- Animate the fill width with `flutter_animate` on first load

**Continue Card (shown after first visit):**
- Full-width card below progress strip
- Background: white (light) / `#111827` (dark)
- Left accent border: `#69F0AE` 3px
- Icon: ↻ refresh icon in `#69F0AE`
- Text: "Continue where you left off" (12px secondary) + last widget name (14px 500 primary)
- Arrow icon right side
- Subtle shadow, borderRadius 12px
- Tap → navigates directly to last visited widget demo

**Filter chips row:**
- Horizontally scrollable, no visible scrollbar
- Chips: "All", "Beginner", "Intermediate", "Advanced"
- Selected chip: filled with `#0D47A1`, white label
- Unselected: outlined, primary text
- Each chip has the difficulty dot color indicator

**Category Grid (2 columns):**

Each card:
- Background: white (light) / `#111827` (dark)
- Border radius: 12px
- Subtle border: `1px solid rgba(0,0,0,0.06)`
- Shadow: `BoxShadow(blurRadius: 8, color: rgba(0,0,0,0.05))`
- **Top left:** category emoji icon inside a rounded square (28×28), background is category accent color at 12% opacity
- **Category name:** `Inter 500` 13px, below icon
- **Widget count:** `Inter 400` 11px, secondary text color
- **Difficulty badge bottom:** pill shape, 9px 600 Inter, color-coded per difficulty (green/amber/red bg at 15% opacity)
- **Completion state:** when all demos in a category are visited, show a small green checkmark badge (top-right corner of card, 16px circle, `#4CAF50` bg, white check)
- **Tap animation:** use `flutter_animate` for a subtle scale-down (0.97) on press

**Bottom NavigationBar:**
- Background: white (light) / `#0E1424` (dark)
- Selected item: `#0D47A1` icon + label
- Unselected: grey
- No labels on unselected (icon only, label appears when active)
- Icons: use Material Symbols or Lucide icons (not default Material icons — they look dated)

---

### 7.2 Category Screen

**Layout:**
```
┌─────────────────────────────────────┐
│ [AppBar: category accent color]     │
│   ← [emoji] Category Name          │
│   "8 widgets · Beginner–Intermediate│
│   [category color gradient bottom]  │
├─────────────────────────────────────┤
│ [Widget list: full width cards]     │
│   [Card: widget name + desc + diff] │
│   [Card] ...                        │
└─────────────────────────────────────┘
```

- AppBar uses the **category's own accent color** as background (e.g., green for Basic, orange for Input)
- Widget list uses full-width cards (not 2-column)
- Each card: icon left, name + 1-line description right, difficulty badge far right
- Visited widget cards show a subtle green left border or check overlay

---

### 7.3 Widget Demo Screen (the most important screen)

**Layout:**
```
┌─────────────────────────────────────┐
│ [AppBar: #0D47A1]                   │
│  ← Widget Name         [♡] [diff]   │
│  [TabBar: Preview | Code | Learn]   │
├─────────────────────────────────────┤
│                                     │
│  [Tab content area]                 │
│                                     │
└─────────────────────────────────────┘
```

**AppBar:**
- Background: `#0D47A1`
- Back arrow, Widget name (`DM Sans 500` 16px white), Heart icon (filled red if favorited, outline if not)
- Difficulty badge pill (green/amber/red) — top right corner, small (9px label)
- `TabBar` below the title row with 3 tabs:
  - Preview `▶` 
  - Code `<>`
  - Learn `📖`
- Active tab: white label + `#69F0AE` 2px bottom indicator
- Inactive tab: white 60% opacity

---

#### Tab 1: Preview Tab

**Purpose:** Show a live rendered widget with interactive controls.

**Layout:**
```
┌─────────────────────────────────────┐
│ [Preview Area: #F0F4FF bg]          │
│   Rendered widget centered          │
│   (min height: 150px)               │
│   Dashed border: #90CAF9            │
├─────────────────────────────────────┤
│ [Controls Panel]                    │
│   Property sliders / toggles /      │
│   color pickers specific to widget  │
├─────────────────────────────────────┤
│ [▶ Run Preview] button              │
│   bg: #69F0AE, text: #004D40 dark   │
└─────────────────────────────────────┘
```

- **Preview area:** Rounded container, `#F0F4FF` background, dashed border `#90CAF9`, border-radius 12px, padding 24px. This makes the "sandbox" feel like a distinct stage.
- **Controls panel:** Each property gets a labeled row:
  - Sliders for numeric values (fontSize, padding, etc.)
  - Toggle chips for enum values (FontWeight, TextAlign, etc.)
  - Color dot row for color pickers
  - Label on left (`Inter 400` 11px), control center, value on right (`Inter 600` 11px primary)
- **Run button:**
  - Full width, borderRadius 10px
  - Background: `#69F0AE` (ONLY place this appears on this screen)
  - Text: "▶  Run preview" — `Inter 600` 12px, color `#004D40` (dark green for contrast)
  - On press: slight scale animation, then preview area rebuilds with flutter_animate fade-in

---

#### Tab 2: Code Tab

**Purpose:** Editable Dart code with syntax highlighting. User edits and presses Run.

**Layout:**
```
┌─────────────────────────────────────┐
│ [Toolbar: filename + actions]       │
│   "text_demo.dart"   [📋 Copy][↺]  │
├─────────────────────────────────────┤
│ [Code Editor — dark surface]        │
│   Background: #1A1F2E               │
│   Line numbers: #4A5568             │
│   Dart syntax highlighting:         │
│   - Keywords: #BB86FC (purple)      │
│   - Class names: #69F0AE (mint)     │
│   - Strings: #FFB74D (amber)        │
│   - Numbers: #80DEEA (cyan)         │
│   - Base code: #CFD8DC (light grey) │
│   - Comments: #546E7A (muted)       │
│   Font: JetBrains Mono 12.5px       │
│   Line height: 1.7                  │
├─────────────────────────────────────┤
│ [▶ Run] button                      │
│   Same mint green as Preview tab    │
│   + [↺ Reset] secondary button      │
└─────────────────────────────────────┘
```

- **Code surface:** `#1A1F2E` background, padding 16px, borderRadius 12px (entire block is a card)
- **Line numbers:** left column, `#4A5568` color, monospace, right-aligned, separated by a subtle `#2D3748` divider line
- **Unsaved changes indicator:** a small amber dot on the "Code" tab label when the user has edited but not yet run
- **Run button:** same `#69F0AE` style as Preview tab — consistent across both tabs
- **Reset button:** outlined style, `#0D47A1` border and text, placed alongside Run

---

#### Tab 3: Learn Tab

**Purpose:** Explanation cards, property reference table, and links.

**Layout:**
```
┌─────────────────────────────────────┐
│ [Explanation Card]                  │
│   "What is Text?"                   │
│   Body paragraph...                 │
├─────────────────────────────────────┤
│ [Property Table]                    │
│   Property | Type | Default | Use   │
│   Each row alternating bg           │
├─────────────────────────────────────┤
│ [When to use / tip card]            │
│   Lightbulb icon, highlighted bg    │
└─────────────────────────────────────┘
```

- **Explanation cards:** white card, `#0D47A1` left border 3px, borderRadius 10px, padding 16px. Title `DM Sans 600` 15px, body `Inter 400` 13px line-height 1.6
- **Property table:** Replace plain table rows with styled rows:
  - Property name column: `Inter 600` 12px, `#0D47A1`
  - Type column: monospace pill badge — `background: #E3F2FD`, text `#1565C0`
  - Default value: monospace `Inter 400` 12px, grey
  - Description: `Inter 400` 12px
  - Alternating row backgrounds: `#F8FAFF` / `#FFFFFF`
- **Tip card:** amber left-border card (`#FFC107`), lightbulb icon, slightly different background tint `#FFFBF0`

---

### 7.4 Search Screen

- Search bar prominent at top, auto-focused on open
- Results show immediately as user types (no submit)
- Each result is a card: widget name, category breadcrumb, difficulty badge
- Empty state: friendly illustration + "Try searching 'Stack' or 'ListView'"
- Recent searches shown when input is empty

---

### 7.5 Favorites Screen

- Same card layout as search results
- Empty state: heart outline illustration + "Tap ♡ on any widget to save it here"
- Group favorites by category with section headers

---

### 7.6 Progress Screen

**Layout:**
```
┌─────────────────────────────────────┐
│ [Summary header card]               │
│   Big number: 12/50   Ring chart    │
│   "24% complete"                    │
├─────────────────────────────────────┤
│ [Per-category progress rows]        │
│   🧱 Basic Widgets  [====····] 5/8  │
│   🎨 Material       [==······] 2/8  │
│   ...                               │
└─────────────────────────────────────┘
```

- Ring/donut chart at top, `#0D47A1` fill, `#E3F2FD` track, with large number in center
- Each category row has a linear progress bar using the **category's own accent color**
- Completed categories show a full bar + green check icon

---

### 7.7 Settings Screen

- Standard `ListView` of grouped settings rows
- Groups: Appearance, About
- Appearance: Theme (Light / Dark / System) — use segmented control (`SegmentedButton`)
- Clean minimal design, no decorative elements

---

## 8. Spacing System

Use an **8px base grid** throughout:

| Token | Value | Use |
|---|---|---|
| `xs` | 4px | Icon padding, internal badge padding |
| `sm` | 8px | Tight component gaps |
| `md` | 12px | Card internal padding (compact) |
| `lg` | 16px | Standard card padding, section gaps |
| `xl` | 24px | Screen horizontal padding, large section gaps |
| `xxl` | 32px | Hero areas |

---

## 9. Component Specifications

### Cards
- Border radius: 12px (category cards), 10px (content cards), 8px (badges)
- Elevation: very subtle — `BoxShadow(blurRadius: 8, spreadRadius: 0, color: rgba(0,0,0,0.05))`
- No heavy drop shadows — this is a light, airy educational interface
- Border: `0.5px solid rgba(0,0,0,0.07)` in light mode

### Badges / Pills
- Difficulty badge: `[background at 15% opacity] [color text] [rounded 4px] [padding: 2px 8px] [Inter 600 9px]`
- Type badges in property table: `[#E3F2FD background] [#1565C0 text] [JetBrains Mono 11px] [rounded 4px]`
- Category count: secondary text, no background

### Buttons
| Type | Background | Text | Border | Use |
|---|---|---|---|---|
| Primary (Run) | `#69F0AE` | `#004D40` | none | Execute code / run preview |
| Secondary | `#0D47A1` | white | none | Navigation CTAs |
| Outlined | transparent | `#0D47A1` | `#0D47A1` 1px | Reset, secondary actions |
| Ghost | transparent | secondary text | none | Copy, subtle actions |

### Icons
- Use **Material Symbols** (Outlined weight) or **Lucide Icons** — avoid the filled default Material Icons which look dated
- Icon size: 20px standard, 18px in compact contexts, 24px in AppBar

---

## 10. Motion & Animation

Use `flutter_animate` package (already in dependencies) for:

| Interaction | Animation |
|---|---|
| Screen entry | `FadeEffect` + `SlideEffect(begin: Offset(0, 0.04))` — 250ms, ease-out |
| Category card tap | Scale 1.0 → 0.97 → 1.0, 120ms |
| Run button press | Scale pop + `#69F0AE` flash |
| Preview rebuild | `FadeEffect` on the preview area — 200ms |
| Progress bar fill on first load | Width animate from 0 to value — 600ms ease-out |
| Tab switch | Default `TabBarView` slide — no custom override needed |
| Continue card entry | `SlideEffect(begin: Offset(0, -0.1))` + fade — 300ms |

**Rule:** No looping animations. No ambient motion. Motion only happens as a direct result of user interaction or data load.

---

## 11. Code Editor — Syntax Token Colors

Mapped for Dart on the `#1A1F2E` dark background:

| Token Type | Color | Hex |
|---|---|---|
| Keywords (`const`, `final`, `class`, `void`) | Soft purple | `#BB86FC` |
| Class / type names (`Text`, `Colors`, `TextStyle`) | Mint | `#69F0AE` |
| String literals | Warm amber | `#FFB74D` |
| Numeric literals | Cyan | `#80DEEA` |
| Base code / punctuation | Light grey | `#CFD8DC` |
| Comments | Muted slate | `#546E7A` |
| Line numbers | Dark slate | `#4A5568` |

---

## 12. What NOT to Do

- **Do not use pure white (`#FFFFFF`) for page backgrounds** — use `#F0F4FF`
- **Do not use the mint green (`#69F0AE`) for anything except the Run button** — it is a semantic signal
- **Do not use heavy drop shadows** — elevation should be minimal
- **Do not use generic rounded-corner cards with just a title and subtitle** — every card must carry contextual data (difficulty, count, progress)
- **Do not use default Material Icons** — use outlined/symbol variants
- **Do not add decorative gradients or blurs to all surfaces** — reserve them for the AppBar header area only
- **Do not add bottom navigation labels for all tabs** — show label only for active tab to reduce clutter on mobile

---

## 13. Deliverables Expected from Designer

1. **Figma file** with:
   - Color styles / design tokens matching this brief
   - Text styles matching the type scale
   - Component library: Cards, Badges, Buttons, Bottom Nav, AppBar variants, Progress components
   - All 7 screens at mobile (375px wide) and desktop (1280px wide)
   - Dark mode variants for all screens
2. **Asset exports** for any custom illustrations (empty states)
3. **Handoff notes** on any motion/animation timing not covered in this document

---

## 14. File & Code References

The developer will implement all designs in:
- `lib/core/theme/app_colors.dart` — color constants
- `lib/core/theme/app_theme.dart` — ThemeData (light + dark)
- `lib/core/theme/app_text_styles.dart` — text styles
- `lib/core/widgets/demo_scaffold.dart` — main demo page shell
- `lib/core/widgets/code_snippet_block.dart` — code editor surface
- `lib/core/widgets/property_table.dart` — property table in Learn tab
- `lib/features/home/home_screen.dart` — home screen

The app uses **Flutter Material 3** (`useMaterial3: true`). All `ColorScheme` seeds, `TextTheme`, and `AppBarTheme` are configured from `app_theme.dart`. Any colors provided should map to Material 3 color roles where applicable.

---

*Document generated from developer session — June 2026*  
*Developer: Irah | Stack: Flutter 3.x + Riverpod + GoRouter + SharedPreferences*
