import 'package:project/app/app.locator.dart';
import 'package:project/app/app.dialogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  int _currentStep = 1;
  int get currentStep => _currentStep;

  String _selectedPlan = 'Personal';
  String get selectedPlan => _selectedPlan;

  final Set<String> _selectedInterests = {};
  Set<String> get selectedInterests => _selectedInterests;

  void setPlan(String plan) {
    _selectedPlan = plan;
    rebuildUi();
  }

  void toggleInterest(String interest) {
    if (_selectedInterests.contains(interest)) {
      _selectedInterests.remove(interest);
    } else {
      _selectedInterests.add(interest);
    }
    rebuildUi();
  }

  bool get isInterestGridValid => _selectedInterests.length >= 3;

  void nextStep() {
    if (_currentStep == 1) {
      _currentStep = 4;
      rebuildUi();
    } else if (_currentStep == 4) {
      if (isInterestGridValid) {
        showSuccessDialog();
      }
    }
  }

  void prevStep() {
    if (_currentStep == 4) {
      _currentStep = 1;
      rebuildUi();
    }
  }

  void showSuccessDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: 'Profile Created!',
      description: 'Your Elysian profile has been configured successfully for $_selectedPlan use with ${selectedInterests.join(", ")} interests.',
    );
  }
}

