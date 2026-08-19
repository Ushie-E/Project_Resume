# Ushie Mobile Portfolio & Enterprise Showcase

A premium, cross-platform mobile application and interactive digital resume built using **Flutter**, **Stacked Architecture (MVVM)**, and **Google Sans Design System**.

## 🖼️ 4 Screen UI View Showcase

Here is a visual overview of the 4 core Flutter view screens featured in the application:

<table align="center">
  <tr>
    <td align="center">
      <img width="498" height="523" alt="image" src="https://github.com/user-attachments/assets/4fec4182-6737-4c36-a033-0a1d83a38cac" />
    </td>
    <td align="center">
      <img width="485" height="882" alt="image" src="https://github.com/user-attachments/assets/a31a344a-14bc-423e-981a-1f8ee46c7f34" />
    </td>
  </tr>
  <tr>
    <td align="center">
      <img width="499" height="880" alt="image" src="https://github.com/user-attachments/assets/61504e6c-9199-49d8-8c0d-541c4b6b7f51" />
    </td>
    <td align="center">
      <img width="484" height="880" alt="image" src="https://github.com/user-attachments/assets/5d302246-c122-43e8-a2cb-84b5e502cab1" />
    </td>
  </tr>
</table>

---

Below is a preview of the main profile dashboard view of the application:

<p align="center">
 <img width="496" height="871" alt="image" src="https://github.com/user-attachments/assets/e28c8029-89a4-4aa6-b62a-b39586ebb62a" />
</p>

---

---

## 📱 Main Application View

4-Screen Design Showcase

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
