import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:project/app/app.locator.dart';
import 'package:project/ui/views/explore/explore_view.dart';
import 'package:project/ui/views/home/home_view.dart';

void main() {
  setUpAll(() => setupLocator());
  tearDownAll(() => locator.reset());

  testGoldens('HomeView - Step 1 Plan Selection', (tester) async {
    await loadAppFonts();

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

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

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeView()),
      ),
    );

    // Step 1 -> Step 2
    final getStartedFinder = find.text('Get Started');
    await tester.ensureVisible(getStartedFinder);
    await tester.pumpAndSettle();
    await tester.tap(getStartedFinder);
    await tester.pumpAndSettle();

    // Fill Step 2 Form to satisfy validation
    await tester.enterText(find.byType(TextFormField).at(0), 'Ushie Emmanuel');
    await tester.enterText(find.byType(TextFormField).at(1), 'Flutter Mobile Engineer');
    await tester.pumpAndSettle();

    // Step 2 -> Step 3
    final step3Finder = find.text('Continue to Step 3');
    await tester.ensureVisible(step3Finder);
    await tester.pumpAndSettle();
    await tester.tap(step3Finder);
    await tester.pumpAndSettle();

    // Step 3 -> Step 4
    final step4Finder = find.text('Continue to Step 4');
    await tester.ensureVisible(step4Finder);
    await tester.pumpAndSettle();
    await tester.tap(step4Finder);
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'home_view_step4');
  });

  testGoldens('ExploreView - Project Showcase', (tester) async {
    await loadAppFonts();

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(debugShowCheckedModeBanner: false, home: ExploreView()),
      ),
    );

    await screenMatchesGolden(tester, 'explore_view_showcase');
  });
}
