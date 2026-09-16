import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        viewModel.isBusinessPlan ? 'Company Profile' : 'Profile Information',
                        style: kOnboardingTitleStyle,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: viewModel.isBusinessPlan
                          ? viewModel.quickFillBusiness
                          : viewModel.quickFillPersonal,
                      icon: const Icon(Icons.auto_fix_high, size: 16, color: kcOnboardingBlue),
                      label: const Text(
                        'Fill Sample Data',
                        style: TextStyle(
                          color: kcOnboardingBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  viewModel.isBusinessPlan
                      ? 'Configure your agency/firm details and executive credentials for client matching.'
                      : 'Tell us about yourself and your contact channels to personalize your executive resume.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                if (viewModel.isBusinessPlan) ...[
                  buildTextField(
                    label: 'Company / Agency Name',
                    hintText: 'e.g. Ushie Tech Labs & Studio',
                    initialValue: viewModel.companyName,
                    icon: Icons.business,
                    onChanged: viewModel.setCompanyName,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Industry Sector',
                    hintText: 'e.g. Enterprise Mobile & AI Solutions',
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
                    hintText: 'e.g. Lagos, Nigeria & London, UK',
                    initialValue: viewModel.companyLocation,
                    icon: Icons.location_on_outlined,
                    onChanged: viewModel.setCompanyLocation,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Company Email',
                    hintText: 'e.g. contact@ushietechlabs.io',
                    initialValue: viewModel.contactEmail,
                    icon: Icons.email_outlined,
                    onChanged: viewModel.setContactEmail,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Company Phone / Direct Line',
                    hintText: 'e.g. +234 800 USHIE LABS',
                    initialValue: viewModel.contactPhone,
                    icon: Icons.phone_outlined,
                    onChanged: viewModel.setContactPhone,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'LinkedIn Firm Page',
                    hintText: 'https://linkedin.com/company/...',
                    initialValue: viewModel.linkedinUrl,
                    icon: Icons.link,
                    onChanged: viewModel.setLinkedinUrl,
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
                    hintText: 'e.g. Lead Flutter & Mobile Architect',
                    initialValue: viewModel.jobTitle,
                    icon: Icons.work_outline,
                    onChanged: viewModel.setJobTitle,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Location',
                    hintText: 'e.g. Lagos, Nigeria',
                    initialValue: viewModel.location,
                    icon: Icons.location_on_outlined,
                    onChanged: viewModel.setLocation,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Direct Email',
                    hintText: 'e.g. ushie.code@gmail.com',
                    initialValue: viewModel.contactEmail,
                    icon: Icons.email_outlined,
                    onChanged: viewModel.setContactEmail,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Phone / WhatsApp',
                    hintText: 'e.g. +234 810 000 0000',
                    initialValue: viewModel.contactPhone,
                    icon: Icons.phone_outlined,
                    onChanged: viewModel.setContactPhone,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'GitHub Profile URL',
                    hintText: 'https://github.com/Ushie-E',
                    initialValue: viewModel.githubUrl,
                    icon: Icons.code,
                    onChanged: viewModel.setGithubUrl,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'LinkedIn Profile URL',
                    hintText: 'https://linkedin.com/in/...',
                    initialValue: viewModel.linkedinUrl,
                    icon: Icons.link,
                    onChanged: viewModel.setLinkedinUrl,
                  ),
                  const SizedBox(height: 16),
                  buildTextField(
                    label: 'Executive Bio / Summary',
                    hintText: 'Brief summary about your skills...',
                    initialValue: viewModel.bio,
                    icon: Icons.notes_outlined,
                    maxLines: 3,
                    onChanged: viewModel.setBio,
                  ),
                ],
                const SizedBox(height: 32),
                buildNavigationButtons(
                  viewModel: viewModel,
                  isValid: viewModel.isStep2Valid,
                  nextText: 'Continue to Step 3',
                  onComplete: onComplete,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        buildProgressBar(context, 0.4),
      ],
    );
  }
}
