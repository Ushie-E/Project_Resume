import 'package:project/app/app.locator.dart';
import 'package:project/app/app.router.dart';
import 'package:project/services/supabase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _supabaseService = locator<SupabaseService>();

  // Initialize Supabase backend before navigating into the application
  Future runStartupLogic() async {
    await _supabaseService.initSupabase();
    await Future.delayed(const Duration(seconds: 2));

    _navigationService.replaceWithHomeView();
  }
}
