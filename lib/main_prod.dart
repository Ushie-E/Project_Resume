import 'package:project/app/app_config.dart';
import 'package:project/main_common.dart';

void main() {
  AppConfig.initialize(
    appName: 'Resume',
    apiBaseUrl: 'https://api.example.com',
    environment: EnvironmentType.prod,
    enableLogging: false,
  );
  mainCommon(AppConfig.instance);
}
