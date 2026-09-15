import 'package:flutter/material.dart';
import 'package:project/ui/common/const.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';
import 'onboarding_shared_widgets.dart';

class Step2ProfileForm extends StatelessWidget {
  final OnboardingViewModel viewModel;
  final OnboardingCompleteCallback onComplete;

  const Step2ProfileForm({
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
                Text(
                  viewModel.isBusinessPlan ? 'Company Profile' : 'Profile Information',
                  style: kOnboardingTitleStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  viewModel.isBusinessPlan
                      ? 'Configure your agency/firm details for enterprise client matching.'
                      : 'Tell us a bit about yourself to personalize your digital resume profile.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                if (viewModel.isBusinessPlan) ...[
                  buildTextField(
                    label: 'Company / Agency Name',
                    hintText: 'e.g. Ushie Tech Labs',
                    initialValue: viewModel.companyName,
                    icon: Icons.business,
                    onChanged: viewModel.setCompanyName,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Industry Sector',
                    hintText: 'e.g. Software & AI Solutions',
                    initialValue: viewModel.companySector,
                    icon: Icons.category_outlined,
                    onChanged: viewModel.setCompanySector,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Team Size',
                    hintText: 'e.g. 11-50 Employees',
                    initialValue: viewModel.teamSize,
                    icon: Icons.groups_outlined,
                    onChanged: viewModel.setTeamSize,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Company HQ Location',
                    hintText: 'e.g. Lagos, Nigeria & Remote',
                    initialValue: viewModel.companyLocation,
                    icon: Icons.location_on_outlined,
                    onChanged: viewModel.setCompanyLocation,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Company Overview & Mission',
                    hintText: 'Describe your firm capabilities...',
                    initialValue: viewModel.companyOverview,
                    icon: Icons.notes_outlined,
                    maxLines: 3,
                    onChanged: viewModel.setCompanyOverview,
                  ),
                ] else ...[
                  buildTextField(
                    label: 'Full Name',
                    hintText: 'e.g. Ushie Emmanuel',
                    initialValue: viewModel.fullName,
                    icon: Icons.person_outline,
                    onChanged: viewModel.setFullName,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Professional Title',
                    hintText: 'e.g. Flutter Mobile Engineer',
                    initialValue: viewModel.jobTitle,
                    icon: Icons.work_outline,
                    onChanged: viewModel.setJobTitle,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Short Bio',
                    hintText: 'Brief summary about your skills...',
                    initialValue: viewModel.bio,
                    icon: Icons.notes_outlined,
                    maxLines: 3,
                    onChanged: viewModel.setBio,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Location',
                    hintText: 'e.g. Lagos, Nigeria',
                    initialValue: viewModel.location,
                    icon: Icons.location_on_outlined,
                    onChanged: viewModel.setLocation,
                  ),
                ],
                const SizedBox(height: 32),
                buildNavigationButtons(
                  viewModel: viewModel,
                  isValid: viewModel.isStep2Valid,
                  nextText: 'Continue to Step 3',
                  onComplete: onComplete,
                ),
              ],
            ),
          ),
        ),
        buildProgressBar(context, 0.4),
      ],
    );
  }
}
