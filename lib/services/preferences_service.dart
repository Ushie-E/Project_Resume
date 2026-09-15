import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _keyIsOnboardingComplete = 'is_onboarding_complete';
  static const String _keySelectedPlan = 'selected_plan';
  static const String _keySelectedAvatar = 'selected_avatar';
  static const String _keyFullName = 'full_name';
  static const String _keyJobTitle = 'job_title';
  static const String _keyBio = 'bio';
  static const String _keyLocation = 'location';
  static const String _keySkills = 'selected_skills';
  static const String _keyInterests = 'selected_interests';
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyNotifications = 'notifications_enabled';
  static const String _keyAnalytics = 'analytics_enabled';
  static const String _keyLikedProjects = 'liked_project_titles';

  SharedPreferences? _prefs;

  Future<void> init() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
    } catch (e) {
      if (kDebugMode) {
        print('PreferencesService init error: $e');
      }
    }
  }

  bool get isOnboardingComplete =>
      _prefs?.getBool(_keyIsOnboardingComplete) ?? false;
  Future<void> setOnboardingComplete(bool value) async {
    await _prefs?.setBool(_keyIsOnboardingComplete, value);
  }

  String get selectedPlan =>
      _prefs?.getString(_keySelectedPlan) ?? 'Personal';
  Future<void> setSelectedPlan(String value) async {
    await _prefs?.setString(_keySelectedPlan, value);
  }

  String get selectedAvatar =>
      _prefs?.getString(_keySelectedAvatar) ?? 'images/empty_profile.png';
  Future<void> setSelectedAvatar(String value) async {
    await _prefs?.setString(_keySelectedAvatar, value);
  }

  String get fullName =>
      _prefs?.getString(_keyFullName) ?? 'Ushie Emmanuel';
  Future<void> setFullName(String value) async {
    await _prefs?.setString(_keyFullName, value);
  }

  String get jobTitle =>
      _prefs?.getString(_keyJobTitle) ?? 'Flutter Mobile Engineer';
  Future<void> setJobTitle(String value) async {
    await _prefs?.setString(_keyJobTitle, value);
  }

  String get bio =>
      _prefs?.getString(_keyBio) ??
      'Crafting high-performance cross-platform applications with Flutter & Stacked.';
  Future<void> setBio(String value) async {
    await _prefs?.setString(_keyBio, value);
  }

  String get location =>
      _prefs?.getString(_keyLocation) ?? 'Lagos, Nigeria';
  Future<void> setLocation(String value) async {
    await _prefs?.setString(_keyLocation, value);
  }

  List<String> get skills {
    final list = _prefs?.getStringList(_keySkills);
    if (list != null && list.isNotEmpty) return list;
    return const ['Flutter', 'Dart', 'Stacked Architecture'];
  }
  Future<void> setSkills(List<String> value) async {
    await _prefs?.setStringList(_keySkills, value);
  }

  List<String> get interests {
    final list = _prefs?.getStringList(_keyInterests);
    return list ?? const [];
  }
  Future<void> setInterests(List<String> value) async {
    await _prefs?.setStringList(_keyInterests, value);
  }

  bool get darkMode => _prefs?.getBool(_keyDarkMode) ?? false;
  Future<void> setDarkMode(bool value) async {
    await _prefs?.setBool(_keyDarkMode, value);
  }

  bool get notificationsEnabled =>
      _prefs?.getBool(_keyNotifications) ?? true;
  Future<void> setNotificationsEnabled(bool value) async {
    await _prefs?.setBool(_keyNotifications, value);
  }

  bool get analyticsEnabled => _prefs?.getBool(_keyAnalytics) ?? true;
  Future<void> setAnalyticsEnabled(bool value) async {
    await _prefs?.setBool(_keyAnalytics, value);
  }

  List<String> get likedProjects {
    return _prefs?.getStringList(_keyLikedProjects) ?? const [];
  }
  Future<void> setLikedProjects(List<String> value) async {
    await _prefs?.setStringList(_keyLikedProjects, value);
  }

  Future<void> saveProfile({
    required String plan,
    required String avatar,
    required String name,
    required String title,
    required String bio,
    required String location,
    required List<String> skills,
    required List<String> interests,
  }) async {
    await setSelectedPlan(plan);
    await setSelectedAvatar(avatar);
    await setFullName(name);
    await setJobTitle(title);
    await setBio(bio);
    await setLocation(location);
    await setSkills(skills);
    await setInterests(interests);
    await setOnboardingComplete(true);
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
