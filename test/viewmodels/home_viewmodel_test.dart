import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:project/app/app.dialogs.dart';
import 'package:project/app/app.locator.dart';
import 'package:project/ui/views/home/home_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('Initial states -', () {
      test('When initialized, should have default onboarding states', () {
        final model = getModel();
        expect(model.currentStep, 1);
        expect(model.selectedPlan, 'Personal');
        expect(model.selectedInterests, isEmpty);
        expect(model.isInterestGridValid, isFalse);
        expect(model.selectedTabIndex, 1);
      });
    });

    group('Avatar Selection -', () {
      test('When initialized, should have default empty profile avatar', () {
        final model = getModel();
        expect(model.selectedAvatar, 'images/empty_profile.png');
      });

      test('When setAvatar is called, should update selectedAvatar', () {
        final model = getModel();
        model.setAvatar('images/spacea.png');
        expect(model.selectedAvatar, 'images/spacea.png');
      });

      test('When cycleAvatar is called, should rotate to next avatar', () {
        final model = getModel();
        model.cycleAvatar();
        expect(model.selectedAvatar, 'images/spacea.png');
      });
    });

    group('Plan Selection -', () {
      test('When setPlan is called, should update selectedPlan', () {
        final model = getModel();
        model.setPlan('Business');
        expect(model.selectedPlan, 'Business');
      });
    });

    group('Interest Selection -', () {
      test('When toggleInterest is called, should add and remove interest', () {
        final model = getModel();
        model.toggleInterest('Design');
        expect(model.selectedInterests, contains('Design'));
        expect(model.isInterestGridValid, isFalse);

        model.toggleInterest('Design');
        expect(model.selectedInterests, isNot(contains('Design')));
      });

      test('When 3 or more interests are selected, isInterestGridValid is true', () {
        final model = getModel();
        model.toggleInterest('Design');
        model.toggleInterest('Technology');
        expect(model.isInterestGridValid, isFalse);

        model.toggleInterest('Music');
        expect(model.isInterestGridValid, isTrue);
      });
    });

    group('Navigation Steps -', () {
      test('Should navigate sequentially through all 5 onboarding steps', () {
        final dialogService = getAndRegisterDialogService();
        final model = getModel();

        // Step 1 -> Step 2
        expect(model.currentStep, 1);
        model.nextStep();
        expect(model.currentStep, 2);

        // Step 2 -> Step 3
        expect(model.isStep2Valid, isTrue);
        model.nextStep();
        expect(model.currentStep, 3);

        // Step 3 -> Step 4
        expect(model.isStep3Valid, isTrue);
        model.nextStep();
        expect(model.currentStep, 4);

        // Step 4 -> Step 5
        model.toggleInterest('Design');
        model.toggleInterest('Technology');
        model.toggleInterest('Music');
        expect(model.isInterestGridValid, isTrue);
        model.nextStep();
        expect(model.currentStep, 5);

        // Step 5 -> Complete (Dialog)
        model.nextStep();
        verify(dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: 'Profile Created!',
          description: anyNamed('description'),
        ));
        expect(model.isOnboardingComplete, isTrue);
      });

      test('When prevStep is called, currentStep should decrement', () {
        final model = getModel();
        model.nextStep(); // Goes to 2
        expect(model.currentStep, 2);

        model.prevStep(); // Goes back to 1
        expect(model.currentStep, 1);
      });
    });

    group('Tab Navigation & Settings -', () {
      test('When setSelectedTabIndex is called, should update selectedTabIndex', () {
        final model = getModel();
        model.setSelectedTabIndex(0); // Explore tab
        expect(model.selectedTabIndex, 0);

        model.setSelectedTabIndex(2); // Settings tab
        expect(model.selectedTabIndex, 2);
      });

      test('When settings toggles are called, should update respective boolean states', () {
        final model = getModel();
        model.toggleDarkMode(true);
        expect(model.darkMode, isTrue);

        model.toggleNotifications(false);
        expect(model.notificationsEnabled, isFalse);

        model.toggleAnalytics(false);
        expect(model.analyticsEnabled, isFalse);
      });

      test('When setSearchQuery & setCategoryFilter are called, filteredExploreProjects should update', () {
        final model = getModel();
        expect(model.filteredExploreProjects.length, 4);

        model.setCategoryFilter('Mobile');
        expect(model.filteredExploreProjects.length, 1);
        expect(model.filteredExploreProjects.first['title'], 'Quantum Portfolio Dashboard');

        model.setCategoryFilter('All');
        model.setSearchQuery('Stitch');
        expect(model.filteredExploreProjects.length, 1);
        expect(model.filteredExploreProjects.first['title'], 'Stitch Design System');
      });
    });
  });
}
