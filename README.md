# Ushie Digital Resume

[![Flutter Version](https://img.shields.io/badge/Flutter-3.29.x-02569B?logo=flutter)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Stacked%20MVVM-42A5F5)](https://stacked.filledstacks.com)
[![Backend](https://img.shields.io/badge/Backend-Supabase%202.17.2-3ECF8E?logo=supabase)](https://supabase.com)
[![Hosting](https://img.shields.io/badge/Hosting-Vercel-000000?logo=vercel)](https://ushie-digital-resume.vercel.app/#/home-view)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**Ushie Digital Resume** is an enterprise-grade, cross-platform digital resume, executive consultancy showcase, and portfolio platform built with **Flutter**, the **Stacked MVVM Architecture**, **Google Sans Design System**, and **Supabase**.

It supports a full **Dual-Persona System** (`Personal Developer` vs. `Business Enterprise`) with interactive project showcases, real-time architecture inspection modals, printable A4 resume dialogs, Markdown/JSON CV downloads, and multi-flavor continuous delivery (`dev`, `staging`, `production`).

---

## 📱 Visual Showcase & Golden Snapshot Gallery

Below are the pixel-perfect visual snapshots captured directly by the automated golden test suite:

### Executive Dashboard Preview
<p align="center">
  <img src="images/view_dashboard.png" width="420" alt="Executive Resume Dashboard" style="border-radius: 18px; box-shadow: 0 8px 24px rgba(0,0,0,0.25);" />
</p>

---

### Core Application Views & Workflows

<table width="100%">
  <tr>
    <td align="center" width="50%">
      <img src="images/view_step1.png" width="380" alt="Onboarding Step 1 - Plan Selection" style="border-radius: 14px;" /><br/><br/>
      <b>View 1: Onboarding Plan Selection (<code>OnboardingView</code>)</b><br/>
      <sub>Interactive dual-track choice between Personal Developer and Business Studio plans with 3D avatar carousel and 1-tap login sheet.</sub>
    </td>
    <td align="center" width="50%">
      <img src="images/view_step4.png" width="380" alt="Onboarding Step 4 - Interests & Markets" style="border-radius: 14px;" /><br/><br/>
      <b>View 2: Target Markets & Interests (<code>OnboardingView</code>)</b><br/>
      <sub>Specialized interest tags for developers (Mobile, Cloud, AI) and enterprise target sectors for consultancies.</sub>
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <img src="images/view_explore.png" width="380" alt="Explore View - Project Catalog" style="border-radius: 14px;" /><br/><br/>
      <b>View 3: Project Showcase (<code>ExploreView</code>)</b><br/>
      <sub>Categorized portfolio items, category chips, live interactive heart counters, and architecture detail modals.</sub>
    </td>
    <td align="center" width="50%">
      <img src="images/view_dashboard.png" width="380" alt="Home Dashboard" style="border-radius: 14px;" /><br/><br/>
      <b>View 4: Executive Resume Dashboard (<code>HomeView</code>)</b><br/>
      <sub>Dual-persona header, Quick Contact action buttons, Experience timeline, Certifications, and A4/Markdown export.</sub>
    </td>
  </tr>
</table>

---

## 🏗️ Clean Entrypoint Architecture & IDE File Nesting

The entrypoint system under `lib/` has been consolidated to eliminate clutter and provide clear multi-environment flavor targeting. `lib/main_common.dart` has been removed in favor of a centralized bootstrap engine in `lib/main.dart`.

In VS Code and modern IDEs with file nesting enabled:
```
lib/
 ├── app/
 │    └── app.dart               <-- Unified App Barrel & Stacked Configuration
 │        ├── app.bottomsheets.dart
 │        ├── app.dialogs.dart
 │        ├── app.locator.dart
 │        ├── app.router.dart
 │        └── app_config.dart
 └── main.dart                   <-- Core App Engine & Default Bootstrap
     ├── main_dev.dart           <-- Development Flavor (Debug logs enabled)
     ├── main_staging.dart       <-- Staging Flavor (Pre-production testing)
     └── main_prod.dart          <-- Production Flavor (Optimized release)
```

### File Nesting Configuration (`.vscode/settings.json`)
File nesting is pre-configured in `.vscode/settings.json` so that flavor files nest under `main.dart`, Stacked components nest under `app.dart`, and `pubspec.lock` nests under `pubspec.yaml`:
```json
{
  "explorer.fileNesting.enabled": true,
  "explorer.fileNesting.expand": false,
  "explorer.fileNesting.patterns": {
    "main.dart": "main_*.dart",
    "app.dart": "app.*.dart, app_*.dart",
    "pubspec.yaml": "pubspec.lock, pubspec_overrides.yaml, .packages, .flutter-plugins*"
  }
}
```

### How Bootstrapping Works
1. **`lib/main.dart`**: Declares `bootstrapApp(AppConfig config)`, initializes dependency injection via `setupLocator()`, configures dialog and bottomsheet UI, loads cached user preferences from `PreferencesService`, and mounts `MainApp`.
2. **`lib/main_dev.dart`**: Configures dev endpoints and calls `bootstrapApp(AppConfig.instance)`.
3. **`lib/main_staging.dart`**: Configures staging endpoints and calls `bootstrapApp(AppConfig.instance)`.
4. **`lib/main_prod.dart`**: Configures production endpoints and calls `bootstrapApp(AppConfig.instance)`.

---

## 🔍 Complete View & Page Breakdown

### 1. `StartupView` (Splash & Initialization)
- **Path**: `lib/ui/views/startup/startup_view.dart`
- **Purpose**: Displays the launch screen with animated branding, initializes asynchronous singletons (`PreferencesService`, `NavigationService`), verifies connection to Supabase backend, and presents an environment flavor badge (`DEV`, `STAGING`, `PRODUCTION`).
- **Routing**: Automatically routes to `HomeView` if onboarding is complete, or `OnboardingView` for fresh installs.

### 2. `OnboardingView` (5-Step Setup Wizard)
- **Path**: `lib/ui/views/onboarding/onboarding_view.dart`
- **Step 1 (Plan Selection)**: Choose between **Personal Developer Plan** (freelancer, architect, engineer) or **Business Enterprise Plan** (digital agency, studio, consultancy). Features a selectable 3D avatar gallery and 1-tap Account Login bottom sheet.
- **Step 2 (Profile / Firm Form)**: Collects full name, executive title, biography, contact email, phone, location, GitHub profile, LinkedIn URL, and portfolio site URL.
- **Step 3 (Skills & Competencies Matrix)**: Multi-select interactive pills (Flutter, Dart, Stacked MVVM, Supabase, Cloud Architecture, DevOps, UI/UX).
- **Step 4 (Interests & Target Sectors)**: Specialized focus tags for personal developers and target business verticals (FinTech, HealthTech, Enterprise SaaS, AI/ML).
- **Step 5 (Visual Review & Finalization)**: Summary preview card, visual compliance score indicator, and one-tap completion trigger.

### 3. `HomeView` (Executive Resume Dashboard)
- **Path**: `lib/ui/views/home/home_view.dart`
- **Dual-Persona Profile Header**: Displays user avatar, full name, professional title, location badge, and executive summary bio.
- **Direct Contact Quick Actions**: One-click action buttons to launch Email (`mailto:`), Phone (`tel:`), GitHub (`url_launcher`), LinkedIn, and Portfolio Web.
- **Career Timeline / Work Experience**: Reverse-chronological experience list with company name, role, dates, description, and bulleted achievements.
- **Certifications Showcase**: Verified certificates with issuer tags, issue year, and credential verification links.
- **Skills Matrix & Hobbies**: Visual competency tags and personal interest chips.
- **Resume Export & Download**:
  - **A4 Printable Preview Dialog**: Full-screen modal simulating an A4 printed curriculum vitae.
  - **Markdown Export**: One-tap export to download the complete resume as a formatted `.md` file.

### 4. `ExploreView` (Interactive Project Showcase)
- **Path**: `lib/ui/views/explore/explore_view.dart`
- **Live Search & Filter**: Real-time search query filtering and horizontal category chips (`All`, `Mobile`, `Web`, `Architecture`, `Enterprise`).
- **Showcase Project Cards**: Banner images, title, category badge, description, metric counters (e.g. *99.9% Crash-free*, *100k+ Users*), and tech stack pills.
- **Interactive Heart Counter**: Tap to like projects with real-time UI count increments.
- **Architecture Inspection Modal**: Tap "View Architecture" to open a bottom sheet showing system design, state management approach, backend integrations, and test coverage metrics.

### 5. `SettingsView` (Preferences & Flavor Diagnostics)
- **Path**: `lib/ui/views/settings/settings_view.dart`
- **Persona Quick Switcher**: 1-click toggle between Personal and Business profiles.
- **Display Preferences**: Dark Mode theme toggle.
- **System Controls**: Push notification preferences and crash telemetry opt-in.
- **Data Management**: Export local profile data as JSON for backup or migration.
- **Environment Diagnostics**: Active flavor banner displaying current environment (`dev`, `staging`, `production`), API base URL, and build version.

---

## 🌐 Live Deployments & URLs

- **Live Web App (Direct Route)**: [`https://ushie-digital-resume.vercel.app/#/home-view`](https://ushie-digital-resume.vercel.app/#/home-view)
- **Live Production Domain**: [`https://ushie-digital-resume.vercel.app`](https://ushie-digital-resume.vercel.app)
- **Staging Web App**: [`https://staging-ushie-digital-resume.vercel.app`](https://staging-ushie-digital-resume.vercel.app)
- **Live Supabase Endpoint**: `https://qoioeymizjtlfoqmeaut.supabase.co` (`eu-west-1`)

---

## 🛠️ Build & Flavor Execution Commands

Run the application targeting specific flavors:

```bash
# 1. Default (Dev configuration)
flutter run -t lib/main.dart

# 2. Development Flavor
flutter run -t lib/main_dev.dart --flavor dev

# 3. Staging Flavor
flutter run -t lib/main_staging.dart --flavor staging

# 4. Production Flavor
flutter run -t lib/main_prod.dart --flavor prod
```

---

## 🧪 Quality Gate & Automated Testing

All unit tests and golden visual tests are verified before deployment:

```bash
# Analyze static code quality (0 issues required)
flutter analyze

# Execute full automated test suite & golden snapshots
flutter test
```

### Verified Test Suite
- `OnboardingView - Step 1 Plan Selection` (Golden) — **PASSED**
- `OnboardingView - Step 4 Interest Selection` (Golden) — **PASSED**
- `ExploreView - Project Showcase` (Golden) — **PASSED**
- `HomeView - Executive Resume Dashboard` (Golden) — **PASSED**
- `ExploreViewModelTest` (Unit Tests) — **PASSED**
- `HomeViewModelTest` (Unit Tests) — **PASSED**
- `NoticeSheetModelTest` (Unit Tests) — **PASSED**
- `InfoAlertDialogModelTest` (Unit Tests) — **PASSED**
