import 'package:project/app/app_config.dart';
import 'package:project/main_common.dart';

void main() {
  AppConfig.initialize(
    appName: 'Resume (Dev)',
    apiBaseUrl: 'https://dev-api.example.com',
    environment: EnvironmentType.dev,
    enableLogging: true,
  );
  mainCommon(AppConfig.instance);
}
