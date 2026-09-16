import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/app.locator.dart';
import 'package:project/services/preferences_service.dart';
import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel implements Initialisable {
  final _preferencesService = locator<PreferencesService>();

  bool _darkMode = false;
  bool get darkMode => _darkMode;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  bool _analyticsEnabled = true;
  bool get analyticsEnabled => _analyticsEnabled;

  String get selectedPlan => _preferencesService.selectedPlan;

  @override
  void initialise() {
    _darkMode = _preferencesService.darkMode;
    _notificationsEnabled = _preferencesService.notificationsEnabled;
    _analyticsEnabled = _preferencesService.analyticsEnabled;
    rebuildUi();
  }

  void toggleDarkMode(bool value) {
    _darkMode = value;
    _preferencesService.setDarkMode(value);
    rebuildUi();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    _preferencesService.setNotificationsEnabled(value);
    rebuildUi();
  }

  void toggleAnalytics(bool value) {
    _analyticsEnabled = value;
    _preferencesService.setAnalyticsEnabled(value);
    rebuildUi();
  }

  Future<void> switchPersona(String newPlan, BuildContext context) async {
    await _preferencesService.switchPersona(newPlan);
    rebuildUi();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Switched profile to $newPlan persona!'),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void exportProfileJson(BuildContext context) {
    final map = _preferencesService.exportProfileMap();
    final jsonStr = JsonEncoder.withIndent('  ').convert(map);
    Clipboard.setData(ClipboardData(text: jsonStr));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Complete Profile JSON copied to clipboard!'),
            ],
          ),
          backgroundColor: Color(0xFF254EDB),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> resetProfileData(BuildContext context) async {
    await _preferencesService.clear();
    await _preferencesService.switchPersona('Personal');
    rebuildUi();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile reset to initial defaults.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
