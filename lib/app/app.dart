import 'package:project/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:project/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:project/ui/views/explore/explore_view.dart';
import 'package:project/ui/views/home/home_view.dart';
import 'package:project/ui/views/onboarding/onboarding_view.dart';
import 'package:project/ui/views/settings/settings_view.dart';
import 'package:project/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    AdaptiveRoute(page: StartupView, initial: true),
    MaterialRoute(page: ExploreView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: OnboardingView),
    // @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
