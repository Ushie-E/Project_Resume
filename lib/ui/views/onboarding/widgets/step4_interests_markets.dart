import 'package:flutter/material.dart';
import 'package:project/models/resume_models.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/const.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';
import 'onboarding_shared_widgets.dart';

class Step4InterestsMarkets extends StatelessWidget {
  final OnboardingViewModel viewModel;
  final OnboardingCompleteCallback onComplete;

  const Step4InterestsMarkets({
    super.key,
    required this.viewModel,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final categories = viewModel.isBusinessPlan
        ? [
            {'title': 'Enterprise Tech', 'icon': Icons.business_center_outlined},
            {'title': 'Architecture & Real Estate', 'icon': Icons.apartment_outlined},
            {'title': 'FinTech', 'icon': Icons.account_balance_outlined},
            {'title': 'Healthcare Solutions', 'icon': Icons.local_hospital_outlined},
            {'title': 'E-Commerce & Retail', 'icon': Icons.shopping_bag_outlined},
            {'title': 'Media & Entertainment', 'icon': Icons.movie_outlined},
          ]
        : [
            {'title': 'Technology', 'icon': Icons.science_outlined},
            {'title': 'Design', 'icon': Icons.architecture_outlined},
            {'title': 'Travel', 'icon': Icons.flight_takeoff_outlined},
            {'title': 'Music', 'icon': Icons.music_note_outlined},
            {'title': 'Business', 'icon': Icons.trending_up_outlined},
            {'title': 'Health', 'icon': Icons.fitness_center_outlined},
            {'title': 'Literature', 'icon': Icons.menu_book_outlined},
            {'title': 'Film', 'icon': Icons.movie_outlined},
            {'title': 'Art', 'icon': Icons.palette_outlined},
          ];

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              const SizedBox(height: 16),
              Container(
                constraints: const BoxConstraints(minHeight: 140),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        viewModel.isBusinessPlan
                            ? 'Accreditations & Markets'
                            : 'Certifications & Interests',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        viewModel.isBusinessPlan
                            ? 'Configure firm accreditations, standards, and target enterprise verticals.'
                            : 'Highlight your verified licenses, cloud credentials, and personal pursuits.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Certifications Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      viewModel.isBusinessPlan ? 'Firm Accreditations & Standards' : 'Certifications & Credentials',
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
                    tooltip: 'Add Certification',
                    onPressed: () => _showAddCertificationDialog(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...viewModel.certifications.map((cert) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: kcPurpleBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.verified, size: 20, color: kcPurpleIcon),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cert.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                            Text(
                              '${cert.issuer} • ${cert.year}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),
              Text(
                viewModel.isBusinessPlan ? 'Select Target Industry Sectors' : 'Personal Interests & Culture',
                style: kOnboardingTitleStyle,
              ),
              const SizedBox(height: 6),
              Text(
                viewModel.isBusinessPlan
                    ? 'Select at least 3 industry sectors to match target clients.'
                    : 'Select at least 3 categories that reflect your creative pursuits.',
                style: kOnboardingSubtitleStyle,
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.25,
                children: categories.map((cat) {
                  final String title = cat['title'] as String;
                  final IconData icon = cat['icon'] as IconData;
                  final isSelected = viewModel.isBusinessPlan
                      ? viewModel.selectedTargetMarkets.contains(title)
                      : viewModel.selectedPersonalInterests.contains(title);
                  return GestureDetector(
                    onTap: () {
                      if (viewModel.isBusinessPlan) {
                        viewModel.toggleTargetMarket(title);
                      } else {
                        viewModel.togglePersonalInterest(title);
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      decoration: BoxDecoration(
                        color: isSelected ? kcOnboardingBlue : kcOnboardingUnselectedCard,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: kcOnboardingBlue.withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : null,
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Stack(
                        children: [
                          if (isSelected)
                            const Positioned(
                              right: 0,
                              top: 0,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.white.withValues(alpha: 0.2)
                                      : kcTealBackground,
                                ),
                                child: Icon(
                                  icon,
                                  color: isSelected ? Colors.white : kcTealIcon,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: isSelected ? Colors.white : kcOnboardingCardText,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),
              buildNavigationButtons(
                viewModel: viewModel,
                isValid: viewModel.isStep5Valid,
                nextText: 'Continue to Step 5',
                onComplete: onComplete,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        buildProgressBar(context, 0.8),
      ],
    );
  }

  void _showAddCertificationDialog(BuildContext context) {
    final titleController = TextEditingController();
    final issuerController = TextEditingController();
    final yearController = TextEditingController(text: '2024');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Add Certification',
          style: TextStyle(fontFamily: 'Google Sans', fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Certification / Standard Title',
                hintText: 'e.g. AWS Certified Solutions Architect',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: issuerController,
              decoration: const InputDecoration(
                labelText: 'Issuing Body',
                hintText: 'e.g. Amazon Web Services',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: 'Year Issued',
                hintText: '2023',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && issuerController.text.isNotEmpty) {
                viewModel.addCertification(CertificationItem(
                  title: titleController.text.trim(),
                  issuer: issuerController.text.trim(),
                  year: yearController.text.trim(),
                  credentialUrl: 'https://credential.net',
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
