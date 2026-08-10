import 'package:project/app/app.locator.dart';
import 'package:project/app/app.dialogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  int _currentStep = 1;
  int get currentStep => _currentStep;

  String _selectedPlan = 'Personal';
  String get selectedPlan => _selectedPlan;
  bool get isBusinessPlan => _selectedPlan == 'Business';

  // Available Avatars: Empty demo profile first, followed by spatial avatars
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

  // ---------------------------------------------------------------------------
  // PERSONAL PLAN FIELDS (START BLANK FOR USER INPUT)
  // ---------------------------------------------------------------------------
  String _fullName = '';
  String get fullName => _fullName;
  String get displayName => _fullName.trim().isEmpty ? 'Your Name' : _fullName;

  String _jobTitle = '';
  String get jobTitle => _jobTitle;
  String get displayJobTitle => _jobTitle.trim().isEmpty ? 'Your Title' : _jobTitle;

  String _bio = '';
  String get bio => _bio;

  String _location = '';
  String get location => _location;

  final List<String> availablePersonalSkills = const [
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

  final Set<String> _selectedPersonalSkills = {'Flutter', 'Dart', 'Stacked Architecture'};
  Set<String> get selectedPersonalSkills => _selectedPersonalSkills;

  final Set<String> _selectedPersonalInterests = {};
  Set<String> get selectedPersonalInterests => _selectedPersonalInterests;

  // ---------------------------------------------------------------------------
  // BUSINESS PLAN FIELDS (START BLANK FOR USER INPUT)
  // ---------------------------------------------------------------------------
  String _companyName = '';
  String get companyName => _companyName;
  String get displayCompanyName => _companyName.trim().isEmpty ? 'Your Firm / Agency' : _companyName;

  String _companySector = '';
  String get companySector => _companySector;
  String get displayCompanySector => _companySector.trim().isEmpty ? 'Software & Design Solutions' : _companySector;

  String _teamSize = '';
  String get teamSize => _teamSize;

  String _companyLocation = '';
  String get companyLocation => _companyLocation;

  String _companyOverview = '';
  String get companyOverview => _companyOverview;

  final List<String> availableBusinessCapabilities = const [
    'Custom Software Dev',
    'Enterprise Security',
    'Cloud Architecture',
    'Microservices',
    'UI/UX Strategy',
    'SLA Support 24/7',
    'Agile Augmentation',
  ];

  final Set<String> _selectedBusinessCapabilities = {
    'Custom Software Dev',
    'Cloud Architecture',
    'UI/UX Strategy'
  };
  Set<String> get selectedBusinessCapabilities => _selectedBusinessCapabilities;

  final Set<String> _selectedTargetMarkets = {};
  Set<String> get selectedTargetMarkets => _selectedTargetMarkets;

  // ---------------------------------------------------------------------------
  // METHODS & SETTERS
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

  // Personal Setters
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

  void togglePersonalSkill(String skill) {
    if (_selectedPersonalSkills.contains(skill)) {
      _selectedPersonalSkills.remove(skill);
    } else {
      _selectedPersonalSkills.add(skill);
    }
    rebuildUi();
  }

  void togglePersonalInterest(String interest) {
    if (_selectedPersonalInterests.contains(interest)) {
      _selectedPersonalInterests.remove(interest);
    } else {
      _selectedPersonalInterests.add(interest);
    }
    rebuildUi();
  }

  // Business Setters
  void setCompanyName(String value) {
    _companyName = value;
    rebuildUi();
  }

  void setCompanySector(String value) {
    _companySector = value;
    rebuildUi();
  }

  void setTeamSize(String value) {
    _teamSize = value;
    rebuildUi();
  }

  void setCompanyLocation(String value) {
    _companyLocation = value;
    rebuildUi();
  }

  void setCompanyOverview(String value) {
    _companyOverview = value;
    rebuildUi();
  }

  void toggleBusinessCapability(String capability) {
    if (_selectedBusinessCapabilities.contains(capability)) {
      _selectedBusinessCapabilities.remove(capability);
    } else {
      _selectedBusinessCapabilities.add(capability);
    }
    rebuildUi();
  }

  void toggleTargetMarket(String market) {
    if (_selectedTargetMarkets.contains(market)) {
      _selectedTargetMarkets.remove(market);
    } else {
      _selectedTargetMarkets.add(market);
    }
    rebuildUi();
  }

  // ---------------------------------------------------------------------------
  // ACCOUNT LOGIN METHODS
  // ---------------------------------------------------------------------------
  void loginAsPersonalAccount(Function() onComplete) {
    _selectedPlan = 'Personal';
    _fullName = 'Ushie Emmanuel';
    _jobTitle = 'Flutter Mobile Engineer';
    _bio = 'Crafting high-performance cross-platform applications with Flutter & Stacked.';
    _location = 'Lagos, Nigeria';
    _selectedAvatar = 'images/spacea.png';
    onComplete();
  }

  void loginAsBusinessAccount(Function() onComplete) {
    _selectedPlan = 'Business';
    _companyName = 'Ushie Tech Labs & Architecture';
    _companySector = 'Software Development & AI Solutions';
    _teamSize = '11-50 Employees';
    _companyLocation = 'Lagos, Nigeria & Remote';
    _companyOverview =
        'Delivering enterprise cross-platform mobile products, cloud architectures, and digital design systems for global clients.';
    _selectedAvatar = 'images/spacec.png';
    onComplete();
  }

  // Validation
  bool get isStep2Valid {
    if (isBusinessPlan) {
      return _companyName.trim().isNotEmpty && _companySector.trim().isNotEmpty;
    }
    return _fullName.trim().isNotEmpty && _jobTitle.trim().isNotEmpty;
  }

  bool get isStep3Valid {
    if (isBusinessPlan) {
      return _selectedBusinessCapabilities.length >= 2;
    }
    return _selectedPersonalSkills.length >= 2;
  }

  bool get isStep4Valid {
    if (isBusinessPlan) {
      return _selectedTargetMarkets.length >= 3;
    }
    return _selectedPersonalInterests.length >= 3;
  }

  void nextStep(Function() onComplete) {
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
      if (isStep4Valid) {
        _currentStep = 5;
        rebuildUi();
      }
    } else if (_currentStep == 5) {
      showSuccessDialog();
      onComplete();
    }
  }

  void prevStep() {
    if (_currentStep > 1) {
      _currentStep--;
      rebuildUi();
    }
  }

  void showSuccessDialog() {
    final String title = isBusinessPlan ? 'Company Profile Configured!' : 'Profile Created!';
    final String name = isBusinessPlan ? displayName : displayName;
    final String desc = isBusinessPlan
        ? 'Congratulations! $name has been onboarded successfully for $_selectedPlan use with ${selectedBusinessCapabilities.length} enterprise capabilities.'
        : 'Congratulations $name! Your profile as $displayJobTitle has been created successfully for $_selectedPlan use.';

    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: title,
      description: desc,
    );
  }
}
