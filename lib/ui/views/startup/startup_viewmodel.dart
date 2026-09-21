import 'package:project/app.locator.dart';
import 'package:project/app.router.dart';
import 'package:project/services/preferences_service.dart';
import 'package:project/services/supabase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _supabaseService = locator<SupabaseService>();
  final _preferencesService = locator<PreferencesService>();

  // Initialize Supabase backend & local preferences before navigating
  Future runStartupLogic() async {
    await _preferencesService.init();
    await _supabaseService.initSupabase();
    await Future.delayed(const Duration(milliseconds: 1500));

    if (_preferencesService.isOnboardingComplete) {
      _navigationService.replaceWithHomeView();
    } else {
      _navigationService.replaceWithOnboardingView();
    }
  }
}
