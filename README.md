# Ushie Portfolio

A premium, interactive portfolio and digital resume mobile application built using Flutter and Stacked Architecture.

---

## 📱 App Preview

Below is a preview of the main profile view of the application:

<p align="center">
  <img src="images/app_preview.png" alt="Ushie Portfolio Profile View" width="360" style="border-radius: 20px; box-shadow: 0 4px 15px rgba(0,0,0,0.15);" />
</p>

---

## 🚀 Live Interactive Simulator (Appetize)

Experience the app directly in your browser using our interactive Appetize simulator.

👉 **[Launch Appetize Live Simulator](https://appetize.io/app/7mjyuwqd2vzynitzuaoifila4u?device=pixel4&osVersion=11.0&scale=75)**

### Simulator Configuration
- **Device:** Pixel 4
- **OS Version:** Android 11.0
- **Scale:** 75%

### How to use:
1. Click the link above to open the Appetize window.
2. Click **"Tap to Start"** to boot the simulator.
3. Walk through the interactive **Onboarding Setup Wizard**:
   - Select your Plan (Personal / Business).
   - Enter your profile details.
   - Choose your technical capabilities/skills.
   - Match your interests/industries.
4. View your customized profile on the dynamic **My Profile Dashboard**.
5. Switch between **Explore**, **My Profile**, and **Settings** tabs at the bottom.

---

## ✨ Features & Capabilities

- **Tailored Onboarding Wizard:** Choose between a **Personal Profile** (for developers/designers) or a **Business Profile** (for teams/agencies).
- **Interactive Forms:** Fully validated profile/company input setup screens.
- **Skill & Interest Customization:** Dynamic chips that reflect selected expertise.
- **Explore Tab:** Interactive project grids.
- **Settings & Preferences:** Switch Dark Mode, toggle Push Notifications, and adjust telemetry preferences.
- **Environment Detection:** Settings view displays the current build flavor and API environment.

---

## 🛠️ Codebase & Architecture

This project is built using:
- **[Flutter](https://flutter.dev):** Cross-platform mobile development framework.
- **[Stacked Architecture](https://pub.dev/packages/stacked):** Separation of concerns (View-ViewModel-Model pattern), dependency injection, and clean state management.
- **[stacked_services](https://pub.dev/packages/stacked_services):** Quick navigation, snackbars, and bottom sheet dialogs.
- **[rflutter_alert](https://pub.dev/packages/rflutter_alert):** Polished pop-up dialogs and alerts.

---

## 🧪 Golden Tests

Golden tests are configured to verify layout consistency across changes.

To run the tests and update/generate the golden images:

```bash
flutter test --update-goldens
```

*The golden screenshots are generated and stored under `test/golden/goldens/`.*

