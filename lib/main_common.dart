import 'package:flutter/material.dart';
import 'package:project/app/app.bottomsheets.dart';
import 'package:project/app/app.dialogs.dart';
import 'package:project/app/app.locator.dart';
import 'package:project/app/app.router.dart';
import 'package:project/app/app_config.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> mainCommon(AppConfig config) async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

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
