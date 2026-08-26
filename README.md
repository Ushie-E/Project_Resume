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

## 📱 App Showcase & 4 UI View Screenshots

![Main App Preview](images/app_preview.png)

### 4 Actual Flutter UI View Showcase (2x2 Grid)

| Onboarding & Plan Selection | Target Markets & Interests |
| :---: | :---: |
| ![View 1: Onboarding Step 1](images/view_step1.png) | ![View 2: Onboarding Step 4](images/view_step4.png) |
| **Step 1 Plan Choice & Login** | **Step 4 Target Market Matching** |

| Explore Project Showcase | Main Profile Dashboard |
| :---: | :---: |
| ![View 3: Explore Showcase](images/view_explore.png) | ![View 4: Main Profile Dashboard](images/view_dashboard.png) |
| **Tab 1: Explore Projects** | **Tab 2: My Profile & Company Dashboard** |

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
