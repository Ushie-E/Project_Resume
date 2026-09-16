import 'package:flutter/material.dart';
import 'package:project/app_config.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/responsive_layout.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  final VoidCallback? onRestartOnboarding;
  final String userAvatar;
  final String userName;
  final String userTitle;
  final String planType;
  final bool darkMode;
  final ValueChanged<bool>? onToggleDarkMode;

  const SettingsView({
    super.key,
    this.onRestartOnboarding,
    this.userAvatar = 'images/user.png',
    this.userName = 'Ushie Emmanuel',
    this.userTitle = 'Lead Flutter & Mobile Architect',
    this.planType = 'Personal',
    this.darkMode = false,
    this.onToggleDarkMode,
  });

  @override
  void onViewModelReady(SettingsViewModel viewModel) => viewModel.initialise();

  @override
  Widget builder(BuildContext context, SettingsViewModel viewModel, Widget? child) {
    final bool isDark = darkMode || viewModel.darkMode;

    final bgColor = isDark ? const Color(0xFF0F172A) : kcBackgroundColor;
    final cardBgColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final primaryTextColor = isDark ? Colors.white : Colors.black;
    final groupHeaderColor = isDark ? Colors.white70 : Colors.grey[700];
    final subtitleColor = isDark ? Colors.white60 : Colors.grey[600];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Settings & Preferences',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Google Sans',
          ),
        ),
        centerTitle: false,
      ),
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Summary Header Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black45 : Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    userAvatar == 'images/empty_profile.png'
                        ? const CircleAvatar(
                            radius: 30,
                            backgroundColor: Color(0xFFE2E8F0),
                            child: Icon(Icons.person_outline, size: 32, color: Color(0xFF64748B)),
                          )
                        : CircleAvatar(
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
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryTextColor,
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

              // Persona Switcher
              Text(
                'Active Persona',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: groupHeaderColor,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => viewModel.switchPersona('Personal', context),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: viewModel.selectedPlan == 'Personal'
                                ? kcOnboardingBlue
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Personal (Developer)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: viewModel.selectedPlan == 'Personal'
                                    ? Colors.white
                                    : primaryTextColor,
                                fontSize: 13,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => viewModel.switchPersona('Business', context),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: viewModel.selectedPlan == 'Business'
                                ? const Color(0xFF254EDB)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Business (Studio)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: viewModel.selectedPlan == 'Business'
                                    ? Colors.white
                                    : primaryTextColor,
                                fontSize: 13,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Preferences Group
              Text(
                'Preferences',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: groupHeaderColor,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 12),
              Material(
                color: cardBgColor,
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(Icons.dark_mode_outlined, color: kcOnboardingBlue),
                      title: Text(
                        'Dark Mode',
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        'Enable high-contrast dark theme',
                        style: TextStyle(color: subtitleColor),
                      ),
                      value: isDark,
                      onChanged: (val) {
                        viewModel.toggleDarkMode(val);
                        if (onToggleDarkMode != null) {
                          onToggleDarkMode!(val);
                        }
                      },
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: const Icon(Icons.notifications_outlined, color: kcOnboardingBlue),
                      title: Text(
                        'Push Notifications',
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        'Receive updates on profile & project highlights',
                        style: TextStyle(color: subtitleColor),
                      ),
                      value: viewModel.notificationsEnabled,
                      onChanged: viewModel.toggleNotifications,
                    ),
                    const Divider(height: 1),
                    SwitchListTile(
                      secondary: const Icon(Icons.analytics_outlined, color: kcOnboardingBlue),
                      title: Text(
                        'Analytics & Sync',
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        'Share anonymous telemetry to improve experience',
                        style: TextStyle(color: subtitleColor),
                      ),
                      value: viewModel.analyticsEnabled,
                      onChanged: viewModel.toggleAnalytics,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Data & Profile Export
              Text(
                'Data & Portability',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: groupHeaderColor,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 12),
              Material(
                color: cardBgColor,
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.file_download_outlined, color: kcOnboardingBlue),
                      title: Text(
                        'Export Profile as JSON',
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        'Export complete resume, experiences, and certifications',
                        style: TextStyle(color: subtitleColor),
                      ),
                      trailing: const Icon(Icons.copy, size: 18),
                      onTap: () => viewModel.exportProfileJson(context),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Environment & Build Info Group
              Text(
                'Environment & Release Quality Gate',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: groupHeaderColor,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 12),
              Material(
                color: cardBgColor,
                borderRadius: BorderRadius.circular(16),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.layers_outlined, color: kcOnboardingBlue),
                      title: Text(
                        'Build Flavor',
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        AppConfig.instance.appName,
                        style: TextStyle(color: subtitleColor),
                      ),
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
                      leading: const Icon(Icons.source_outlined, color: kcOnboardingBlue),
                      title: Text(
                        'Repository Remote',
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        'https://github.com/Ushie-E/Project_Resume.git',
                        style: TextStyle(color: subtitleColor, fontSize: 12),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.cloud_outlined, color: kcOnboardingBlue),
                      title: Text(
                        'Supabase Backend',
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        AppConfig.instance.apiBaseUrl,
                        style: TextStyle(color: subtitleColor),
                      ),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.info_outline, color: kcOnboardingBlue),
                      title: Text(
                        'App Version',
                        style: TextStyle(fontWeight: FontWeight.w600, color: primaryTextColor),
                      ),
                      subtitle: Text(
                        '1.0.0+1 (Flutter & Stacked Framework)',
                        style: TextStyle(color: subtitleColor),
                      ),
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
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: isDark ? const Color(0xFF331B1B) : Colors.red[50],
                      border: Border.all(color: Colors.redAccent, width: 1.5),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.restart_alt, color: Colors.redAccent),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            'Re-run Profile Setup Wizard',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                              fontFamily: 'Google Sans',
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) => SettingsViewModel();
}
