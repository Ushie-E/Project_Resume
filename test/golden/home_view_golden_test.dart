import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:project/app/app.locator.dart';
import 'package:project/ui/views/home/home_view.dart';

void main() {
  setUpAll(() => setupLocator());
  tearDownAll(() => locator.reset());

  testGoldens('HomeView - Step 1 Plan Selection', (tester) async {
    await loadAppFonts();

    // Set device pixel ratio and size
    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeView()),
      ),
    );

    await screenMatchesGolden(tester, 'home_view_step1');
  });

  testGoldens('HomeView - Step 4 Interest Selection', (tester) async {
    await loadAppFonts();

    // Set device pixel ratio and size
    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.binding.window.devicePixelRatioTestValue = 1.0;

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeView()),
      ),
    );

    // Scroll the 'Get Started' button into view so it is hit-testable
    final getStartedFinder = find.text('Get Started');
    await tester.ensureVisible(getStartedFinder);
    await tester.pumpAndSettle();

    // Tap the 'Get Started' button to go to Step 4
    await tester.tap(getStartedFinder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'home_view_step4');
  });
}

