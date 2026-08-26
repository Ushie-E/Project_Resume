import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/views/explore/explore_view.dart';
import 'package:project/ui/views/onboarding/onboarding_view.dart';
import 'package:project/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    if (!viewModel.isOnboardingComplete) {
      return OnboardingView(
        onOnboardingComplete: viewModel.completeOnboardingWithData,
      );
    }

    return Scaffold(
      backgroundColor: kcBackgroundColor,
      body: IndexedStack(
        index: viewModel.selectedTabIndex,
        children: [
          const ExploreView(),
          _buildMainDashboard(context, viewModel),
          SettingsView(
            onRestartOnboarding: viewModel.restartOnboarding,
            userAvatar: viewModel.selectedAvatar,
            userName: viewModel.fullName,
            userTitle: viewModel.jobTitle,
            planType: viewModel.selectedPlan,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: kcOnboardingBlue,
        unselectedItemColor: Colors.grey,
        currentIndex: viewModel.selectedTabIndex,
        onTap: viewModel.setSelectedTabIndex,
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
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // MAIN DASHBOARD (Tab Index 1)
  // ---------------------------------------------------------------------------
  Widget _buildMainDashboard(BuildContext context, HomeViewModel viewModel) {
    final bool isBusiness = viewModel.selectedPlan == 'Business';

    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          isBusiness ? 'Company Profile' : 'My Profile',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Google Sans',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: kcOnboardingBlue),
            tooltip: 'Edit Profile Onboarding',
            onPressed: viewModel.restartOnboarding,
          ),
        ],
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: isBusiness
                      ? const [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)]
                      : const [Color(0xFF8B2635), Color(0xFF4A121A)],
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
                      viewModel.selectedAvatar == 'images/empty_profile.png'
                          ? const CircleAvatar(
                              radius: 48,
                              backgroundColor: Color(0xFFE2E8F0),
                              child: Icon(Icons.person_outline, size: 52, color: Color(0xFF64748B)),
                            )
                          : CircleAvatar(
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
                  Text(
                    isBusiness ? 'Company Overview' : 'About Me',
                    style: const TextStyle(
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
            Text(
              isBusiness ? 'Enterprise Capabilities' : 'Technical Expertise',
              style: const TextStyle(
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
                  avatar: Icon(isBusiness ? Icons.business_center : Icons.code, size: 16, color: kcOnboardingBlue),
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
            Text(
              isBusiness ? 'Target Markets' : 'Curated Interests',
              style: const TextStyle(
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
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
