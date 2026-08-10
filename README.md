# Elysian Mobile Portfolio & Enterprise Showcase

A premium, cross-platform mobile application and interactive digital resume built using **Flutter**, **Stacked Architecture (MVVM)**, and **Google Sans Design System**.

---

## 📱 Main Application View

Below is a preview of the main profile dashboard view of the application:

<p align="center">
  <img src="images/app_preview.png" alt="Elysian Main Profile Dashboard View" width="360" style="border-radius: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.15);" />
</p>

---

## 🖼️ 4 Screen UI View Showcase

Here is a visual overview of the 4 core Flutter view screens featured in the application:

<table align="center">
  <tr>
    <td align="center" width="50%">
      <img src="images/view_step1.png" alt="View 1: Onboarding Plan Selection (OnboardingView)" width="320" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.12);" /><br/>
      <b>View 1: Onboarding Plan Selection (<code>OnboardingView</code>)</b><br/>
      <sub>Personal vs Business plan choice, empty demo avatar, and touch login prompt.</sub>
    </td>
    <td align="center" width="50%">
      <img src="images/view_step4.png" alt="View 2: Interest & Industry Matching (OnboardingView)" width="320" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.12);" /><br/>
      <b>View 2: Interest & Industry Matching (<code>OnboardingView</code>)</b><br/>
      <sub>Interactive category grid for personal interests and business target markets.</sub>
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <img src="images/view_explore.png" alt="View 3: Explore Showcase (ExploreView)" width="320" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.12);" /><br/>
      <b>View 3: Explore Showcase (<code>ExploreView</code>)</b><br/>
      <sub>Real-time search query, category filter chips, and project cards.</sub>
    </td>
    <td align="center" width="50%">
      <img src="images/view_dashboard.png" alt="View 4: Main Profile Dashboard (HomeView)" width="320" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.12);" /><br/>
      <b>View 4: Main Profile Dashboard (<code>HomeView</code>)</b><br/>
      <sub>User avatar, skills summary, interest chips, and bottom navigation bar.</sub>
    </td>
  </tr>
</table>

---

## 🚀 Live Interactive Simulator (Appetize)

Experience the app directly in your browser using our updated Appetize live simulator.

👉 **[Launch Appetize Live Simulator](https://appetize.io/app/7mjyuwqd2vzynitzuaoifila4u?device=pixel4&osVersion=11.0&scale=75)**

### Simulator Configuration
- **Device:** Pixel 4 / Pixel 7
- **OS Version:** Android 11.0 / 13.0
- **Scale:** 75%

### Interactive Simulator Walkthrough:
1. Click the link above to launch the Appetize window.
2. Click **"Tap to Start"** to boot the application.
3. Experience the initial **Startup Splash Sequence** (`StartupView`).
4. Walk through the interactive **Onboarding Setup Wizard** (`OnboardingView`):
   - Select your Plan (**Personal** / **Business**).
   - Tap **"Already have an account?"** to display a floating paste text tooltip and pop up the **1-Tap Account Login Sheet**.
   - Fill in your custom profile details starting from a blank initial state.
   - Pick your avatar (starts with empty demo profile icon avatar, or choose preset 3D spatial avatars).
   - Match your technical skills and industry target markets.
5. In Business workflow, review the **Elysian Visual Directory** (`SCREEN_14`, `SCREEN_2`, `SCREEN_10`, `SCREEN_9`) and export brand assets.
6. Seamlessly switch between **Explore**, **My Profile**, and **Settings** tabs at the bottom.

---

## ✨ Features & Capabilities

- **Tailored Workflows:** Choose between a **Personal Profile** (for developers/designers) or a **Business Profile** (for teams/agencies).
- **Interactive Login Sheet:** 1-tap sign-in to pre-configured profiles or enter custom credentials.
- **Empty Profile Demo Avatar:** Starts with a neutral vector profile avatar at index 0, alongside camera capture and device gallery options.
- **Visual Asset Directory:** Dedicated Business Step 5 showcase displaying brand assets, compliance indicators, and asset export actions.
- **Explore Tab:** Real-time search and category filter chips.
- **Settings & Preferences:** Switch Dark Mode, toggle Push Notifications, and adjust telemetry preferences.
- **Environment Detection:** Settings view displays the current build flavor (`Dev` / `Prod`) and API base URL.

---

## 🛠️ Codebase Architecture

This project is built using:
- **[Flutter](https://flutter.dev):** Cross-platform mobile framework.
- **[Stacked Architecture](https://pub.dev/packages/stacked):** View-ViewModel-Model pattern, dependency injection, and clean state management.
- **[stacked_services](https://pub.dev/packages/stacked_services):** NavigationService and DialogService.

---

## 🧪 Golden Tests & Verification

Golden tests are configured to verify UI view layout consistency across all changes.

To run the unit tests and generate/update golden screenshots:

```bash
flutter test --update-goldens
```

*Golden baseline snapshots are stored under `test/golden/goldens/`.*
