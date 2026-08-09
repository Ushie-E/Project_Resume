import 'package:flutter/material.dart';
import 'package:project/app/app_config.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  final VoidCallback? onRestartOnboarding;
  final String userAvatar;
  final String userName;
  final String userTitle;
  final String planType;

  const SettingsView({
    super.key,
    this.onRestartOnboarding,
    this.userAvatar = 'images/user.png',
    this.userName = 'Ushie Emmanuel',
    this.userTitle = 'Flutter Mobile Engineer',
    this.planType = 'Personal',
  });

  @override
  Widget builder(BuildContext context, SettingsViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        elevation: 0,
        title: const Text(
          'Settings & Preferences',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Google Sans',
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Summary Header Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(userAvatar),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Google Sans',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userTitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: kcOnboardingBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (onRestartOnboarding != null)
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, color: kcOnboardingBlue),
                      onPressed: onRestartOnboarding,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Preferences Group
            const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontFamily: 'Google Sans',
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.dark_mode_outlined, color: kcOnboardingBlue),
                    title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('Enable high-contrast dark theme'),
                    value: viewModel.darkMode,
                    onChanged: viewModel.toggleDarkMode,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.notifications_outlined, color: kcOnboardingBlue),
                    title: const Text('Push Notifications', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('Receive updates on profile & project highlights'),
                    value: viewModel.notificationsEnabled,
                    onChanged: viewModel.toggleNotifications,
                  ),
                  const Divider(height: 1),
                  SwitchListTile(
                    secondary: const Icon(Icons.analytics_outlined, color: kcOnboardingBlue),
                    title: const Text('Analytics & Sync', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: const Text('Share anonymous telemetry to improve experience'),
                    value: viewModel.analyticsEnabled,
                    onChanged: viewModel.toggleAnalytics,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Environment & Build Info Group
            const Text(
              'Environment & Build Info',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontFamily: 'Google Sans',
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.layers_outlined, color: kcOnboardingBlue),
                    title: const Text('Build Flavor', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(AppConfig.instance.appName),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: kcTealBackground,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        AppConfig.instance.environment.name.toUpperCase(),
                        style: const TextStyle(
                          color: kcTealIcon,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.cloud_outlined, color: kcOnboardingBlue),
                    title: const Text('API Endpoint', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(AppConfig.instance.apiBaseUrl),
                  ),
                  const Divider(height: 1),
                  const ListTile(
                    leading: Icon(Icons.info_outline, color: kcOnboardingBlue),
                    title: Text('App Version', style: TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('1.0.0+1 (Flutter & Stacked Framework)'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            if (onRestartOnboarding != null)
              GestureDetector(
                onTap: onRestartOnboarding,
                child: Container(
                  width: double.infinity,
                  height: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.red[50],
                    border: Border.all(color: Colors.redAccent, width: 1.5),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restart_alt, color: Colors.redAccent),
                      SizedBox(width: 8),
                      Text(
                        'Re-run Profile Setup Wizard',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) => SettingsViewModel();
}
