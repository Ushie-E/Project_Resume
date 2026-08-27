# Ushie Digital Resume

[![Flutter Version](https://img.shields.io/badge/Flutter-3.29.x-02569B?logo=flutter)](https://flutter.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Stacked%20MVVM-42A5F5)](https://stacked.filledstacks.com)
[![Backend](https://img.shields.io/badge/Backend-Supabase%202.17.2-3ECF8E?logo=supabase)](https://supabase.com)
[![Domain](https://img.shields.io/badge/Domain-resume.us00.co-00C853)](https://resume.us00.co)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

**Ushie Digital Resume** is cross-platform mobile application and interactive digital and an all-in-one personal developer resume, executive consultancy showcase, and enterprise digital studio platform built with **Flutter**, **Stacked Architecture MVVM**, and **Google Sans Design System**//**Supabase**.

---
A premium, built using **Flutter**, **Stacked  (MVVM)**, and **.

## 📱 Primary UI Design & Visual Asset Directory Preview

Below is the primary visual asset directory preview image provided for the application:

<p align="center">
<img width="492" height="923" alt="image" src="https://github.com/user-attachments/assets/d8d0990a-bd51-4a8e-bbd8-4e0e3aae23c2" />
</p>
---

## 🖼️ Application View & Screen Showcase Table

<table width="100%">
  <tr>
    <td align="center" width="50%">
      <img width="498" height="523" alt="image" src="https://github.com/user-attachments/assets/4fec4182-6737-4c36-a033-0a1d83a38cac" />
      <b>View 1: Onboarding Plan Selection (<code>OnboardingView</code>)</b><br/>
      <sub>Personal vs. Business setup, 1-Tap Login trigger, and floating paste tooltip.</sub><br/><br/>
      <img width="485" height="882" alt="image" src="https://github.com/user-attachments/assets/a31a344a-14bc-423e-981a-1f8ee46c7f34" />
      <b>Screen 1: Spatial Serenity & Profile Hero</b><br/>
      <sub>Primary background asset and initial profile hero card.</sub>
    </td>
    <td align="center" width="50%">
     <img width="484" height="880" alt="image" src="https://github.com/user-attachments/assets/5d302246-c122-43e8-a2cb-84b5e502cab1" />
      <b>View 2: Target Markets & Interests (<code>OnboardingView</code>)</b><br/>
      <sub>Curated interests grid for personal developers & target market selection for firms.</sub><br/><br/>
       <img width="499" height="880" alt="image" src="https://github.com/user-attachments/assets/61504e6c-9199-49d8-8c0d-541c4b6b7f51" />
      <b>Screen 2: Organic Rhythm & Business Setup</b><br/>
      <sub>Background layering component for onboarding focus areas.</sub>
    </td>
  </tr>
  <tr>
    <td align="center" width="50%">
     <img width="487" height="872" alt="image" src="https://github.com/user-attachments/assets/513fd250-f00a-4eda-b0cd-d8d4bae379b0" />
      <b>View 3: Explore Showcase (<code>ExploreView</code>)</b><br/>
      <sub>Search query bar, horizontal category filter chips, and project cards.</sub><br/><br/>
      <img src="images/spaced.png" alt="Screen 3: Structural Clarity & Finalization" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 3: Structural Clarity & Finalization</b><br/>
      <sub>Header image component for the final review phase.</sub>
    </td>
    <td align="center" width="50%">
      <img width="487" height="872" alt="image" src="https://github.com/user-attachments/assets/6b435500-ebc1-46b8-bf43-8e74c8e0e1f2" />
      <b>View 4: Main Profile Dashboard (<code>HomeView</code>)</b><br/>
      <sub>User avatar, skills summary, interest chips, and bottom navigation bar.</sub><br/><br/>
      <img src="images/spacee.png" alt="Screen 4: Multi-Tab Dashboard & Explore View" width="340" style="border-radius: 16px; box-shadow: 0 4px 12px rgba(0,0,0,0.15);" /><br/>
      <b>Screen 4: Multi-Tab Dashboard</b><br/>
      <sub>My Profile, Explore Showcase, category filtering, and Settings preferences.</sub>
    </td>
  </tr>
</table>

---

## 🌐 Custom Web Domain & Supabase Cloud Endpoints

- **Live Web Application Domain**: [`https://resume.us00.co`](https://resume.us00.co)
- **Production API Endpoint**: `https://api.resume.us00.co`
- **Free GitHub Pages Sub-Domain**: `https://YOUR_GITHUB_USERNAME.github.io/Project_Resume/`
- **Live Supabase Database**: `https://qoioeymizjtlfoqmeaut.supabase.co` (`eu-west-1`)

---

## 🔍 Detailed Application Views & Feature Breakdown

| View Name | Primary Function | Features & User Interactions |
| :--- | :--- | :--- |
| **`StartupView`** | Boot & Splash | Initializing locator services, verifying local cache, and connecting Supabase SDK. |
| **`OnboardingView` (Step 1)** | Welcome & Plan Choice | Interactive choice between Personal Developer Plan and Business Enterprise Plan. Features empty demo avatar selection, spatial 3D avatars, and 1-tap Account Login Sheet. |
| **`OnboardingView` (Step 2)** | Profile / Firm Form | Personal: Full Name, Professional Title, Bio, Location.<br/>Business: Company Name, Industry Sector, Team Size, HQ Location, Overview. |
| **`OnboardingView` (Step 3)** | Skills Matrix | Technical skills selection (Flutter, Dart, Stacked, APIs) vs. Enterprise Capabilities (Custom Software, Cloud Architecture, UI/UX Strategy, SLA 24/7). |
| **`OnboardingView` (Step 4)** | Interests & Markets | Personal interest chips vs. Target Industry Sectors (Enterprise Tech, Architecture & Real Estate, FinTech, Healthcare). |
| **`OnboardingView` (Step 5)** | Review & Directory | Personal summary review card vs. **Ushie Digital Visual Directory** (`SCREEN_14`, `SCREEN_2`, `SCREEN_10`, `SCREEN_9`), visual compliance indicator (75%), and asset export actions. |
| **`ExploreView`** | Project Catalog | Search query bar, horizontal category filter chips (`All`, `Architecture`, `Mobile`, `UI/UX`, `DevOps`), project like counters, and tag badges. |
| **`HomeView`** | Main Dashboard | Executive gradient banner, dynamic title (`My Profile` vs. `Company Profile`), interactive skills grid, interest badges, and edit setup trigger. |
| **`SettingsView`** | Preferences & Flavors | Dark Mode toggle, Push Notifications toggle, Telemetry toggle, and Build Flavor Environment detection (`Dev` / `Staging` / `Prod`). |

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
