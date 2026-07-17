import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/const.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: viewModel.currentStep > 1 ? viewModel.prevStep : null,
        ),
        title: const Text(
          'Create Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Google Sans',
          ),
        ),
        centerTitle: false,
      ),
      body: viewModel.currentStep == 1
          ? _buildStep1(context, viewModel)
          : _buildStep4(context, viewModel),
      bottomNavigationBar: viewModel.currentStep == 4
          ? _buildBottomNavigationBar(context, viewModel)
          : null,
    );
  }

  Widget _buildStep1(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Welcome card with gradient background and user avatar illustration
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B2635), Color(0xFF4A121A)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: Image.asset(
                      'images/user.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.white,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Heading
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
                // Subtitle
                const Text(
                  "Let's begin by tailoring your experience. How do you plan to use our platform today?",
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                // Personal Option Card
                _buildPlanCard(
                  title: 'Personal',
                  description:
                      'For individuals seeking to organize projects and find creative inspiration.',
                  icon: Icons.account_tree_outlined,
                  iconBg: kcTealBackground,
                  iconColor: kcTealIcon,
                  isSelected: viewModel.selectedPlan == 'Personal',
                  onTap: () => viewModel.setPlan('Personal'),
                ),
                const SizedBox(height: 16),
                // Business Option Card
                _buildPlanCard(
                  title: 'Business',
                  description:
                      'For teams and firms looking for advanced collaboration and management tools.',
                  icon: Icons.business_outlined,
                  iconBg: kcPurpleBackground,
                  iconColor: kcPurpleIcon,
                  isSelected: viewModel.selectedPlan == 'Business',
                  onTap: () => viewModel.setPlan('Business'),
                ),
                const SizedBox(height: 32),
                // Get Started Button
                GestureDetector(
                  onTap: viewModel.nextStep,
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
                          color: const Color(0xFF3F6AD8).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Google Sans',
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Text link
                const Center(
                  child: Text(
                    'I already have an account',
                    style: TextStyle(
                      color: kcOnboardingBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        // Progress bar at the bottom
        Container(
          width: double.infinity,
          height: 4,
          color: Colors.grey[200],
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: 4,
              color: kcOnboardingBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String description,
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : kcOnboardingUnselectedCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? kcOnboardingSelectedBorder : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBg,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kcOnboardingCardText,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.3,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep4(BuildContext context, HomeViewModel viewModel) {
    final categories = [
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        children: [
          const SizedBox(height: 16),
          // Curate experience header card with blue/cyan gradient
          Container(
            height: 200,
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
                      color: Colors.white.withOpacity(0.1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Curate your\nexperience.',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Google Sans',
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tell us what moves you, and we'll handle the rest.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
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
          // Progress bar indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Progress',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Google Sans',
                ),
              ),
              Text(
                '80% COMPLETE',
                style: TextStyle(
                  color: kcOnboardingBlue,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Google Sans',
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              width: double.infinity,
              height: 6,
              color: Colors.grey[200],
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 6,
                  color: kcOnboardingBlue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'PERSONALIZATION',
            style: TextStyle(
              color: kcOnboardingBlue,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.2,
              fontFamily: 'Google Sans',
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'What interests you?',
            style: kOnboardingTitleStyle,
          ),
          const SizedBox(height: 8),
          const Text(
            'Select at least 3 categories to help our digital concierge tailor your workspace and recommendations.',
            style: kOnboardingSubtitleStyle,
          ),
          const SizedBox(height: 24),
          // Category grid (2 columns)
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.15,
            children: categories.map((cat) {
              return _buildCategoryCard(
                cat['title'] as String,
                cat['icon'] as IconData,
                viewModel,
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          // Actions footer: Back (left) and Continue (right)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: viewModel.prevStep,
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: kcOnboardingBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Google Sans',
                  ),
                ),
              ),
              GestureDetector(
                onTap: viewModel.isInterestGridValid ? viewModel.nextStep : null,
                child: Opacity(
                  opacity: viewModel.isInterestGridValid ? 1.0 : 0.6,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: viewModel.isInterestGridValid
                          ? const LinearGradient(
                              colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      color:
                          viewModel.isInterestGridValid ? null : Colors.grey[400],
                      boxShadow: viewModel.isInterestGridValid
                          ? [
                              BoxShadow(
                                color: const Color(0xFF3F6AD8).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    child: const Text(
                      'Continue to Step 5',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(
      String title, IconData icon, HomeViewModel viewModel) {
    final isSelected = viewModel.selectedInterests.contains(title);
    return GestureDetector(
      onTap: () => viewModel.toggleInterest(title),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected ? kcOnboardingBlue : kcOnboardingUnselectedCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: kcOnboardingBlue.withOpacity(0.25),
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
                        ? Colors.white.withOpacity(0.2)
                        : (title == 'Design' ||
                                title == 'Music' ||
                                title == 'Film')
                            ? kcPurpleBackground
                            : kcTealBackground,
                  ),
                  child: Icon(
                    icon,
                    color: isSelected
                        ? Colors.white
                        : (title == 'Design' ||
                                title == 'Music' ||
                                title == 'Film')
                            ? kcPurpleIcon
                            : kcTealIcon,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
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
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, HomeViewModel viewModel) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: kcOnboardingBlue,
      unselectedItemColor: Colors.grey,
      currentIndex: 1, // Onboarding active
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add),
          label: 'Onboarding',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

