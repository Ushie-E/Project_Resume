# Ushie Digital Resume

[![Flutter Version](https://img.shields.io/badge/Flutter-3.29.x-02569B?logo=flutter)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Stacked%20MVVM-42A5F5)](https://stacked.filledstacks.com)
[![Backend](https://img.shields.io/badge/Backend-Supabase%202.17.2-3ECF8E?logo=supabase)](https://supabase.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**Ushie Digital Resume** is an all-in-one developer resume, executive consultancy showcase, and enterprise digital studio platform built with **Flutter**, **Stacked MVVM**, and **Supabase**.

It combines dynamic personal developer resumes, executive consultancy portfolios, enterprise design studio directories, and high-performance mobile features into a unified cross-platform application.

---

## 🌟 Key Product Features

- **Personal Developer Resume**: Dynamic skills matrix, bio, project portfolio, and curated interests.
- **Executive Consultancy & Agency Showcase**: Team size, company overview, target industry sectors, enterprise capabilities, and SLA support specs.
- **Ushie Digital Brand Studio**: Asset cards (`SCREEN_14`, `SCREEN_2`, `SCREEN_10`, `SCREEN_9`), visual compliance indicator (75%), and brand asset export actions.
- **1-Tap Account Login System**: Instant profile access for registered personal (`Ushie Emmanuel`) & business (`Ushie Tech Labs`) accounts.
- **Supabase Cloud Backend (`supabase_flutter 2.17.2`)**: Real-time authentication, profiles database sync, and project showcase storage.
- **Multi-Platform Support**: Configured for both **Android** and **iOS** native builds.

---

## 📱 App Showcase & UI View Gallery

![Main App Preview](images/app_preview.png)

<table width="100%">
  <tr>
    <td align="center" width="50%">
      <img src="images/view_step1.png" alt="View 1: Onboarding Plan Selection (OnboardingView)" width="320" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.12);" /><br/>
      <b>View 1: Onboarding Plan Selection (<code>OnboardingView</code>)</b><br/>
      <sub>Personal vs. Business setup, 1-Tap Login trigger, and floating paste tooltip.</sub><br/><br/>
      <img src="images/spacea.png" alt="Screen 1: Spatial Serenity & Profile Header" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 1: Spatial Serenity & Profile Hero</b><br/>
      <sub>Primary background asset and initial profile hero card.</sub>
    </td>
    <td align="center" width="50%">
      <img src="images/view_step4.png" alt="View 2: Target Markets & Interests (OnboardingView)" width="320" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.12);" /><br/>
      <b>View 2: Target Markets & Interests (<code>OnboardingView</code>)</b><br/>
      <sub>Curated interests grid for personal developers & target market selection for firms.</sub><br/><br/>
      <img src="images/spacec.png" alt="Screen 2: Organic Rhythm & Business Setup" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 2: Organic Rhythm & Business Setup</b><br/>
      <sub>Background layering component for onboarding focus areas.</sub>
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
      <img src="images/view_explore.png" alt="View 3: Explore Showcase (ExploreView)" width="320" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.12);" /><br/>
      <b>View 3: Explore Showcase (<code>ExploreView</code>)</b><br/>
      <sub>Search query bar, horizontal category filter chips, and project cards.</sub><br/><br/>
      <img src="images/spaced.png" alt="Screen 3: Structural Clarity & Finalization" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 3: Structural Clarity & Finalization</b><br/>
      <sub>Header image component for the final review phase.</sub>
    </td>
    <td align="center" width="50%">
      <img src="images/view_dashboard.png" alt="View 4: Main Profile Dashboard (HomeView)" width="320" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.12);" /><br/>
      <b>View 4: Main Profile Dashboard (<code>HomeView</code>)</b><br/>
      <sub>User avatar, skills summary, interest chips, and bottom navigation bar.</sub><br/><br/>
      <img src="images/spacee.png" alt="Screen 4: Multi-Tab Dashboard & Explore View" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 4: Multi-Tab Dashboard</b><br/>
      <sub>My Profile, Explore Showcase, category filtering, and Settings preferences.</sub>
    </td>
  </tr>
</table>

---

## 🚀 Live Web & Simulator Preview (Appetize)

Test **Ushie Digital Resume** live in your browser:

👉 **[Launch Appetize Interactive Live Simulator](https://appetize.io/app/demo-ushie-digital-resume)**

---

## 🛠️ Build & Flavor Configurations

- **Dev Environment**: `flutter run -t lib/main_dev.dart --flavor dev`
- **Prod Environment**: `flutter run -t lib/main_prod.dart --flavor prod`

---

## 🧪 Quality Assurance & Test Verification

```bash
# Run Static Code Analysis
flutter analyze

# Run Automated Test Suite & Goldens
flutter test
```
