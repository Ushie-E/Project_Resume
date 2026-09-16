import 'package:project/app_config.dart';
import 'package:project/main.dart';

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
