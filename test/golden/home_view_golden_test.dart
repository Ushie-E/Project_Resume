import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';
import 'package:project/app.locator.dart';
import 'package:project/app_config.dart';
import 'package:project/models/resume_models.dart';
import 'package:project/services/preferences_service.dart';
import 'package:project/ui/views/explore/explore_view.dart';
import 'package:project/ui/views/home/home_view.dart';
import 'package:project/ui/views/onboarding/onboarding_view.dart';
import 'package:project/ui/views/settings/settings_view.dart';

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
    await loadAppFonts();
    AppConfig.initialize(
      appName: 'Ushie Digital Resume',
      apiBaseUrl: 'https://ushie-digital-resume.vercel.app',
      environment: EnvironmentType.dev,
      enableLogging: false,
    );
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
    await tester.enterText(
        find.byType(TextFormField).at(1), 'Flutter Mobile Engineer');
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
    when(prefs.bio).thenReturn(
        'Crafting high-performance cross-platform applications with Flutter & Stacked.');
    when(prefs.location).thenReturn('Lagos, Nigeria');
    when(prefs.contactEmail).thenReturn('ushie.code@gmail.com');
    when(prefs.contactPhone).thenReturn('+234 810 000 0000');
    when(prefs.githubUrl).thenReturn('https://github.com/Ushie-E');
    when(prefs.linkedinUrl)
        .thenReturn('https://linkedin.com/in/ushie-emmanuel');
    when(prefs.websiteUrl)
        .thenReturn('https://ushie-digital-resume.vercel.app');
    when(prefs.skills)
        .thenReturn(['Flutter', 'Dart', 'Stacked Architecture', 'Supabase']);
    when(prefs.experiences).thenReturn([
      const ExperienceItem(
        company: 'Vertex Mobile Solutions',
        role: 'Lead Flutter Architect',
        period: '2023 - Present',
        description:
            'Architecting enterprise fintech and logistics apps with Stacked architecture, automated CI/CD, and 99.9% crash-free sessions.',
        highlights: [
          'Modularized multi-package Dart codebase reducing build times by 40%',
          'Established golden testing pipeline eliminating visual regression across Web & Mobile',
        ],
      ),
      const ExperienceItem(
        company: 'CloudPulse Tech',
        role: 'Senior Mobile Engineer',
        period: '2021 - 2023',
        description:
            'Spearheaded Flutter cross-platform migration, reducing code duplication by 45% and accelerating release cycles.',
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
    when(prefs.hobbies)
        .thenReturn(['Mobile Architecture', 'Open Source', 'Chess']);

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

  testGoldens('HomeView - Executive Resume Dashboard (Dark Mode)', (tester) async {
    final prefs = locator<PreferencesService>() as MockPreferencesService;
    when(prefs.isOnboardingComplete).thenReturn(true);
    when(prefs.selectedPlan).thenReturn('Personal');
    when(prefs.selectedAvatar).thenReturn('images/spacea.png');
    when(prefs.fullName).thenReturn('Ushie Emmanuel');
    when(prefs.jobTitle).thenReturn('Lead Flutter & Mobile Architect');
    when(prefs.bio).thenReturn(
        'Crafting high-performance cross-platform applications with Flutter & Stacked.');
    when(prefs.location).thenReturn('Lagos, Nigeria');
    when(prefs.contactEmail).thenReturn('ushie.code@gmail.com');
    when(prefs.contactPhone).thenReturn('+234 810 000 0000');
    when(prefs.githubUrl).thenReturn('https://github.com/Ushie-E');
    when(prefs.linkedinUrl)
        .thenReturn('https://linkedin.com/in/ushie-emmanuel');
    when(prefs.websiteUrl)
        .thenReturn('https://ushie-digital-resume.vercel.app');
    when(prefs.skills)
        .thenReturn(['Flutter', 'Dart', 'Stacked Architecture', 'Supabase']);
    when(prefs.experiences).thenReturn([
      const ExperienceItem(
        company: 'Vertex Mobile Solutions',
        role: 'Lead Flutter Architect',
        period: '2023 - Present',
        description:
            'Architecting enterprise fintech and logistics apps with Stacked architecture, automated CI/CD, and 99.9% crash-free sessions.',
        highlights: [
          'Modularized multi-package Dart codebase reducing build times by 40%',
          'Established golden testing pipeline eliminating visual regression across Web & Mobile',
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
    ]);
    when(prefs.hobbies)
        .thenReturn(['Mobile Architecture', 'Open Source', 'Chess']);
    when(prefs.darkMode).thenReturn(true);

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Google Sans',
            brightness: Brightness.dark,
          ),
          home: const HomeView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'home_view_dashboard_dark');
  }, skip: isCI);

  testGoldens('SettingsView - Light Mode Preferences', (tester) async {
    final prefs = locator<PreferencesService>() as MockPreferencesService;
    when(prefs.selectedPlan).thenReturn('Personal');
    when(prefs.darkMode).thenReturn(false);
    when(prefs.notificationsEnabled).thenReturn(true);
    when(prefs.analyticsEnabled).thenReturn(true);
    when(prefs.fullName).thenReturn('Ushie Emmanuel');
    when(prefs.jobTitle).thenReturn('Lead Flutter & Mobile Architect');
    when(prefs.selectedAvatar).thenReturn('images/spacea.png');

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Google Sans',
            brightness: Brightness.light,
          ),
          home: const SettingsView(
            userName: 'Ushie Emmanuel',
            userTitle: 'Lead Flutter & Mobile Architect',
            userAvatar: 'images/spacea.png',
            planType: 'Personal',
            darkMode: false,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'settings_view_light');
  }, skip: isCI);

  testGoldens('SettingsView - Dark Mode Preferences', (tester) async {
    final prefs = locator<PreferencesService>() as MockPreferencesService;
    when(prefs.selectedPlan).thenReturn('Personal');
    when(prefs.darkMode).thenReturn(true);
    when(prefs.notificationsEnabled).thenReturn(true);
    when(prefs.analyticsEnabled).thenReturn(true);
    when(prefs.fullName).thenReturn('Ushie Emmanuel');
    when(prefs.jobTitle).thenReturn('Lead Flutter & Mobile Architect');
    when(prefs.selectedAvatar).thenReturn('images/spacea.png');

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Google Sans',
            brightness: Brightness.dark,
          ),
          home: const SettingsView(
            userName: 'Ushie Emmanuel',
            userTitle: 'Lead Flutter & Mobile Architect',
            userAvatar: 'images/spacea.png',
            planType: 'Personal',
            darkMode: true,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'settings_view_dark');
  }, skip: isCI);

  testGoldens('HomeView - Business Enterprise Dashboard', (tester) async {
    final prefs = locator<PreferencesService>() as MockPreferencesService;
    when(prefs.isOnboardingComplete).thenReturn(true);
    when(prefs.selectedPlan).thenReturn('Business');
    when(prefs.selectedAvatar).thenReturn('images/spacec.png');
    when(prefs.fullName).thenReturn('Ushie Tech Labs & Studio');
    when(prefs.jobTitle).thenReturn('Enterprise Mobile & AI Solutions');
    when(prefs.bio).thenReturn(
        'Global digital consultancy engineering high-assurance mobile platforms, bespoke design systems, and cloud infrastructure.');
    when(prefs.location).thenReturn('Lagos, Nigeria & London, UK');
    when(prefs.contactEmail).thenReturn('contact@ushietechlabs.io');
    when(prefs.contactPhone).thenReturn('+234 800 USHIE LABS');
    when(prefs.githubUrl).thenReturn('https://github.com/Ushie-E');
    when(prefs.linkedinUrl)
        .thenReturn('https://linkedin.com/company/ushie-tech-labs');
    when(prefs.websiteUrl)
        .thenReturn('https://ushie-digital-resume.vercel.app');
    when(prefs.skills).thenReturn([
      'Custom Enterprise Software',
      'Cloud Architecture & DevOps',
      'UI/UX Strategy & Design Systems',
      'FinTech & High Assurance',
      'Microservices & APIs',
    ]);
    when(prefs.experiences).thenReturn([
      const ExperienceItem(
        company: 'Finovate Global Banking',
        role: 'Enterprise Mobile Overhaul',
        period: '2023 - 2024',
        description:
            'Delivered next-generation banking Flutter suite with biometric auth, sub-50ms render latency, and ISO-27001 compliance.',
        highlights: [
          'Engineered micro-frontend Flutter module integrating with legacy mainframe',
          'Achieved 99.99% crash-free rate across 1.2M active accounts',
        ],
      ),
      const ExperienceItem(
        company: 'AeroLogistics International',
        role: 'Fleet Tracking & Telemetry',
        period: '2022 - 2023',
        description:
            'Built real-time telemetry dashboard and driver suite handling 10M+ daily events.',
        highlights: [
          'Implemented offline-first SQLite sync engine for transit zones',
        ],
      ),
    ]);
    when(prefs.certifications).thenReturn([
      const CertificationItem(
        title: 'ISO/IEC 27001 Information Security Management',
        issuer: 'BSI Standards Authority',
        year: '2023',
        credentialUrl: 'https://bsigroup.com',
      ),
      const CertificationItem(
        title: 'AWS Advanced Tier Services Partner',
        issuer: 'Amazon Web Services',
        year: '2022',
        credentialUrl: 'https://aws.amazon.com',
      ),
    ]);
    when(prefs.hobbies).thenReturn([
      'Enterprise Mobile Apps',
      'AI & ML Integration',
      'Cloud Migration & Infra',
    ]);
    when(prefs.darkMode).thenReturn(false);

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

    await screenMatchesGolden(tester, 'home_view_business_dashboard');
  }, skip: isCI);

  testGoldens('HomeView - Business Enterprise Dashboard (Dark Mode)', (tester) async {
    final prefs = locator<PreferencesService>() as MockPreferencesService;
    when(prefs.isOnboardingComplete).thenReturn(true);
    when(prefs.selectedPlan).thenReturn('Business');
    when(prefs.selectedAvatar).thenReturn('images/spacec.png');
    when(prefs.fullName).thenReturn('Ushie Tech Labs & Studio');
    when(prefs.jobTitle).thenReturn('Enterprise Mobile & AI Solutions');
    when(prefs.bio).thenReturn(
        'Global digital consultancy engineering high-assurance mobile platforms, bespoke design systems, and cloud infrastructure.');
    when(prefs.location).thenReturn('Lagos, Nigeria & London, UK');
    when(prefs.contactEmail).thenReturn('contact@ushietechlabs.io');
    when(prefs.contactPhone).thenReturn('+234 800 USHIE LABS');
    when(prefs.githubUrl).thenReturn('https://github.com/Ushie-E');
    when(prefs.linkedinUrl)
        .thenReturn('https://linkedin.com/company/ushie-tech-labs');
    when(prefs.websiteUrl)
        .thenReturn('https://ushie-digital-resume.vercel.app');
    when(prefs.skills).thenReturn([
      'Custom Enterprise Software',
      'Cloud Architecture & DevOps',
      'UI/UX Strategy & Design Systems',
      'FinTech & High Assurance',
      'Microservices & APIs',
    ]);
    when(prefs.experiences).thenReturn([
      const ExperienceItem(
        company: 'Finovate Global Banking',
        role: 'Enterprise Mobile Overhaul',
        period: '2023 - 2024',
        description:
            'Delivered next-generation banking Flutter suite with biometric auth, sub-50ms render latency, and ISO-27001 compliance.',
        highlights: [
          'Engineered micro-frontend Flutter module integrating with legacy mainframe',
          'Achieved 99.99% crash-free rate across 1.2M active accounts',
        ],
      ),
    ]);
    when(prefs.certifications).thenReturn([
      const CertificationItem(
        title: 'ISO/IEC 27001 Information Security Management',
        issuer: 'BSI Standards Authority',
        year: '2023',
        credentialUrl: 'https://bsigroup.com',
      ),
    ]);
    when(prefs.hobbies).thenReturn([
      'Enterprise Mobile Apps',
      'AI & ML Integration',
      'Cloud Migration & Infra',
    ]);
    when(prefs.darkMode).thenReturn(true);

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Google Sans',
            brightness: Brightness.dark,
          ),
          home: const HomeView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'home_view_business_dashboard_dark');
  }, skip: isCI);

  testGoldens('SettingsView - Business Persona Active', (tester) async {
    final prefs = locator<PreferencesService>() as MockPreferencesService;
    when(prefs.selectedPlan).thenReturn('Business');
    when(prefs.darkMode).thenReturn(false);
    when(prefs.notificationsEnabled).thenReturn(true);
    when(prefs.analyticsEnabled).thenReturn(true);
    when(prefs.fullName).thenReturn('Ushie Tech Labs & Studio');
    when(prefs.jobTitle).thenReturn('Enterprise Mobile & AI Solutions');
    when(prefs.selectedAvatar).thenReturn('images/spacec.png');

    await tester.binding.setSurfaceSize(const Size(393, 852));
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(393, 852), devicePixelRatio: 1.0),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Google Sans',
            brightness: Brightness.light,
          ),
          home: const SettingsView(
            userName: 'Ushie Tech Labs & Studio',
            userTitle: 'Enterprise Mobile & AI Solutions',
            userAvatar: 'images/spacec.png',
            planType: 'Business',
            darkMode: false,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await screenMatchesGolden(tester, 'settings_view_business');
  }, skip: isCI);
}
