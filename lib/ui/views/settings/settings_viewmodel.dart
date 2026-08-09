import 'package:stacked/stacked.dart';

class SettingsViewModel extends BaseViewModel {
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  bool _analyticsEnabled = true;
  bool get analyticsEnabled => _analyticsEnabled;

  void toggleDarkMode(bool value) {
    _darkMode = value;
    rebuildUi();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    rebuildUi();
  }

  void toggleAnalytics(bool value) {
    _analyticsEnabled = value;
    rebuildUi();
  }
}
