import 'package:project/app/app_config.dart';
import 'package:project/main_common.dart';

void main() {
  AppConfig.initialize(
    appName: 'Ushie Digital Resume',
    apiBaseUrl: 'https://api.ushiedigital.com',
    environment: EnvironmentType.prod,
    enableLogging: false,
  );
  mainCommon(AppConfig.instance);
}
