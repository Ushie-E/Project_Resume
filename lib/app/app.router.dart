// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i7;
import 'package:flutter/material.dart';
import 'package:project/ui/views/explore/explore_view.dart' as _i4;
import 'package:project/ui/views/home/home_view.dart' as _i2;
import 'package:project/ui/views/onboarding/onboarding_view.dart' as _i6;
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart' as _i8;
import 'package:project/ui/views/settings/settings_view.dart' as _i5;
import 'package:project/ui/views/startup/startup_view.dart' as _i3;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/';

  static const exploreView = '/explore-view';

  static const settingsView = '/settings-view';

  static const onboardingView = '/onboarding-view';

  static const all = <String>{
    homeView,
    startupView,
    exploreView,
    settingsView,
    onboardingView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.exploreView,
      page: _i4.ExploreView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i5.SettingsView,
    ),
    _i1.RouteDef(
      Routes.onboardingView,
      page: _i6.OnboardingView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => const HomeViewArguments(),
      );
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.HomeView(key: args.key),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      final args = data.getArgs<StartupViewArguments>(
        orElse: () => const StartupViewArguments(),
      );
      return _i1.buildAdaptivePageRoute<dynamic>(
        builder: (context) => _i3.StartupView(key: args.key),
        settings: data,
      );
    },
    _i4.ExploreView: (data) {
      final args = data.getArgs<ExploreViewArguments>(
        orElse: () => const ExploreViewArguments(),
      );
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.ExploreView(key: args.key),
        settings: data,
      );
    },
    _i5.SettingsView: (data) {
      final args = data.getArgs<SettingsViewArguments>(
        orElse: () => const SettingsViewArguments(),
      );
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.SettingsView(
            key: args.key,
            onRestartOnboarding: args.onRestartOnboarding,
            userAvatar: args.userAvatar,
            userName: args.userName,
            userTitle: args.userTitle,
            planType: args.planType),
        settings: data,
      );
    },
    _i6.OnboardingView: (data) {
      final args = data.getArgs<OnboardingViewArguments>(
        orElse: () => const OnboardingViewArguments(),
      );
      return _i7.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.OnboardingView(
            key: args.key, onOnboardingComplete: args.onOnboardingComplete),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class HomeViewArguments {
  const HomeViewArguments({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant HomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class StartupViewArguments {
  const StartupViewArguments({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant StartupViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ExploreViewArguments {
  const ExploreViewArguments({this.key});

  final _i7.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ExploreViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SettingsViewArguments {
  const SettingsViewArguments({
    this.key,
    this.onRestartOnboarding,
    this.userAvatar = 'images/user.png',
    this.userName = 'Ushie Emmanuel',
    this.userTitle = 'Flutter Mobile Engineer',
    this.planType = 'Personal',
  });

  final _i7.Key? key;

  final void Function()? onRestartOnboarding;

  final String userAvatar;

  final String userName;

  final String userTitle;

  final String planType;

  @override
  String toString() {
    return '{"key": "$key", "onRestartOnboarding": "$onRestartOnboarding", "userAvatar": "$userAvatar", "userName": "$userName", "userTitle": "$userTitle", "planType": "$planType"}';
  }

  @override
  bool operator ==(covariant SettingsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.onRestartOnboarding == onRestartOnboarding &&
        other.userAvatar == userAvatar &&
        other.userName == userName &&
        other.userTitle == userTitle &&
        other.planType == planType;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        onRestartOnboarding.hashCode ^
        userAvatar.hashCode ^
        userName.hashCode ^
        userTitle.hashCode ^
        planType.hashCode;
  }
}

class OnboardingViewArguments {
  const OnboardingViewArguments({
    this.key,
    this.onOnboardingComplete,
  });

  final _i7.Key? key;

  final void Function(_i8.OnboardingViewModel)? onOnboardingComplete;

  @override
  String toString() {
    return '{"key": "$key", "onOnboardingComplete": "$onOnboardingComplete"}';
  }

  @override
  bool operator ==(covariant OnboardingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.onOnboardingComplete == onOnboardingComplete;
  }

  @override
  int get hashCode {
    return key.hashCode ^ onOnboardingComplete.hashCode;
  }
}

extension NavigatorStateExtension on _i9.NavigationService {
  Future<dynamic> navigateToHomeView({
    _i7.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView({
    _i7.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.startupView,
        arguments: StartupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExploreView({
    _i7.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.exploreView,
        arguments: ExploreViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView({
    _i7.Key? key,
    void Function()? onRestartOnboarding,
    String userAvatar = 'images/user.png',
    String userName = 'Ushie Emmanuel',
    String userTitle = 'Flutter Mobile Engineer',
    String planType = 'Personal',
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.settingsView,
        arguments: SettingsViewArguments(
            key: key,
            onRestartOnboarding: onRestartOnboarding,
            userAvatar: userAvatar,
            userName: userName,
            userTitle: userTitle,
            planType: planType),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingView({
    _i7.Key? key,
    void Function(_i8.OnboardingViewModel)? onOnboardingComplete,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.onboardingView,
        arguments: OnboardingViewArguments(
            key: key, onOnboardingComplete: onOnboardingComplete),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView({
    _i7.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.homeView,
        arguments: HomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView({
    _i7.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.startupView,
        arguments: StartupViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExploreView({
    _i7.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.exploreView,
        arguments: ExploreViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView({
    _i7.Key? key,
    void Function()? onRestartOnboarding,
    String userAvatar = 'images/user.png',
    String userName = 'Ushie Emmanuel',
    String userTitle = 'Flutter Mobile Engineer',
    String planType = 'Personal',
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.settingsView,
        arguments: SettingsViewArguments(
            key: key,
            onRestartOnboarding: onRestartOnboarding,
            userAvatar: userAvatar,
            userName: userName,
            userTitle: userTitle,
            planType: planType),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingView({
    _i7.Key? key,
    void Function(_i8.OnboardingViewModel)? onOnboardingComplete,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.onboardingView,
        arguments: OnboardingViewArguments(
            key: key, onOnboardingComplete: onOnboardingComplete),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
