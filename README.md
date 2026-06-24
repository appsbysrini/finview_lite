# FinView Lite

A Flutter investment dashboard that lets users visualise their portfolio, asset allocation, and returns using local mock data. Built as a minimal wealth-app experience with responsive design and clean UX.

---

## Screenshots

| Dashboard (Light)                         | Dashboard (Dark)                        |
| ----------------------------------------- | --------------------------------------- |
| ![light](screenshots/dashboard_light.png) | ![dark](screenshots/dashboard_dark.png) |

> Screenshots are taken on an iPhone 15 Pro simulator. On tablets and web (≥ 600 px) the allocation chart and holdings list render side by side.

---

## Demo recording

[Watch screen recording](https://drive.google.com/file/d/1OH1cOK2cbfq15qdZcfgcZPVkRrc4prDb/view?usp=sharing)

---

## Setup

### Prerequisites

| Tool        | Minimum version                               |
| ----------- | --------------------------------------------- |
| Flutter SDK | 3.29.0                                        |
| Dart SDK    | 3.12.2 (bundled with Flutter)                 |
| IDE         | VS Code or Android Studio with Flutter plugin |

Verify your environment:

```bash
flutter doctor
```

### Install and run

```bash
# 1. Clone the repository
git clone https://github.com/<your-username>/finview_lite.git
cd finview_lite

# 2. Fetch dependencies
flutter pub get

# 3. Run in debug mode — choose a connected device or emulator
flutter run

# 4. Run on web
flutter run -d chrome
```

### Run tests

```bash
flutter test
```

### Analyse

```bash
flutter analyze
```

---

## Mock login credentials

```
Username : aarav
PIN      : 1234
```

Session is persisted via SharedPreferences — you stay logged in across restarts until you tap Sign Out.

---

## Features

### Core dashboard

- **Portfolio header** — owner name, total current value (₹), gain/loss pill (₹ and %), plus a stats row showing total return %, invested value, and number of holdings.
- **Allocation chart** — donut pie chart (fl_chart) with a centre total label and a side-by-side legend showing symbol, allocation %, and ₹ value per holding.
- **Holdings list** — per-holding card with ticker avatar (colour-coded per symbol), company name, current value, and gain/loss return.
- **Sort controls** — segmented button to sort holdings by Value, Gain, or Name.
- **Return toggle** — ₹ / % segmented button; switching animates the gain pill on each row via `AnimatedSwitcher`.
- **Empty and error states** — dedicated full-screen views for load failure, empty holdings, and zero-value allocation.

### Bonus features

| Feature        | Details                                                                      |
| -------------- | ---------------------------------------------------------------------------- |
| Dark mode      | Persisted via SharedPreferences; toggled from the app bar                    |
| Mock login     | PIN-based auth with form validation and session persistence                  |
| Manual refresh | Pull-to-refresh or app-bar spinner; simulates ±3% price movement per holding |

---

## UI layout (text diagram)

```
┌─────────────────────────────────────┐
│  FinView                🌙  logout  │  ← App bar (DashboardHeader)
├─────────────────────────────────────┤
│  Aarav Patel                        │
│  ₹1,09,640                          │  ← Portfolio value (PortfolioHeader)
│  +₹5,800 (+5.3%)                    │  ← Gain pill
│  ─────────────────────────────────  │
│  +5.3%   ₹1,03,840   8 holdings    │  ← Stats row
├─────────────────────────────────────┤
│  Allocation                         │
│  ┌─────────────────────────────┐   │
│  │   [Donut chart + legend]    │   │  ← AllocationChart (fl_chart)
│  └─────────────────────────────┘   │
├─────────────────────────────────────┤
│  Holdings                  ₹  /  % │  ← ReturnToggle
│  [ Value ]  [ Gain ]  [ Name ]     │  ← SortControls
│  ┌─────────────────────────────┐   │
│  │ HD  HDFCBANK   ₹25,800     │   │  ← HoldingCard (staggered animation)
│  │     HDFC Bank  +₹1,800     │   │
│  │ ─────────────────────────  │   │
│  │ RE  RELIANCE   ₹21,680     │   │
│  │     Reliance   +₹2,480     │   │
│  │ ─────────────────────────  │   │
│  │ …                          │   │
│  └─────────────────────────────┘   │
└─────────────────────────────────────┘
```

On tablets and web (≥ 600 px width) the allocation section and holdings list render in two columns side by side.

---

## Mock data

`assets/portfolio.json` contains 8 holdings covering all meaningful scenarios:

| Symbol     | Name                   | Scenario                                          |
| ---------- | ---------------------- | ------------------------------------------------- |
| TCS        | Tata Consultancy       | Positive gain                                     |
| INFY       | Infosys Ltd            | Positive gain                                     |
| RELIANCE   | Reliance Industries    | Positive gain                                     |
| HDFCBANK   | HDFC Bank              | Positive gain                                     |
| WIPRO      | Wipro Ltd              | **Negative gain (loss)**                          |
| ADANIPORTS | Adani Ports & SEZ      | **Negative gain (loss)**                          |
| ZOMATO     | Zomato Ltd             | **Zero gain** (avg cost = current price)          |
| IRFC       | Indian Railway Finance | **Zero units** (exercises division-by-zero guard) |

---

## Dependencies

### Production

| Package              | Version | Purpose                                     |
| -------------------- | ------- | ------------------------------------------- |
| `flutter_riverpod`   | ^3.3.2  | State management                            |
| `fl_chart`           | ^1.2.0  | Donut allocation chart                      |
| `google_fonts`       | ^6.2.1  | Inter typeface                              |
| `shared_preferences` | ^2.5.3  | Login session and theme persistence         |
| `intl`               | ^0.19.0 | Indian-locale number formatting (₹1,09,640) |

### Dev / test only

| Package          | Purpose                                     |
| ---------------- | ------------------------------------------- |
| `flutter_test`   | Unit and widget tests                       |
| `flutter_lints`  | Linting rules                               |
| `device_preview` | Responsive QA across simulated screen sizes |

---

## Project structure

```
lib/
├── main.dart
├── models/
│   ├── allocation_slice.dart
│   ├── holding.dart
│   └── user_portfolio.dart
├── providers/
│   ├── allocation_provider.dart
│   ├── auth_provider.dart
│   ├── login_provider.dart
│   ├── portfolio_provider.dart
│   ├── portfolio_refresh_provider.dart
│   ├── return_toggle_provider.dart
│   ├── sort_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── dashboard_screen.dart
│   └── login_screen.dart
├── utils/
│   ├── allocation_builder.dart
│   ├── animation_constants.dart
│   ├── app_design_tokens.dart   ← FinViewColors ThemeExtension
│   ├── app_themes.dart
│   ├── formatters.dart          ← intl Indian-Rupee formatter
│   ├── gain_display.dart
│   ├── holding_sorter.dart
│   ├── json_parser.dart
│   ├── layout_constants.dart
│   ├── portfolio_simulator.dart
│   └── prefs_keys.dart
└── widgets/                     ← 20 extracted widget files

test/
├── helpers/
│   ├── test_data.dart
│   └── widget_test_helpers.dart
├── models/
├── providers/
├── utils/
└── widgets/
```

---

## Architecture notes

- **State**: All state via `flutter_riverpod` — `AsyncNotifierProvider` for async data (portfolio, auth, theme mode), `StateProvider` for simple enum/bool toggles (sort order, return display mode, refresh flag). No `setState`, `ChangeNotifier`, or BLoC.
- **Responsiveness**: `ResponsiveLayout` uses `LayoutBuilder` (not `MediaQuery.size`) for correct widget-level breakpoints at 600 px.
- **Design system**: `FinViewColors` is a `ThemeExtension` carrying semantic profit/loss and chart palette colours for both light and dark themes, accessed via `Theme.of(context).finView`.
- **Typography**: All financial numerals use `FontFeature.tabularFigures()` to prevent digit-width jitter when values change.
- **Animations**: Staggered `AnimatedAppearance` on all dashboard sections, `AnimatedChartEntrance` (scale + fade) on the pie chart, and `AnimatedSwitcher` on gain pills when the ₹/% toggle changes.
