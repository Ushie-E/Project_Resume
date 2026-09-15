import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/const.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';
import 'onboarding_shared_widgets.dart';

class Step1PlanSelection extends StatelessWidget {
  final OnboardingViewModel viewModel;
  final OnboardingCompleteCallback onComplete;

  const Step1PlanSelection({
    super.key,
    required this.viewModel,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: viewModel.isBusinessPlan
                          ? const [Color(0xFF0F2027), Color(0xFF203A43)]
                          : const [Color(0xFF8B2635), Color(0xFF4A121A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: () => showAvatarPicker(context, viewModel),
                          child: Stack(
                            children: [
                              Container(
                                width: 110,
                                height: 110,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 3),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: buildAvatarWidget(viewModel.selectedAvatar, radius: 55),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3F6AD8),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        child: Text(
                          'Tap avatar to update picture',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 12,
                            fontFamily: 'Google Sans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                RichText(
                  text: const TextSpan(
                    style: kOnboardingTitleStyle,
                    children: [
                      TextSpan(text: 'Welcome to the\n'),
                      TextSpan(
                        text: 'Architectural Era.',
                        style: TextStyle(color: kcOnboardingBlue),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Let's begin by tailoring your experience. How do you plan to use our platform today?",
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                buildPlanCard(
                  title: 'Personal',
                  description:
                      'For individual developers & designers seeking to showcase personal projects & digital resume.',
                  icon: Icons.account_tree_outlined,
                  iconBg: kcTealBackground,
                  iconColor: kcTealIcon,
                  isSelected: viewModel.selectedPlan == 'Personal',
                  onTap: () => viewModel.setPlan('Personal'),
                ),
                const SizedBox(height: 16),
                buildPlanCard(
                  title: 'Business',
                  description:
                      'For firms, agencies, and enterprise teams seeking advanced client showcase & SLA capabilities.',
                  icon: Icons.business_outlined,
                  iconBg: kcPurpleBackground,
                  iconColor: kcPurpleIcon,
                  isSelected: viewModel.selectedPlan == 'Business',
                  onTap: () => viewModel.setPlan('Business'),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => viewModel.nextStep(onComplete),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3F6AD8).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          viewModel.isBusinessPlan ? 'Start Company Setup' : 'Get Started',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Google Sans',
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Tooltip(
                    message: 'Log In to your account',
                    preferBelow: false,
                    triggerMode: TooltipTriggerMode.tap,
                    child: TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Log In to your account'),
                            duration: Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        showLoginSheet(context, viewModel, onComplete);
                      },
                      icon: const Icon(Icons.login_outlined, size: 18, color: kcOnboardingBlue),
                      label: const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: kcOnboardingBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        buildProgressBar(context, 0.2),
      ],
    );
  }
}
