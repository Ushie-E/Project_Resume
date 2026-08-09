import 'package:project/app/app_config.dart';
import 'package:project/main_common.dart';

void main() {
  AppConfig.initialize(
    appName: 'Resume (Staging)',
    apiBaseUrl: 'https://staging-api.example.com',
    environment: EnvironmentType.staging,
    enableLogging: true,
  );
  mainCommon(AppConfig.instance);
}
