import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';
import 'package:project/app/app.locator.dart';
import 'package:project/app/app_config.dart';
import 'package:project/models/resume_models.dart';
import 'package:project/services/preferences_service.dart';
import 'package:project/ui/views/explore/explore_view.dart';
import 'package:project/ui/views/home/home_view.dart';
import 'package:project/ui/views/onboarding/onboarding_view.dart';

import '../helpers/test_helpers.dart';
import '../helpers/test_helpers.mocks.dart';

class TolerantFileComparator extends LocalFileComparator {
  final double maxDiffPercent;

  TolerantFileComparator(super.testFile, this.maxDiffPercent);

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await super.compare(imageBytes, golden);
    if (result) return true;

    final ComparisonResult comparison = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );

    return comparison.passed || comparison.diffPercent <= maxDiffPercent;
  }
}

void main() {
  final bool isCI = Platform.environment.containsKey('CI');

  setUp(() {
    registerServices();
  });

  tearDown(() {
    locator.reset();
  });

  setUpAll(() async {
    AppConfig.initialize(
      appName: 'Ushie Digital Resume (Test)',
      apiBaseUrl: 'http://localhost:8080',
      environment: EnvironmentType.dev,
    );
    await loadAppFonts();
    goldenFileComparator = TolerantFileComparator(
      Uri.parse('test/golden/home_view_golden_test.dart'),
      0.05,
    );
  });

  testGoldens('OnboardingView - Step 1 Plan Selection', (tester) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Google Sans'),
          home: const OnboardingView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'home_view_step1');
  }, skip: isCI);

  testGoldens('OnboardingView - Step 4 Interest Selection', (tester) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Google Sans'),
          home: const OnboardingView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

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
  }, skip: isCI);

  testGoldens('ExploreView - Project Showcase', (tester) async {
    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Google Sans'),
          home: const ExploreView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'explore_view_showcase');
  }, skip: isCI);

  testGoldens('HomeView - Executive Resume Dashboard', (tester) async {
    final prefs = locator<PreferencesService>() as MockPreferencesService;
    when(prefs.isOnboardingComplete).thenReturn(true);
    when(prefs.selectedPlan).thenReturn('Personal');
    when(prefs.selectedAvatar).thenReturn('images/spacea.png');
    when(prefs.fullName).thenReturn('Ushie Emmanuel');
    when(prefs.jobTitle).thenReturn('Lead Flutter & Mobile Architect');
    when(prefs.bio).thenReturn('Crafting high-performance cross-platform applications with Flutter & Stacked.');
    when(prefs.location).thenReturn('Lagos, Nigeria');
    when(prefs.contactEmail).thenReturn('ushie.code@gmail.com');
    when(prefs.contactPhone).thenReturn('+234 810 000 0000');
    when(prefs.githubUrl).thenReturn('https://github.com/Ushie-E');
    when(prefs.linkedinUrl).thenReturn('https://linkedin.com/in/ushie-emmanuel');
    when(prefs.websiteUrl).thenReturn('https://ushie-digital-resume.vercel.app');
    when(prefs.skills).thenReturn(['Flutter', 'Dart', 'Stacked Architecture', 'Supabase']);
    when(prefs.experiences).thenReturn([
      const ExperienceItem(
        company: 'Vertex Mobile Solutions',
        role: 'Lead Flutter Architect',
        period: '2023 - Present',
        description: 'Architecting enterprise fintech and logistics apps with Stacked architecture, automated CI/CD, and 99.9% crash-free sessions.',
        highlights: [
          'Modularized multi-package Dart codebase reducing build times by 40%',
          'Established golden testing pipeline eliminating visual regression across Web & Mobile',
        ],
      ),
      const ExperienceItem(
        company: 'CloudPulse Tech',
        role: 'Senior Mobile Engineer',
        period: '2021 - 2023',
        description: 'Spearheaded Flutter cross-platform migration, reducing code duplication by 45% and accelerating release cycles.',
        highlights: [
          'Implemented cached network repositories reducing network data usage by 35%',
        ],
      ),
    ]);
    when(prefs.certifications).thenReturn([
      const CertificationItem(
        title: 'Google Certified Associate Cloud Engineer',
        issuer: 'Google Cloud',
        year: '2023',
        credentialUrl: 'https://cloud.google.com/certification',
      ),
      const CertificationItem(
        title: 'Meta Certified Senior Flutter Specialist',
        issuer: 'Meta / Coursera',
        year: '2022',
        credentialUrl: 'https://coursera.org',
      ),
    ]);
    when(prefs.hobbies).thenReturn(['Mobile Architecture', 'Open Source', 'Chess']);

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'Google Sans'),
          home: const HomeView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'home_view_dashboard');
  }, skip: isCI);
}
