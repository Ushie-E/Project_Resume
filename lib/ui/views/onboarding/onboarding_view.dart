import 'package:flutter/material.dart';
import 'package:project/app.locator.dart';
import 'package:project/app.router.dart';
import 'package:project/services/preferences_service.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/responsive_layout.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'onboarding_viewmodel.dart';
import 'widgets/step1_plan_selection.dart';
import 'widgets/step2_profile_form.dart';
import 'widgets/step3_skills_matrix.dart';
import 'widgets/step4_interests_markets.dart';
import 'widgets/step5_review_directory.dart';

class OnboardingView extends StackedView<OnboardingViewModel> {
  final OnboardingCompleteCallback? onOnboardingComplete;

  const OnboardingView({
    super.key,
    this.onOnboardingComplete,
  });

  OnboardingCompleteCallback get _safeOnboardingComplete =>
      onOnboardingComplete ??
      (vm) {
        final prefs = locator<PreferencesService>();
        prefs.saveProfile(
          plan: vm.selectedPlan,
          avatar: vm.selectedAvatar,
          name: vm.isBusinessPlan ? vm.displayCompanyName : vm.displayName,
          title: vm.isBusinessPlan ? vm.displayCompanySector : vm.displayJobTitle,
          bio: vm.isBusinessPlan ? vm.companyOverview : vm.bio,
          location: vm.isBusinessPlan ? vm.companyLocation : vm.location,
          skills: vm.isBusinessPlan
              ? vm.selectedBusinessCapabilities.toList()
              : vm.selectedPersonalSkills.toList(),
          interests: vm.isBusinessPlan
              ? vm.selectedTargetMarkets.toList()
              : vm.selectedPersonalInterests.toList(),
          contactEmail: vm.contactEmail,
          contactPhone: vm.contactPhone,
          githubUrl: vm.githubUrl,
          linkedinUrl: vm.linkedinUrl,
          websiteUrl: vm.websiteUrl,
          experiences: vm.experiences,
          certifications: vm.certifications,
          hobbies: vm.hobbies,
        );
        locator<NavigationService>().replaceWithHomeView();
      };

  @override
  Widget builder(BuildContext context, OnboardingViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: viewModel.currentStep > 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: viewModel.prevStep,
              )
            : null,
        title: const Text(
          'Create Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Google Sans',
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Ushie Digital',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                  fontFamily: 'Google Sans',
                ),
              ),
            ),
          ),
        ],
        centerTitle: false,
      ),
      body: ResponsiveContainer(
        child: _buildCurrentStep(context, viewModel),
      ),
    );
  }

  Widget _buildCurrentStep(BuildContext context, OnboardingViewModel viewModel) {
    switch (viewModel.currentStep) {
      case 1:
        return Step1PlanSelection(
          viewModel: viewModel,
          onComplete: _safeOnboardingComplete,
        );
      case 2:
        return Step2ProfileForm(
          viewModel: viewModel,
          onComplete: _safeOnboardingComplete,
        );
      case 3:
        return Step3SkillsMatrix(
          viewModel: viewModel,
          onComplete: _safeOnboardingComplete,
        );
      case 4:
        return Step4InterestsMarkets(
          viewModel: viewModel,
          onComplete: _safeOnboardingComplete,
        );
      case 5:
        return Step5ReviewDirectory(
          viewModel: viewModel,
          onComplete: _safeOnboardingComplete,
        );
      default:
        return Step1PlanSelection(
          viewModel: viewModel,
          onComplete: _safeOnboardingComplete,
        );
    }
  }

  @override
  OnboardingViewModel viewModelBuilder(BuildContext context) => OnboardingViewModel();
}
