import 'package:project/app/app.locator.dart';
import 'package:project/app/app.dialogs.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  int _currentStep = 1;
  int get currentStep => _currentStep;

  bool _isOnboardingComplete = false;
  bool get isOnboardingComplete => _isOnboardingComplete;

  // Bottom Navigation Tab Index: 0 = Explore, 1 = My Profile, 2 = Settings
  int _selectedTabIndex = 1;
  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    rebuildUi();
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
    rebuildUi();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    rebuildUi();
  }

  void toggleAnalytics(bool value) {
    _analyticsEnabled = value;
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

  // Explore Project Data
  final List<Map<String, dynamic>> exploreProjects = const [
    {
      'title': 'Ushie Digital Resume Builder',
      'category': 'Architecture',
      'description': 'Multi-step interactive digital resume built with Stacked architecture & Flutter.',
      'image': 'images/spacea.png',
      'likes': 142,
      'tags': ['Flutter', 'Stacked', 'UI/UX'],
    },
    {
      'title': 'Quantum Portfolio Dashboard',
      'category': 'Mobile',
      'description': 'Real-time analytics dashboard with dynamic theme tokens and responsive layouts.',
      'image': 'images/spacec.png',
      'likes': 98,
      'tags': ['Dart', 'REST APIs', 'Charts'],
    },
    {
      'title': 'Stitch Design System',
      'category': 'UI/UX',
      'description': 'AI-assisted design system with high-contrast color palettes and Google Sans typography.',
      'image': 'images/spaced.png',
      'likes': 210,
      'tags': ['Google Sans', 'Design System', 'Stitch'],
    },
    {
      'title': 'Cloud CI/CD Pipeline Kit',
      'category': 'DevOps',
      'description': 'Automated golden snapshot generator and cross-platform build release pipeline.',
      'image': 'images/spacee.png',
      'likes': 76,
      'tags': ['CI/CD', 'Golden Testing', 'DevOps'],
    },
  ];

  List<Map<String, dynamic>> get filteredExploreProjects {
    return exploreProjects.where((project) {
      final matchesCategory = _selectedCategoryFilter == 'All' ||
          project['category'] == _selectedCategoryFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          (project['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (project['description'] as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  // ---------------------------------------------------------------------------
  // SETTERS & METHODS
  // ---------------------------------------------------------------------------
  void setAvatar(String avatarPath) {
    _selectedAvatar = avatarPath;
    rebuildUi();
  }

  void cycleAvatar() {
    final currentIndex = availableAvatars.indexOf(_selectedAvatar);
    final nextIndex = (currentIndex + 1) % availableAvatars.length;
    _selectedAvatar = availableAvatars[nextIndex];
    rebuildUi();
  }

  void setPlan(String plan) {
    _selectedPlan = plan;
    rebuildUi();
  }

  void setFullName(String value) {
    _fullName = value;
    rebuildUi();
  }

  void setJobTitle(String value) {
    _jobTitle = value;
    rebuildUi();
  }

  void setBio(String value) {
    _bio = value;
    rebuildUi();
  }

  void setLocation(String value) {
    _location = value;
    rebuildUi();
  }

  void toggleSkill(String skill) {
    if (_selectedSkills.contains(skill)) {
      _selectedSkills.remove(skill);
    } else {
      _selectedSkills.add(skill);
    }
    rebuildUi();
  }

  void addCustomSkill(String skill) {
    final trimmed = skill.trim();
    if (trimmed.isNotEmpty) {
      _selectedSkills.add(trimmed);
      rebuildUi();
    }
  }

  void toggleInterest(String interest) {
    if (_selectedInterests.contains(interest)) {
      _selectedInterests.remove(interest);
    } else {
      _selectedInterests.add(interest);
    }
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
    rebuildUi();
    showSuccessDialog();
  }

  void restartOnboarding() {
    _currentStep = 1;
    _isOnboardingComplete = false;
    _selectedTabIndex = 1;
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
