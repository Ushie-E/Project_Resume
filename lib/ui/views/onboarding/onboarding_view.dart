import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/const.dart';
import 'package:stacked/stacked.dart';

import 'onboarding_viewmodel.dart';

class OnboardingView extends StackedView<OnboardingViewModel> {
  final VoidCallback onOnboardingComplete;

  const OnboardingView({
    super.key,
    required this.onOnboardingComplete,
  });

  @override
  Widget builder(BuildContext context, OnboardingViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        elevation: 0,
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
                'Elysian',
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
      body: _buildCurrentStep(context, viewModel),
      bottomNavigationBar: null,
    );
  }

  Widget _buildCurrentStep(BuildContext context, OnboardingViewModel viewModel) {
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
        return viewModel.isBusinessPlan
            ? _buildBusinessStep5(context, viewModel)
            : _buildPersonalStep5(context, viewModel);
      default:
        return _buildStep1(context, viewModel);
    }
  }

  // ---------------------------------------------------------------------------
  // STEP 1: WELCOME & PLAN SELECTION (WITH "I ALREADY HAVE AN ACCOUNT")
  // ---------------------------------------------------------------------------
  Widget _buildStep1(BuildContext context, OnboardingViewModel viewModel) {
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
                _buildPlanCard(
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
                _buildPlanCard(
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
                  onTap: () => viewModel.nextStep(onOnboardingComplete),
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
                // RESTORED: I ALREADY HAVE AN ACCOUNT LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I already have an account.',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                    TextButton(
                      onPressed: viewModel.showAlreadyHaveAccountDialog,
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                          color: kcOnboardingBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ],
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
  // STEP 2: PROFILE/COMPANY DETAILS FORM (STARTS BLANK WITH PLACEHOLDERS)
  // ---------------------------------------------------------------------------
  Widget _buildStep2(BuildContext context, OnboardingViewModel viewModel) {
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
                  _buildTextField(
                    label: 'Company / Agency Name',
                    hintText: 'e.g. Ushie Tech Labs',
                    initialValue: viewModel.companyName,
                    icon: Icons.business,
                    onChanged: viewModel.setCompanyName,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Industry Sector',
                    hintText: 'e.g. Software & AI Solutions',
                    initialValue: viewModel.companySector,
                    icon: Icons.category_outlined,
                    onChanged: viewModel.setCompanySector,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Team Size',
                    hintText: 'e.g. 11-50 Employees',
                    initialValue: viewModel.teamSize,
                    icon: Icons.groups_outlined,
                    onChanged: viewModel.setTeamSize,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Company HQ Location',
                    hintText: 'e.g. Lagos, Nigeria & Remote',
                    initialValue: viewModel.companyLocation,
                    icon: Icons.location_on_outlined,
                    onChanged: viewModel.setCompanyLocation,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Company Overview & Mission',
                    hintText: 'Describe your firm capabilities...',
                    initialValue: viewModel.companyOverview,
                    icon: Icons.notes_outlined,
                    maxLines: 3,
                    onChanged: viewModel.setCompanyOverview,
                  ),
                ] else ...[
                  _buildTextField(
                    label: 'Full Name',
                    hintText: 'e.g. Ushie Emmanuel',
                    initialValue: viewModel.fullName,
                    icon: Icons.person_outline,
                    onChanged: viewModel.setFullName,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Professional Title',
                    hintText: 'e.g. Flutter Mobile Engineer',
                    initialValue: viewModel.jobTitle,
                    icon: Icons.work_outline,
                    onChanged: viewModel.setJobTitle,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Short Bio',
                    hintText: 'Brief summary about your skills...',
                    initialValue: viewModel.bio,
                    icon: Icons.notes_outlined,
                    maxLines: 3,
                    onChanged: viewModel.setBio,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: 'Location',
                    hintText: 'e.g. Lagos, Nigeria',
                    initialValue: viewModel.location,
                    icon: Icons.location_on_outlined,
                    onChanged: viewModel.setLocation,
                  ),
                ],
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
  // STEP 3: SKILLS VS BUSINESS CAPABILITIES
  // ---------------------------------------------------------------------------
  Widget _buildStep3(BuildContext context, OnboardingViewModel viewModel) {
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
  // STEP 4: INTERESTS VS TARGET MARKETS
  // ---------------------------------------------------------------------------
  Widget _buildStep4(BuildContext context, OnboardingViewModel viewModel) {
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
              _buildNavigationButtons(
                viewModel: viewModel,
                isValid: viewModel.isStep4Valid,
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
  // STEP 5 (PERSONAL): PERSONAL PROFILE REVIEW CARD
  // ---------------------------------------------------------------------------
  Widget _buildPersonalStep5(BuildContext context, OnboardingViewModel viewModel) {
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
                  'Double check your details before finalizing setup.',
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
                        viewModel.displayName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      Text(
                        viewModel.displayJobTitle,
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
                          Text(
                              viewModel.location.isEmpty ? 'Not specified' : viewModel.location,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Selected Skills:',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: viewModel.selectedPersonalSkills.map((s) {
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
                  onTap: () => viewModel.nextStep(onOnboardingComplete),
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
  // STEP 5 (BUSINESS): VISUAL DIRECTORY / ELYSIAN ASSETS SHOWCASE
  // ---------------------------------------------------------------------------
  Widget _buildBusinessStep5(BuildContext context, OnboardingViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Banner
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        width: 160,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.9),
                                Colors.grey.shade300.withValues(alpha: 0.4),
                              ],
                              radius: 1.2,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'VISUAL DIRECTORY',
                              style: TextStyle(
                                color: Color(0xFF3F6AD8),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'The Luminous\nAssets of\nElysian',
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1.15,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'A curated collection of architectural illustrations, editorial photography, and abstract textures that define the Effortless Architect identity.',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                                height: 1.4,
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

                // Card 1: Spatial Serenity
                _buildAssetCard(
                  imagePath: 'images/spacea.png',
                  imageHeight: 160,
                  title: 'Spatial Serenity',
                  badge: 'SCREEN_14',
                  description: 'Primary background asset for high-level architectural overview screens.',
                ),
                const SizedBox(height: 20),

                // Card 2: Identity Anchor
                _buildAssetCard(
                  imagePath: viewModel.selectedAvatar,
                  imageHeight: 240,
                  title: 'Identity Anchor',
                  badge: 'SCREEN_2',
                  description: 'Editorial profile picture placeholder for the concierge persona.',
                ),
                const SizedBox(height: 20),

                // Card 3: Organic Rhythm
                _buildAssetCard(
                  imagePath: 'images/spacec.png',
                  imageHeight: 200,
                  title: 'Organic Rhythm',
                  badge: 'SCREEN_10',
                  description: 'Background layering component used for onboarding focus areas.',
                ),
                const SizedBox(height: 20),

                // Card 4: Structural Clarity
                _buildAssetCard(
                  imagePath: 'images/spaced.png',
                  imageHeight: 160,
                  title: 'Structural Clarity',
                  badge: 'SCREEN_9',
                  description: "High-impact header image for the 'Review and Submit' finalization phase.",
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        // Bottom Progress Indicator & Dual Buttons
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.75,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF254EDB),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Visual Compliance: 75% Complete',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontFamily: 'Google Sans',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Exporting all brand assets & specifications...'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFA5F3FC), Color(0xFF67E8F9)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Export All\nAssets',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                              height: 1.1,
                              fontFamily: 'Google Sans',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => viewModel.nextStep(onOnboardingComplete),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3F6AD8).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Continue\nOnboarding',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                              fontFamily: 'Google Sans',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssetCard({
    required String imagePath,
    required double imageHeight,
    required String title,
    required String badge,
    required String description,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              imagePath,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: imageHeight,
                  color: kcOnboardingBlue,
                  child: const Center(
                    child: Icon(Icons.architecture_outlined, size: 60, color: Colors.white),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Google Sans',
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 0.5,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.35,
                    fontFamily: 'Google Sans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  Widget _buildTextField({
    required String label,
    String? hintText,
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
        hintText: hintText,
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
    required OnboardingViewModel viewModel,
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
            onTap: isValid ? () => viewModel.nextStep(onOnboardingComplete) : null,
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

  void _showAvatarPicker(BuildContext context, OnboardingViewModel viewModel) {
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
                'Update Profile Picture',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.photo_library, color: kcOnboardingBlue),
                title: const Text('Choose from Gallery / Photos'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.setAvatar('images/ushie.png');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Selected photo from device gallery')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: kcOnboardingBlue),
                title: const Text('Take Photo with Camera'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.setAvatar('images/spacea.png');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Captured profile photo with camera')),
                  );
                },
              ),
              const Divider(),
              const Text(
                'Or Select Preset Avatars',
                style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
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
                        radius: 24,
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
  OnboardingViewModel viewModelBuilder(BuildContext context) => OnboardingViewModel();
}
