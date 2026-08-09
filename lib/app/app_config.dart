enum EnvironmentType { dev, staging, prod }

class AppConfig {
  final String appName;
  final String apiBaseUrl;
  final EnvironmentType environment;
  final bool enableLogging;

  static late AppConfig _instance;

  AppConfig._internal({
    required this.appName,
    required this.apiBaseUrl,
    required this.environment,
    required this.enableLogging,
  });

  static void initialize({
    required String appName,
    required String apiBaseUrl,
    required EnvironmentType environment,
    bool enableLogging = true,
  }) {
    _instance = AppConfig._internal(
      appName: appName,
      apiBaseUrl: apiBaseUrl,
      environment: environment,
      enableLogging: enableLogging,
    );
  }

  static AppConfig get instance => _instance;

  static bool get isDev => _instance.environment == EnvironmentType.dev;
  static bool get isStaging => _instance.environment == EnvironmentType.staging;
  static bool get isProd => _instance.environment == EnvironmentType.prod;
}
