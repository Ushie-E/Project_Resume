import 'package:flutter/material.dart';
import 'package:project/app.dart';
import 'package:project/services/preferences_service.dart';
import 'package:stacked_services/stacked_services.dart';

/// Bootstraps core services, registered UI handlers, local preferences, and launches [MainApp].
Future<void> bootstrapApp(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  await locator<PreferencesService>().init();
  runApp(const MainApp());
}

/// Root widget for the application.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs = locator<PreferencesService>();
    return ValueListenableBuilder<bool>(
      valueListenable: prefs.darkModeListenable,
      builder: (context, isDark, _) {
        return MaterialApp(
          title: AppConfig.instance.appName,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            brightness: Brightness.light,
            fontFamily: 'Google Sans',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3562D7),
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0F172A),
            fontFamily: 'Google Sans',
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF3562D7),
              brightness: Brightness.dark,
              surface: const Color(0xFF1E293B),
            ),
          ),
          debugShowCheckedModeBanner: AppConfig.isDev || AppConfig.isStaging,
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [StackedService.routeObserver],
        );
      },
    );
  }
}

void main() {
  AppConfig.initialize(
    appName: 'Ushie Digital Resume (Dev)',
    apiBaseUrl: 'https://ushie-digital-resume.vercel.app',
    supabaseUrl: 'https://qoioeymizjtlfoqmeaut.supabase.co',
    supabaseAnonKey: 'sb_publishable_kGq5l-ubr1nZvVKsdQf7JQ_ad352yf6',
    environment: EnvironmentType.dev,
    enableLogging: true,
  );
  bootstrapApp(AppConfig.instance);
}
