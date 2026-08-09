import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/const.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        elevation: 0,
        leading: (!viewModel.isOnboardingComplete && viewModel.currentStep > 1)
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: viewModel.prevStep,
              )
            : null,
        title: Text(
          viewModel.isOnboardingComplete
              ? 'My Profile'
              : 'Create Profile (Step ${viewModel.currentStep} of 5)',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Google Sans',
          ),
        ),
        actions: viewModel.isOnboardingComplete
            ? [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: kcOnboardingBlue),
                  tooltip: 'Edit Profile Onboarding',
                  onPressed: viewModel.restartOnboarding,
                ),
              ]
            : null,
        centerTitle: false,
      ),
      body: viewModel.isOnboardingComplete
          ? _buildMainDashboard(context, viewModel)
          : _buildCurrentStep(context, viewModel),
      // Hide bottom navigation bar completely during onboarding flow
      bottomNavigationBar: viewModel.isOnboardingComplete
          ? _buildBottomNavigationBar(context, viewModel)
          : null,
    );
  }

  Widget _buildCurrentStep(BuildContext context, HomeViewModel viewModel) {
    switch (viewModel.currentStep) {
      case 1:
        return _buildStep1(context, viewModel);
      case 2:
        return _buildStep2(context, viewModel);
      case 3:
        return _buildStep3(context, viewModel);
      case 4:
        return _buildStep4(context, viewModel);
      case 5:
        return _buildStep5(context, viewModel);
      default:
        return _buildStep1(context, viewModel);
    }
  }

  // ---------------------------------------------------------------------------
  // COMPLETED MAIN DASHBOARD (Shown ONLY after onboarding flow finishes)
  // ---------------------------------------------------------------------------
  Widget _buildMainDashboard(BuildContext context, HomeViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero Profile Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white24,
                      backgroundImage: AssetImage(viewModel.selectedAvatar),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  viewModel.fullName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Google Sans',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  viewModel.jobTitle,
                  style: const TextStyle(
                    color: Color(0xFF1BFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Google Sans',
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, color: Colors.white70, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      viewModel.location,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${viewModel.selectedPlan} Plan',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Bio Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About Me',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kcOnboardingBlue,
                    fontFamily: 'Google Sans',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  viewModel.bio,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.4,
                    fontFamily: 'Google Sans',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Skills Section
          const Text(
            'Technical Expertise',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Google Sans',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: viewModel.selectedSkills.map((skill) {
              return Chip(
                avatar: const Icon(Icons.code, size: 16, color: kcOnboardingBlue),
                label: Text(skill),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Google Sans',
                ),
                backgroundColor: kcTealBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // Interests Section
          const Text(
            'Curated Interests',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Google Sans',
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: viewModel.selectedInterests.map((interest) {
              return Chip(
                avatar: const Icon(Icons.star, size: 16, color: kcPurpleIcon),
                label: Text(interest),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Google Sans',
                ),
                backgroundColor: kcPurpleBackground,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          // Edit Profile Onboarding Button
          GestureDetector(
            onTap: viewModel.restartOnboarding,
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: kcOnboardingBlue, width: 2),
                color: Colors.white,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, color: kcOnboardingBlue),
                  SizedBox(width: 8),
                  Text(
                    'Restart Onboarding Setup',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kcOnboardingBlue,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 1: WELCOME & PLAN SELECTION
  // ---------------------------------------------------------------------------
  Widget _buildStep1(BuildContext context, HomeViewModel viewModel) {
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
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8B2635), Color(0xFF4A121A)],
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
                          onTap: () => _showAvatarPicker(context, viewModel),
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
                                child: ClipOval(
                                  child: Image.asset(
                                    viewModel.selectedAvatar,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.white24,
                                        child: const Icon(
                                          Icons.person,
                                          size: 70,
                                          color: Colors.white,
                                        ),
                                      );
                                    },
                                  ),
                                ),
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
                          'Tap avatar to update profile picture',
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
                          color: const Color(0xFF3F6AD8).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
              ],
            ),
          ),
        ),
        _buildProgressBar(context, 0.2),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 2: PROFILE DETAILS FORM
  // ---------------------------------------------------------------------------
  Widget _buildStep2(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Information',
                  style: kOnboardingTitleStyle,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tell us a bit about yourself to personalize your digital resume profile.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  label: 'Full Name',
                  initialValue: viewModel.fullName,
                  icon: Icons.person_outline,
                  onChanged: viewModel.setFullName,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Professional Title',
                  initialValue: viewModel.jobTitle,
                  icon: Icons.work_outline,
                  onChanged: viewModel.setJobTitle,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Short Bio',
                  initialValue: viewModel.bio,
                  icon: Icons.notes_outlined,
                  maxLines: 3,
                  onChanged: viewModel.setBio,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Location',
                  initialValue: viewModel.location,
                  icon: Icons.location_on_outlined,
                  onChanged: viewModel.setLocation,
                ),
                const SizedBox(height: 32),
                _buildNavigationButtons(
                  viewModel: viewModel,
                  isValid: viewModel.isStep2Valid,
                  nextText: 'Continue to Step 3',
                ),
              ],
            ),
          ),
        ),
        _buildProgressBar(context, 0.4),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 3: SKILLS & EXPERTISE
  // ---------------------------------------------------------------------------
  Widget _buildStep3(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Skills & Expertise',
                  style: kOnboardingTitleStyle,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Select at least 2 key skills or technologies that define your professional expertise.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: viewModel.availableSkills.map((skill) {
                    final isSelected = viewModel.selectedSkills.contains(skill);
                    return FilterChip(
                      selected: isSelected,
                      label: Text(skill),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Google Sans',
                      ),
                      selectedColor: kcOnboardingBlue,
                      backgroundColor: kcOnboardingUnselectedCard,
                      onSelected: (_) => viewModel.toggleSkill(skill),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 32),
                _buildNavigationButtons(
                  viewModel: viewModel,
                  isValid: viewModel.isStep3Valid,
                  nextText: 'Continue to Step 4',
                ),
              ],
            ),
          ),
        ),
        _buildProgressBar(context, 0.6),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 4: INTEREST SELECTION
  // ---------------------------------------------------------------------------
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
                          const Text(
                            'Curate your experience.',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Google Sans',
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Tell us what moves you, and we'll handle the rest.",
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
              const Text(
                'What interests you?',
                style: kOnboardingTitleStyle,
              ),
              const SizedBox(height: 8),
              const Text(
                'Select at least 3 categories to personalize your recommendations.',
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
                  return _buildCategoryCard(
                    cat['title'] as String,
                    cat['icon'] as IconData,
                    viewModel,
                  );
                }).toList(),
              ),
              const SizedBox(height: 28),
              _buildNavigationButtons(
                viewModel: viewModel,
                isValid: viewModel.isInterestGridValid,
                nextText: 'Continue to Step 5',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        _buildProgressBar(context, 0.8),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // STEP 5: REVIEW & CONFIRM PROFILE
  // ---------------------------------------------------------------------------
  Widget _buildStep5(BuildContext context, HomeViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Review Profile',
                  style: kOnboardingTitleStyle,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Double check your details before finalizing your profile.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(viewModel.selectedAvatar),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        viewModel.fullName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      Text(
                        viewModel.jobTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: kcOnboardingBlue,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Plan Type:', style: TextStyle(color: Colors.grey)),
                          Text(viewModel.selectedPlan,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Location:', style: TextStyle(color: Colors.grey)),
                          Text(viewModel.location,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Selected Skills:', style: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: viewModel.selectedSkills.map((s) {
                          return Chip(
                            label: Text(s, style: const TextStyle(fontSize: 12)),
                            backgroundColor: kcTealBackground,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
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
                    ),
                    child: const Center(
                      child: Text(
                        'Complete Profile Setup',
                        style: TextStyle(
                          fontSize: 18,
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
          ),
        ),
        _buildProgressBar(context, 1.0),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // HELPER WIDGETS
  // ---------------------------------------------------------------------------
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
                    color: Colors.blue.withValues(alpha: 0.08),
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

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required IconData icon,
    int maxLines = 1,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: kcOnboardingBlue),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildNavigationButtons({
    required HomeViewModel viewModel,
    required bool isValid,
    required String nextText,
  }) {
    return Row(
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
        const SizedBox(width: 8),
        Flexible(
          child: GestureDetector(
            onTap: isValid ? viewModel.nextStep : null,
            child: Opacity(
              opacity: isValid ? 1.0 : 0.5,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: isValid
                      ? const LinearGradient(
                          colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: isValid ? null : Colors.grey[400],
                ),
                child: Text(
                  nextText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Google Sans',
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context, double factor) {
    return Container(
      width: double.infinity,
      height: 4,
      color: Colors.grey[200],
      child: Align(
        alignment: Alignment.centerLeft,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: MediaQuery.of(context).size.width * factor,
          height: 4,
          color: kcOnboardingBlue,
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
      currentIndex: 1,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'My Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  void _showAvatarPicker(BuildContext context, HomeViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Profile Picture',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: viewModel.availableAvatars.map((avatarPath) {
                  final isSelected = viewModel.selectedAvatar == avatarPath;
                  return GestureDetector(
                    onTap: () {
                      viewModel.setAvatar(avatarPath);
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? kcOnboardingBlue : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(avatarPath),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
