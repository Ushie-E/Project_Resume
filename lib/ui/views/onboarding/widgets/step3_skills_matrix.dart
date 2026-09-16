import 'package:flutter/material.dart';
import 'package:project/models/resume_models.dart';
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
                  viewModel.isBusinessPlan ? 'Capabilities & Client Deliveries' : 'Skills & Work Experience',
                  style: kOnboardingTitleStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  viewModel.isBusinessPlan
                      ? 'Select your firm capabilities and review enterprise deliveries.'
                      : 'Select your core technical skills and review your verified work history.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 20),
                Text(
                  viewModel.isBusinessPlan ? 'Core Capabilities' : 'Technical Expertise',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Google Sans',
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 12),
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
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        viewModel.isBusinessPlan ? 'Enterprise Client Deliveries' : 'Work History & Deliverables',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Google Sans',
                          color: Color(0xFF0F172A),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: kcOnboardingBlue),
                      tooltip: 'Add Role / Delivery',
                      onPressed: () => _showAddExperienceDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ...viewModel.experiences.map((exp) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                exp.role,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: kcTealBackground,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                exp.period,
                                style: const TextStyle(
                                  color: kcTealIcon,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          exp.company,
                          style: const TextStyle(
                            color: kcOnboardingBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          exp.description,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 32),
                buildNavigationButtons(
                  viewModel: viewModel,
                  isValid: viewModel.isStep3Valid,
                  nextText: 'Continue to Step 4',
                  onComplete: onComplete,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        buildProgressBar(context, 0.6),
      ],
    );
  }

  void _showAddExperienceDialog(BuildContext context) {
    final companyController = TextEditingController();
    final roleController = TextEditingController();
    final periodController = TextEditingController(text: '2024 - Present');
    final descController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          viewModel.isBusinessPlan ? 'Add Client Delivery' : 'Add Work Experience',
          style: const TextStyle(fontFamily: 'Google Sans', fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: roleController,
                decoration: InputDecoration(
                  labelText: viewModel.isBusinessPlan ? 'Project / Solution Name' : 'Role Title',
                  hintText: 'e.g. Senior Mobile Architect',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: companyController,
                decoration: InputDecoration(
                  labelText: viewModel.isBusinessPlan ? 'Client / Org' : 'Company Name',
                  hintText: 'e.g. Vertex Mobile',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: periodController,
                decoration: const InputDecoration(
                  labelText: 'Timeframe',
                  hintText: 'e.g. 2022 - 2024',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: descController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Highlights & Achievements',
                  hintText: 'Engineered cross-platform app...',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (roleController.text.isNotEmpty && companyController.text.isNotEmpty) {
                viewModel.addExperience(ExperienceItem(
                  company: companyController.text.trim(),
                  role: roleController.text.trim(),
                  period: periodController.text.trim(),
                  description: descController.text.trim(),
                ));
              }
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
