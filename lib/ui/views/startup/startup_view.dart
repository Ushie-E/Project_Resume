import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:project/app_config.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    String flavorName = 'DEV';
    Color flavorColor = kcTealIcon;
    try {
      final env = AppConfig.instance.environment;
      if (env == EnvironmentType.prod) {
        flavorName = 'PRODUCTION';
        flavorColor = Colors.greenAccent;
      } else if (env == EnvironmentType.staging) {
        flavorName = 'STAGING';
        flavorColor = Colors.amberAccent;
      }
    } catch (_) {}

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF0F2027)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 104,
                height: 104,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 2,
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 20,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.architecture_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ushie Digital Resume',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Executive Portfolio & Architecture Platform',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 14,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: flavorColor.withValues(alpha: 0.5)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: flavorColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'FLAVOR: $flavorName',
                      style: TextStyle(
                        color: flavorColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 36),
              const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(kcOnboardingBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(BuildContext context) => StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
