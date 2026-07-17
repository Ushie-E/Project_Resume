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
      test('When nextStep is called on step 1, currentStep should change to 4', () {
        final model = getModel();
        model.nextStep();
        expect(model.currentStep, 4);
      });

      test('When prevStep is called on step 4, currentStep should change to 1', () {
        final model = getModel();
        model.nextStep(); // Goes to 4
        expect(model.currentStep, 4);

        model.prevStep(); // Goes to 1
        expect(model.currentStep, 1);
      });

      test('When nextStep is called on step 4 with valid interests, should trigger dialog service', () {
        final dialogService = getAndRegisterDialogService();
        final model = getModel();

        model.nextStep(); // Go to step 4
        model.toggleInterest('Design');
        model.toggleInterest('Technology');
        model.toggleInterest('Music');

        model.nextStep(); // Tries to submit

        verify(dialogService.showCustomDialog(
          variant: DialogType.infoAlert,
          title: 'Profile Created!',
          description: anyNamed('description'),
        ));
      });
    });
  });
}

