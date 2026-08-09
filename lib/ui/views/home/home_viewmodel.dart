import 'package:project/app/app.locator.dart';
import 'package:project/app/app.dialogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  int _currentStep = 1;
  int get currentStep => _currentStep;

  bool _isOnboardingComplete = false;
  bool get isOnboardingComplete => _isOnboardingComplete;

  String _selectedPlan = 'Personal';
  String get selectedPlan => _selectedPlan;

  final List<String> availableAvatars = const [
    'images/user.png',
    'images/ushie.png',
    'images/spacea.png',
    'images/spacec.png',
    'images/spaced.png',
  ];

  String _selectedAvatar = 'images/user.png';
  String get selectedAvatar => _selectedAvatar;

  // Step 2 Profile Fields
  String _fullName = 'Ushie Emmanuel';
  String get fullName => _fullName;

  String _jobTitle = 'Flutter Mobile Engineer';
  String get jobTitle => _jobTitle;

  String _bio = 'Crafting high-performance cross-platform applications with Flutter & Stacked.';
  String get bio => _bio;

  String _location = 'Lagos, Nigeria';
  String get location => _location;

  // Step 3 Skills Fields
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

  final Set<String> _selectedSkills = {'Flutter', 'Dart', 'Stacked Architecture'};
  Set<String> get selectedSkills => _selectedSkills;

  // Step 4 Interests
  final Set<String> _selectedInterests = {};
  Set<String> get selectedInterests => _selectedInterests;

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
      rebuildUi();
    }
  }

  void completeOnboarding() {
    _isOnboardingComplete = true;
    rebuildUi();
    showSuccessDialog();
  }

  void restartOnboarding() {
    _currentStep = 1;
    _isOnboardingComplete = false;
    rebuildUi();
  }

  void showSuccessDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Profile Created!',
      description:
          'Congratulations $_fullName! Your profile as $_jobTitle has been created successfully for $_selectedPlan use with ${selectedSkills.length} skills and ${selectedInterests.length} interests.',
    );
  }
}
