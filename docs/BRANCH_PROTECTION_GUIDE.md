# 🛡️ GitHub Repository Branch Protection Guide

This guide details how to configure **Enterprise-Grade Branch Protection** on the `main` branch of `Project_Resume`.

---

## 🎯 Goal
Prevent accidental direct pushes to `main`, require all changes to undergo Pull Request review, and mandate automated CI quality checks (`flutter analyze` and `flutter test`) before any code can be merged into `main`.

---

## 🚀 Step-by-Step GitHub Setup Guide

### Step 1: Open GitHub Repository Settings
1. Navigate to the repository on GitHub:
   👉 **[https://github.com/Ushie-E/Project_Resume/settings/branches](https://github.com/Ushie-E/Project_Resume/settings/branches)**
2. In the left navigation menu under **Code and automation**, click **Branches** (or **Rules** &rarr; **Rulesets**).

---

### Step 2: Add a Branch Protection Rule
1. Under **Branch protection rules**, click the **Add branch protection rule** button.
2. In the **Branch name pattern** field, enter:
   ```text
   main
   ```

---

### Step 3: Configure the Core Protection Rules

Enable the following recommended checkboxes:

#### 1. 🔒 Require a pull request before merging
- **Check**: `Require a pull request before merging`
- **Require approvals**: Set to `1` (or `0` if solo working while still enforcing the PR workflow).
- **Check**: `Dismiss stale pull request approvals when new commits are pushed` (Ensures that any new commit pushed to the PR re-triggers review).
- **Check**: `Require conversation resolution before merging` (Prevents merging if there are unresolved PR review comments).

#### 2. 🧪 Require status checks to pass before merging
- **Check**: `Require status checks to pass before merging`
- **Check**: `Require branches to be up to date before merging`
- In the search bar under **Status checks that are required**, search and select:
  - `build-android-apk` (from `android_apk_build.yml`)
  - `build_and_test` (from `flutter_ci.yml`)

#### 3. 🚫 Block Force Pushes & Branch Deletion
- **Check**: `Do not allow force pushes` (Guarantees history cannot be overwritten with `git push --force`).
- **Check**: `Do not allow deletions` (Prevents accidental deletion of the `main` branch).

#### 4. 👑 Enforce for Administrators
- **Check**: `Do not allow bypassing the above settings` (or `Include administrators`).
- **Why**: This ensures that even repository owners/admins cannot accidentally run `git push origin main` from their local terminal.

---

### Step 4: Save Changes
1. Scroll down to the bottom of the page.
2. Click **Create** (or **Save changes**).
3. If prompted, enter your GitHub account password or two-factor authentication code to confirm.

---

## 💻 Local Machine Protection: Pre-Push Git Hook

To prevent any accidental `git push origin main` before it even leaves your local computer, a pre-push hook is included in this repository under `.githooks/pre-push`.

### Activate the Local Hook:
Run this command in your project root once:
```powershell
git config core.hooksPath .githooks
```

### What Happens if You Try to Push to `main` Directly:
```text
================================================================
🚨 DIRECT PUSH TO 'main' IS BLOCKED BY REPOSITORY POLICY! 🚨
================================================================

 Direct pushes to 'main' are forbidden to protect production integrity.
 Please follow the standard branching workflow:

   1. Create and switch to a feature branch:
        git checkout -b feature/your-feature-name
   2. Push your feature branch:
        git push origin feature/your-feature-name
   3. Open a Pull Request on GitHub to merge into 'main'.
================================================================
```

---

## 🔄 Standard Development Workflow

```bash
# 1. Start from latest main
git checkout main
git pull origin main

# 2. Create your isolated feature or fix branch
git checkout -b feature/my-new-feature

# 3. Work on changes, run analysis and tests
flutter analyze
flutter test

# 4. Commit and push your branch
git add .
git commit -m "feat(ui): add new portfolio capability"
git push -u origin feature/my-new-feature

# 5. Open PR on GitHub to merge into main
```
