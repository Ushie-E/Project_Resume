import 'package:project/app/app.locator.dart';
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
}
