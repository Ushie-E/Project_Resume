import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/responsive_layout.dart';
import 'package:project/ui/views/explore/explore_view.dart';
import 'package:project/ui/views/onboarding/onboarding_view.dart';
import 'package:project/ui/views/settings/settings_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialise();

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    if (!viewModel.isOnboardingComplete) {
      return OnboardingView(
        onOnboardingComplete: viewModel.completeOnboardingWithData,
      );
    }

    final isDark = viewModel.darkMode;
    final bgColor = isDark ? const Color(0xFF0F172A) : kcBackgroundColor;
    final bottomNavBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final unselectedColor = isDark ? Colors.white54 : Colors.grey;

    return Scaffold(
      backgroundColor: bgColor,
      body: IndexedStack(
        index: viewModel.selectedTabIndex,
        children: [
          ExploreView(darkMode: isDark),
          _buildMainDashboard(context, viewModel),
          SettingsView(
            onRestartOnboarding: viewModel.restartOnboarding,
            userAvatar: viewModel.selectedAvatar,
            userName: viewModel.fullName,
            userTitle: viewModel.jobTitle,
            planType: viewModel.selectedPlan,
            darkMode: isDark,
            onToggleDarkMode: viewModel.toggleDarkMode,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bottomNavBg,
        selectedItemColor: kcOnboardingBlue,
        unselectedItemColor: unselectedColor,
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
    final bool isDark = viewModel.darkMode;

    final bgColor = isDark ? const Color(0xFF0F172A) : kcBackgroundColor;
    final cardBgColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final primaryTextColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.grey[800];
    final borderColor = isDark ? Colors.white12 : Colors.black.withValues(alpha: 0.06);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          isBusiness ? 'Company Profile' : 'My Digital Resume',
          style: TextStyle(
            color: primaryTextColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Google Sans',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded, color: kcOnboardingBlue),
            tooltip: 'Download Resume / CV',
            onPressed: () => viewModel.showDownloadResumeModal(context),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: kcOnboardingBlue),
            tooltip: 'Share Portfolio Link',
            onPressed: () => viewModel.sharePortfolio(context),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: kcOnboardingBlue),
            tooltip: 'Edit Profile Onboarding',
            onPressed: viewModel.restartOnboarding,
          ),
        ],
        centerTitle: false,
      ),
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Hero Banner Card
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
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black45 : Colors.black26,
                      blurRadius: 15,
                      offset: const Offset(0, 6),
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
                      textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFF1BFFFF),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 12,
                      runSpacing: 6,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              viewModel.location,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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

              const SizedBox(height: 16),

              // Direct Contact Quick Icons Row
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildContactIconBtn(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        color: const Color(0xFF254EDB),
                        onTap: () => viewModel.copyEmail(context),
                      ),
                    ),
                    Expanded(
                      child: _buildContactIconBtn(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        color: Colors.green,
                        onTap: () => viewModel.copyPhone(context),
                      ),
                    ),
                    Expanded(
                      child: _buildContactIconBtn(
                        icon: Icons.code,
                        label: 'GitHub',
                        color: Colors.purple,
                        onTap: () => viewModel.copyGithub(context),
                      ),
                    ),
                    Expanded(
                      child: _buildContactIconBtn(
                        icon: Icons.link,
                        label: 'LinkedIn',
                        color: Colors.blue,
                        onTap: () => viewModel.copyLinkedin(context),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Executive Highlights & Stats Bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black38 : Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        value: isBusiness ? '50+' : '5+ Yrs',
                        label: isBusiness ? 'Global Clients' : 'Experience',
                        icon: isBusiness ? Icons.business_outlined : Icons.timeline_outlined,
                        color: const Color(0xFF3B82F6),
                        isDark: isDark,
                      ),
                    ),
                    Container(height: 36, width: 1, color: borderColor),
                    Expanded(
                      child: _buildStatItem(
                        value: isBusiness ? '99.99%' : '24+',
                        label: isBusiness ? 'SLA Uptime' : 'Apps Built',
                        icon: isBusiness ? Icons.cloud_done_outlined : Icons.rocket_launch_outlined,
                        color: const Color(0xFF10B981),
                        isDark: isDark,
                      ),
                    ),
                    Container(height: 36, width: 1, color: borderColor),
                    Expanded(
                      child: _buildStatItem(
                        value: '${viewModel.certifications.length}',
                        label: isBusiness ? 'Accreditations' : 'Certifications',
                        icon: Icons.verified_outlined,
                        color: const Color(0xFF8B5CF6),
                        isDark: isDark,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Primary Action Buttons: Download CV & Contact
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () => viewModel.showDownloadResumeModal(context),
                      child: Container(
                        height: 48,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3F6AD8).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.download_rounded, color: Colors.white, size: 16),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                isBusiness ? 'Export Profile' : 'Download CV',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'Google Sans',
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () => viewModel.showContactModal(context),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: cardBgColor,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: kcOnboardingBlue, width: 1.5),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.send_rounded, color: kcOnboardingBlue, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Contact',
                              style: TextStyle(
                                color: kcOnboardingBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Bio / Executive Summary Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: cardBgColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: isDark ? Colors.black45 : Colors.black12,
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isBusiness ? 'Company Overview & Mission' : 'Executive Summary',
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
                        color: secondaryTextColor,
                        height: 1.45,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Work Experience Timeline
              Text(
                isBusiness ? 'Enterprise Client Deliveries' : 'Work Experience Timeline',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 12),
              ...viewModel.experiences.map((exp) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: borderColor),
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black38 : Colors.black.withValues(alpha: 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
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
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: primaryTextColor,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: isDark ? const Color(0xFF0F172A) : kcTealBackground,
                              borderRadius: BorderRadius.circular(8),
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
                      const SizedBox(height: 8),
                      Text(
                        exp.description,
                        style: TextStyle(
                          color: secondaryTextColor,
                          fontSize: 13,
                          height: 1.35,
                        ),
                      ),
                      if (exp.highlights.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        ...exp.highlights.map((h) => Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('• ', style: TextStyle(color: kcOnboardingBlue, fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      h,
                                      style: TextStyle(
                                        color: isDark ? Colors.white70 : Colors.grey[700],
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Certifications & Education Section
              Text(
                isBusiness ? 'Accreditations & Industry Standards' : 'Certifications & Credentials',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 12),
              ...viewModel.certifications.map((cert) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: cardBgColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF0F172A) : kcPurpleBackground,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.verified, size: 20, color: kcPurpleIcon),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cert.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: primaryTextColor,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${cert.issuer} • ${cert.year}',
                              style: TextStyle(
                                color: isDark ? Colors.white60 : Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Skills Section
              Text(
                isBusiness ? 'Enterprise Capabilities' : 'Technical Expertise & Stack',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: viewModel.selectedSkills.map((skill) {
                  return Chip(
                    avatar: Icon(
                      isBusiness ? Icons.business_center : Icons.code,
                      size: 16,
                      color: kcOnboardingBlue,
                    ),
                    label: Text(skill),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                      fontFamily: 'Google Sans',
                    ),
                    backgroundColor: isDark ? const Color(0xFF1E293B) : kcTealBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Hobbies / Core Services Section
              Text(
                isBusiness ? 'Core Services & Offerings' : 'Hobbies & Creative Pursuits',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryTextColor,
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (viewModel.hobbies.isNotEmpty ? viewModel.hobbies : viewModel.selectedInterests)
                    .map((item) {
                  return Chip(
                    avatar: const Icon(Icons.star, size: 16, color: kcPurpleIcon),
                    label: Text(item),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                      fontFamily: 'Google Sans',
                    ),
                    backgroundColor: isDark ? const Color(0xFF1E293B) : kcPurpleBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 32),

              // Restart Onboarding Button (Overflow-safe)
              GestureDetector(
                onTap: viewModel.restartOnboarding,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: kcOnboardingBlue, width: 2),
                    color: cardBgColor,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh, color: kcOnboardingBlue),
                      SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Restart Profile Wizard',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: kcOnboardingBlue,
                            fontFamily: 'Google Sans',
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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
    );
  }

  Widget _buildContactIconBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
                fontFamily: 'Google Sans',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 4),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                    fontFamily: 'Google Sans',
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white60 : Colors.grey[600],
              fontFamily: 'Google Sans',
            ),
          ),
        ),
      ],
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
