import 'package:project/app/app_config.dart';
import 'package:project/main_common.dart';

void main() {
  AppConfig.initialize(
    appName: 'Ushie Digital Resume (Dev)',
    apiBaseUrl: 'https://dev-api.resume.us00.co',
    supabaseUrl: 'https://qoioeymizjtlfoqmeaut.supabase.co',
    supabaseAnonKey: 'sb_publishable_kGq5l-ubr1nZvVKsdQf7JQ_ad352yf6',
    environment: EnvironmentType.dev,
    enableLogging: true,
  );
  mainCommon(AppConfig.instance);
}
