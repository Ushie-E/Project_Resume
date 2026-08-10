# Elysian Mobile Portfolio & Enterprise Showcase

A premium, cross-platform mobile application and interactive digital resume built using **Flutter**, **Stacked Architecture (MVVM)**, and **Google Sans Design System**.

---

## 📱 4-Screen Design Showcase

Here is a visual overview of the 4 core workflow screens featured in the latest design architecture:

<table align="center">
  <tr>
    <td align="center" width="50%">
      <img src="images/spacea.png" alt="Screen 1: Startup Splash Sequence" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 1: Startup Splash Sequence</b><br/>
      <sub>Brand splash sequence with progressive loading & initialization.</sub>
    </td>
    <td align="center" width="50%">
      <img src="images/spacec.png" alt="Screen 2: Interactive Onboarding & Login Sheet" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 2: Interactive Onboarding & Login Sheet</b><br/>
      <sub>Personal vs. Business setup, empty demo avatar, and account login sheet.</sub>
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <img src="images/spaced.png" alt="Screen 3: Visual Asset Directory (Business Step 5)" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 3: Visual Asset Directory</b><br/>
      <sub>Elysian brand asset showcase, compliance indicator, and asset export actions.</sub>
    </td>
    <td align="center" width="50%">
      <img src="images/spacee.png" alt="Screen 4: Multi-Tab Dashboard & Explore View" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 4: Multi-Tab Dashboard</b><br/>
      <sub>My Profile, Explore Showcase, category filtering, and Settings preferences.</sub>
    </td>
  </tr>
</table>

---

## 🚀 Appetize Live Interactive Simulator

Experience the application live in your web browser with the updated design flow:

👉 **[Launch Appetize Live Simulator](https://appetize.io/app/7mjyuwqd2vzynitzuaoifila4u?device=pixel4&osVersion=11.0&scale=75)**

### Simulator Configuration
- **Target Device:** Pixel 4 / Pixel 7
- **OS Version:** Android 11.0 / 13.0
- **Display Scale:** 75%

### Appetize Interactive Flow:
1. **Startup Splash Screen**: Launch the simulator to view the animated brand splash screen (`StartupView`).
2. **Onboarding & Plan Selection (`Step 1`)**:
   - Choose between **Personal** (individual developer/designer) or **Business** (enterprise agency/firm).
   - Tap **"Already have an account?"** to open the 1-tap **Account Login Sheet** and view pre-configured profiles.
3. **Blank Form Setup (`Step 2 - 4`)**:
   - Fill in your custom details starting from a blank initial state with placeholder hints.
   - Pick your avatar (starting with the neutral empty demo profile avatar, or select preset 3D spatial avatars).
4. **Visual Directory (`Business Step 5`)**:
   - View the visual directory layout featuring asset cards (`SCREEN_14`, `SCREEN_2`, `SCREEN_10`, `SCREEN_9`), visual compliance indicator (75%), and brand asset export options.
5. **Main Multi-Tab Dashboard**:
   - Seamlessly navigate between **Explore**, **My Profile**, and **Settings** tabs via the bottom navigation bar.

---

## ✨ Features & Architecture

- **Clean Stacked MVVM Architecture**: Separates UI (`StackedView`) from presentation logic (`BaseViewModel`) and services (`NavigationService`, `DialogService`).
- **Modular View Directory**:
  - `lib/ui/views/startup/`: Initial splash screen entry route.
  - `lib/ui/views/onboarding/`: 5-step interactive onboarding wizard with Personal vs. Business paths.
  - `lib/ui/views/home/`: Tab controller managing top-level views via `IndexedStack`.
  - `lib/ui/views/explore/`: Live search query & category filter showcase.
  - `lib/ui/views/settings/`: Dark mode toggle, notifications preference, and build flavor environment detection.
- **Smart Bottom Navigation Bar Visibility**: Automatically hidden during Onboarding steps 1–5, active exclusively on main dashboard views.
- **Empty Profile Demo Avatar**: Starts with a neutral vector profile avatar at position 0, alongside camera capture and device gallery options.
- **1-Tap Account Login Sheet**: Touch trigger on "Already have an account?" text button displays a paste text tooltip and pops up account profiles.

---

## 🛠️ Project Directory Tree

```
lib/
├── app/
│   ├── app.dart              # Stacked app route & dialog definitions
│   ├── app.locator.dart      # Dependency injection locator
│   ├── app.router.dart       # Generated route navigation
│   └── app_config.dart       # Build flavor environment configuration
├── main_common.dart          # App entrypoint with initialRoute: StartupView
├── main_dev.dart             # Development flavor runner
├── main_prod.dart            # Production flavor runner
└── ui/
    ├── common/               # Design tokens, colors, & typography
    └── views/                # Modular view components
        ├── explore/          # ExploreView & ExploreViewModel
        ├── home/             # HomeView & HomeViewModel
        ├── onboarding/       # OnboardingView & OnboardingViewModel
        ├── settings/         # SettingsView & SettingsViewModel
        └── startup/          # StartupView & StartupViewModel
```

---

## 🧪 Testing & Verification

Golden tests and unit tests verify layout consistency and business logic across all views.

```bash
# Run unit tests & golden snapshot updates
flutter test --update-goldens

# Run static code analysis
flutter analyze
```

*All 14/14 automated unit and golden tests pass with 0 static analysis issues.*
