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
    return MaterialApp(
      title: AppConfig.instance.appName,
      debugShowCheckedModeBanner: AppConfig.isDev || AppConfig.isStaging,
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
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
