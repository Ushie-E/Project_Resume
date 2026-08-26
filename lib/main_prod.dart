import 'package:project/app/app_config.dart';
import 'package:project/main_common.dart';

void main() {
  AppConfig.initialize(
    appName: 'Ushie Digital Resume',
    apiBaseUrl: 'https://qoioeymizjtlfoqmeaut.supabase.co',
    supabaseUrl: 'https://qoioeymizjtlfoqmeaut.supabase.co',
    supabaseAnonKey: 'sb_publishable_kGq5l-ubr1nZvVKsdQf7JQ_ad352yf6',
    environment: EnvironmentType.prod,
    enableLogging: false,
  );
  mainCommon(AppConfig.instance);
}
