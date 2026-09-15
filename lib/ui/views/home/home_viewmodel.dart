import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/app/app.locator.dart';
import 'package:project/app/app.dialogs.dart';
import 'package:project/services/preferences_service.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel implements Initialisable {
  final _dialogService = locator<DialogService>();
  final _preferencesService = locator<PreferencesService>();

  int _currentStep = 1;
  int get currentStep => _currentStep;

  bool _isOnboardingComplete = false;
  bool get isOnboardingComplete => _isOnboardingComplete;

  // Bottom Navigation Tab Index: 0 = Explore, 1 = My Profile, 2 = Settings
  int _selectedTabIndex = 1;
  int get selectedTabIndex => _selectedTabIndex;

  HomeViewModel() {
    _initExploreProjects();
  }

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    rebuildUi();
  }

  // ---------------------------------------------------------------------------
  // INITIALIZATION & PERSISTENCE
  // ---------------------------------------------------------------------------
  @override
  void initialise() {
    initFromPreferences();
    _initExploreProjects();
  }

  void initFromPreferences() {
    if (_preferencesService.isOnboardingComplete) {
      _isOnboardingComplete = true;
      _selectedPlan = _preferencesService.selectedPlan;
      _selectedAvatar = _preferencesService.selectedAvatar;
      _fullName = _preferencesService.fullName;
      _jobTitle = _preferencesService.jobTitle;
      _bio = _preferencesService.bio;
      _location = _preferencesService.location;
      _selectedSkills = Set.from(_preferencesService.skills);
      _selectedInterests = Set.from(_preferencesService.interests);
      _darkMode = _preferencesService.darkMode;
      _notificationsEnabled = _preferencesService.notificationsEnabled;
      _analyticsEnabled = _preferencesService.analyticsEnabled;
      rebuildUi();
    }
  }

  // ---------------------------------------------------------------------------
  // PROFILE & AVATAR STATE
  // ---------------------------------------------------------------------------
  String _selectedPlan = 'Personal';
  String get selectedPlan => _selectedPlan;

  final List<String> availableAvatars = const [
    'images/empty_profile.png',
    'images/spacea.png',
    'images/spacec.png',
    'images/spaced.png',
    'images/spacee.png',
    'images/spaceg.png',
  ];

  String _selectedAvatar = 'images/empty_profile.png';
  String get selectedAvatar => _selectedAvatar;

  String _fullName = 'Ushie Emmanuel';
  String get fullName => _fullName;

  String _jobTitle = 'Flutter Mobile Engineer';
  String get jobTitle => _jobTitle;

  String _bio = 'Crafting high-performance cross-platform applications with Flutter & Stacked.';
  String get bio => _bio;

  String _location = 'Lagos, Nigeria';
  String get location => _location;

  final List<String> availableSkills = const [
    'Flutter',
    'Dart',
    'Stacked Architecture',
    'REST APIs',
    'UI/UX Design',
    'State Management',
    'Firebase',
    'CI/CD',
    'Golden Testing',
  ];

  Set<String> _selectedSkills = {'Flutter', 'Dart', 'Stacked Architecture'};
  Set<String> get selectedSkills => _selectedSkills;

  Set<String> _selectedInterests = {};
  Set<String> get selectedInterests => _selectedInterests;

  // ---------------------------------------------------------------------------
  // SETTINGS TAB STATE
  // ---------------------------------------------------------------------------
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  bool _analyticsEnabled = true;
  bool get analyticsEnabled => _analyticsEnabled;

  void toggleDarkMode(bool value) {
    _darkMode = value;
    _preferencesService.setDarkMode(value);
    rebuildUi();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    _preferencesService.setNotificationsEnabled(value);
    rebuildUi();
  }

  void toggleAnalytics(bool value) {
    _analyticsEnabled = value;
    _preferencesService.setAnalyticsEnabled(value);
    rebuildUi();
  }

  // ---------------------------------------------------------------------------
  // EXPLORE TAB STATE
  // ---------------------------------------------------------------------------
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String _selectedCategoryFilter = 'All';
  String get selectedCategoryFilter => _selectedCategoryFilter;

  void setSearchQuery(String query) {
    _searchQuery = query;
    rebuildUi();
  }

  void setCategoryFilter(String filter) {
    _selectedCategoryFilter = filter;
    rebuildUi();
  }

  late List<Map<String, dynamic>> _exploreProjects;
  List<Map<String, dynamic>> get exploreProjects => _exploreProjects;

  void _initExploreProjects() {
    final liked = _preferencesService.likedProjects;
    _exploreProjects = [
      {
        'title': 'Ushie Digital Resume Builder',
        'category': 'Architecture',
        'description': 'Multi-step interactive digital resume built with Stacked architecture & Flutter.',
        'image': 'images/spacea.png',
        'likes': liked.contains('Ushie Digital Resume Builder') ? 143 : 142,
        'isLiked': liked.contains('Ushie Digital Resume Builder'),
        'tags': ['Flutter', 'Stacked', 'UI/UX'],
      },
      {
        'title': 'Quantum Portfolio Dashboard',
        'category': 'Mobile',
        'description': 'Real-time analytics dashboard with dynamic theme tokens and responsive layouts.',
        'image': 'images/spacec.png',
        'likes': liked.contains('Quantum Portfolio Dashboard') ? 99 : 98,
        'isLiked': liked.contains('Quantum Portfolio Dashboard'),
        'tags': ['Dart', 'REST APIs', 'Charts'],
      },
      {
        'title': 'Stitch Design System',
        'category': 'UI/UX',
        'description': 'AI-assisted design system with high-contrast color palettes and Google Sans typography.',
        'image': 'images/spaced.png',
        'likes': liked.contains('Stitch Design System') ? 211 : 210,
        'isLiked': liked.contains('Stitch Design System'),
        'tags': ['Google Sans', 'Design System', 'Stitch'],
      },
      {
        'title': 'Cloud CI/CD Pipeline Kit',
        'category': 'DevOps',
        'description': 'Automated golden snapshot generator and cross-platform build release pipeline.',
        'image': 'images/spacee.png',
        'likes': liked.contains('Cloud CI/CD Pipeline Kit') ? 77 : 76,
        'isLiked': liked.contains('Cloud CI/CD Pipeline Kit'),
        'tags': ['CI/CD', 'Golden Testing', 'DevOps'],
      },
    ];
  }

  List<Map<String, dynamic>> get filteredExploreProjects {
    return _exploreProjects.where((project) {
      final matchesCategory = _selectedCategoryFilter == 'All' ||
          project['category'] == _selectedCategoryFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          (project['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (project['description'] as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void toggleProjectLike(String title) {
    final index = _exploreProjects.indexWhere((p) => p['title'] == title);
    if (index != -1) {
      final project = Map<String, dynamic>.from(_exploreProjects[index]);
      final bool wasLiked = project['isLiked'] == true;
      project['isLiked'] = !wasLiked;
      project['likes'] = (project['likes'] as int) + (wasLiked ? -1 : 1);
      _exploreProjects[index] = project;

      final liked = _preferencesService.likedProjects.toList();
      if (project['isLiked']) {
        if (!liked.contains(title)) liked.add(title);
      } else {
        liked.remove(title);
      }
      _preferencesService.setLikedProjects(liked);
      rebuildUi();
    }
  }

  // ---------------------------------------------------------------------------
  // INTERACTIVE ACTION HELPERS
  // ---------------------------------------------------------------------------
  void sharePortfolio(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: 'https://ushie-digital-resume.vercel.app'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Portfolio link copied to clipboard!'),
          ],
        ),
        backgroundColor: const Color(0xFF254EDB),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showContactModal(BuildContext context) {
    final isDark = _darkMode;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: isDark ? Colors.white70 : Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Connect directly for consulting, executive architecture, or full-time roles.',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white60 : Colors.grey[600],
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF254EDB).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.email_outlined, color: Color(0xFF254EDB)),
                ),
                title: Text(
                  'Email Inquiry',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Google Sans',
                  ),
                ),
                subtitle: const Text('ushie.code@gmail.com'),
                trailing: const Icon(Icons.copy, size: 18),
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: 'ushie.code@gmail.com'));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Email copied to clipboard!')),
                  );
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.code, color: Colors.purple),
                ),
                title: Text(
                  'GitHub Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Google Sans',
                  ),
                ),
                subtitle: const Text('github.com/Ushie-E'),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: 'https://github.com/Ushie-E'));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('GitHub link copied!')),
                  );
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.link, color: Colors.blue),
                ),
                title: Text(
                  'Live Portfolio Domain',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Google Sans',
                  ),
                ),
                subtitle: const Text('ushie-digital-resume.vercel.app'),
                trailing: const Icon(Icons.open_in_new, size: 18),
                onTap: () {
                  sharePortfolio(context);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // SETTERS & METHODS
  // ---------------------------------------------------------------------------
  void setAvatar(String avatarPath) {
    _selectedAvatar = avatarPath;
    _preferencesService.setSelectedAvatar(avatarPath);
    rebuildUi();
  }

  void cycleAvatar() {
    final currentIndex = availableAvatars.indexOf(_selectedAvatar);
    final nextIndex = (currentIndex + 1) % availableAvatars.length;
    _selectedAvatar = availableAvatars[nextIndex];
    _preferencesService.setSelectedAvatar(_selectedAvatar);
    rebuildUi();
  }

  void setPlan(String plan) {
    _selectedPlan = plan;
    _preferencesService.setSelectedPlan(plan);
    rebuildUi();
  }

  void setFullName(String value) {
    _fullName = value;
    _preferencesService.setFullName(value);
    rebuildUi();
  }

  void setJobTitle(String value) {
    _jobTitle = value;
    _preferencesService.setJobTitle(value);
    rebuildUi();
  }

  void setBio(String value) {
    _bio = value;
    _preferencesService.setBio(value);
    rebuildUi();
  }

  void setLocation(String value) {
    _location = value;
    _preferencesService.setLocation(value);
    rebuildUi();
  }

  void toggleSkill(String skill) {
    if (_selectedSkills.contains(skill)) {
      _selectedSkills.remove(skill);
    } else {
      _selectedSkills.add(skill);
    }
    _preferencesService.setSkills(_selectedSkills.toList());
    rebuildUi();
  }

  void addCustomSkill(String skill) {
    final trimmed = skill.trim();
    if (trimmed.isNotEmpty) {
      _selectedSkills.add(trimmed);
      _preferencesService.setSkills(_selectedSkills.toList());
      rebuildUi();
    }
  }

  void toggleInterest(String interest) {
    if (_selectedInterests.contains(interest)) {
      _selectedInterests.remove(interest);
    } else {
      _selectedInterests.add(interest);
    }
    _preferencesService.setInterests(_selectedInterests.toList());
    rebuildUi();
  }

  bool get isStep2Valid => _fullName.trim().isNotEmpty && _jobTitle.trim().isNotEmpty;
  bool get isStep3Valid => _selectedSkills.length >= 2;
  bool get isInterestGridValid => _selectedInterests.length >= 3;

  void nextStep() {
    if (_currentStep == 1) {
      _currentStep = 2;
      rebuildUi();
    } else if (_currentStep == 2) {
      if (isStep2Valid) {
        _currentStep = 3;
        rebuildUi();
      }
    } else if (_currentStep == 3) {
      if (isStep3Valid) {
        _currentStep = 4;
        rebuildUi();
      }
    } else if (_currentStep == 4) {
      if (isInterestGridValid) {
        _currentStep = 5;
        rebuildUi();
      }
    } else if (_currentStep == 5) {
      completeOnboarding();
    }
  }

  void prevStep() {
    if (_currentStep > 1) {
      _currentStep--;
      rebuildUi();
    }
  }

  void goToStep(int step) {
    if (step >= 1 && step <= 5) {
      _currentStep = step;
      _isOnboardingComplete = false;
      _selectedTabIndex = 1;
      rebuildUi();
    }
  }

  void completeOnboarding() {
    _isOnboardingComplete = true;
    _selectedTabIndex = 1;
    _preferencesService.saveProfile(
      plan: _selectedPlan,
      avatar: _selectedAvatar,
      name: _fullName,
      title: _jobTitle,
      bio: _bio,
      location: _location,
      skills: _selectedSkills.toList(),
      interests: _selectedInterests.toList(),
    );
    rebuildUi();
    showSuccessDialog();
  }

  void completeOnboardingWithData(OnboardingViewModel onboardingVm) {
    _selectedPlan = onboardingVm.selectedPlan;
    _selectedAvatar = onboardingVm.selectedAvatar;

    if (onboardingVm.isBusinessPlan) {
      _fullName = onboardingVm.displayCompanyName;
      _jobTitle = onboardingVm.displayCompanySector;
      _bio = onboardingVm.companyOverview.isNotEmpty
          ? onboardingVm.companyOverview
          : 'Delivering enterprise cross-platform mobile products, cloud architectures, and digital design systems for global clients.';
      _location = onboardingVm.companyLocation.isNotEmpty
          ? onboardingVm.companyLocation
          : 'Lagos, Nigeria & Remote';
      _selectedSkills = Set.from(onboardingVm.selectedBusinessCapabilities);
      _selectedInterests = Set.from(onboardingVm.selectedTargetMarkets.isNotEmpty
          ? onboardingVm.selectedTargetMarkets
          : {'Enterprise Tech', 'Architecture & Real Estate', 'FinTech'});
    } else {
      _fullName = onboardingVm.displayName;
      _jobTitle = onboardingVm.displayJobTitle;
      _bio = onboardingVm.bio.isNotEmpty
          ? onboardingVm.bio
          : 'Crafting high-performance cross-platform applications with Flutter & Stacked.';
      _location = onboardingVm.location.isNotEmpty ? onboardingVm.location : 'Lagos, Nigeria';
      _selectedSkills = Set.from(onboardingVm.selectedPersonalSkills);
      _selectedInterests = Set.from(onboardingVm.selectedPersonalInterests);
    }

    _isOnboardingComplete = true;
    _selectedTabIndex = 1;
    _preferencesService.saveProfile(
      plan: _selectedPlan,
      avatar: _selectedAvatar,
      name: _fullName,
      title: _jobTitle,
      bio: _bio,
      location: _location,
      skills: _selectedSkills.toList(),
      interests: _selectedInterests.toList(),
    );
    rebuildUi();
    showSuccessDialog();
  }

  void restartOnboarding() {
    _currentStep = 1;
    _isOnboardingComplete = false;
    _selectedTabIndex = 1;
    _preferencesService.setOnboardingComplete(false);
    rebuildUi();
  }

  void showSuccessDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: _selectedPlan == 'Business' ? 'Company Profile Configured!' : 'Profile Created!',
      description:
          'Congratulations $_fullName! Your profile as $_jobTitle has been created successfully for $_selectedPlan use with ${selectedSkills.length} items.',
    );
  }
}
