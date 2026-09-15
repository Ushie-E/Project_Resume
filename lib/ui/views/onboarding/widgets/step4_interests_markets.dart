import 'package:flutter/material.dart';
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
                constraints: const BoxConstraints(minHeight: 160),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            viewModel.isBusinessPlan
                                ? 'Target Industry Matching.'
                                : 'Curate your experience.',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Google Sans',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            viewModel.isBusinessPlan
                                ? 'Select target industry sectors to match your firm with enterprise opportunities.'
                                : "Tell us what moves you, and we'll handle the rest.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withValues(alpha: 0.9),
                              fontFamily: 'Google Sans',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                viewModel.isBusinessPlan ? 'Select Target Markets' : 'What interests you?',
                style: kOnboardingTitleStyle,
              ),
              const SizedBox(height: 8),
              Text(
                viewModel.isBusinessPlan
                    ? 'Select at least 3 industry sectors.'
                    : 'Select at least 3 categories to personalize your recommendations.',
                style: kOnboardingSubtitleStyle,
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
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
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          if (isSelected)
                            const Positioned(
                              right: 0,
                              top: 0,
                              child: Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected
                                      ? Colors.white.withValues(alpha: 0.2)
                                      : kcTealBackground,
                                ),
                                child: Icon(
                                  icon,
                                  color: isSelected ? Colors.white : kcTealIcon,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 14,
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
                isValid: viewModel.isStep4Valid,
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
}
