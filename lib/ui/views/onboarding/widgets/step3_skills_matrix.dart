import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/const.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';
import 'onboarding_shared_widgets.dart';

class Step3SkillsMatrix extends StatelessWidget {
  final OnboardingViewModel viewModel;
  final OnboardingCompleteCallback onComplete;

  const Step3SkillsMatrix({
    super.key,
    required this.viewModel,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> items = viewModel.isBusinessPlan
        ? viewModel.availableBusinessCapabilities
        : viewModel.availablePersonalSkills;
    final Set<String> selectedItems = viewModel.isBusinessPlan
        ? viewModel.selectedBusinessCapabilities
        : viewModel.selectedPersonalSkills;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.isBusinessPlan ? 'Enterprise Capabilities' : 'Skills & Expertise',
                  style: kOnboardingTitleStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  viewModel.isBusinessPlan
                      ? 'Select at least 2 enterprise capabilities provided by your firm.'
                      : 'Select at least 2 key skills or technologies that define your professional expertise.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: items.map((item) {
                    final isSelected = selectedItems.contains(item);
                    return FilterChip(
                      selected: isSelected,
                      label: Text(item),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Google Sans',
                      ),
                      selectedColor: kcOnboardingBlue,
                      backgroundColor: kcOnboardingUnselectedCard,
                      onSelected: (_) {
                        if (viewModel.isBusinessPlan) {
                          viewModel.toggleBusinessCapability(item);
                        } else {
                          viewModel.togglePersonalSkill(item);
                        }
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                buildNavigationButtons(
                  viewModel: viewModel,
                  isValid: viewModel.isStep3Valid,
                  nextText: 'Continue to Step 4',
                  onComplete: onComplete,
                ),
              ],
            ),
          ),
        ),
        buildProgressBar(context, 0.6),
      ],
    );
  }
}
