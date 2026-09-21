import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:project/models/resume_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _keyIsOnboardingComplete = 'is_onboarding_complete';
  static const String _keySelectedPlan = 'selected_plan';
  static const String _keySelectedAvatar = 'selected_avatar';
  static const String _keyFullName = 'full_name';
  static const String _keyJobTitle = 'job_title';
  static const String _keyBio = 'bio';
  static const String _keyLocation = 'location';
  static const String _keySkills = 'selected_skills';
  static const String _keyInterests = 'selected_interests';
  static const String _keyContactEmail = 'contact_email';
  static const String _keyContactPhone = 'contact_phone';
  static const String _keyGithubUrl = 'github_url';
  static const String _keyLinkedinUrl = 'linkedin_url';
  static const String _keyWebsiteUrl = 'website_url';
  static const String _keyExperiences = 'experiences_json';
  static const String _keyCertifications = 'certifications_json';
  static const String _keyHobbies = 'hobbies_list';
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyNotifications = 'notifications_enabled';
  static const String _keyAnalytics = 'analytics_enabled';
  static const String _keyLikedProjects = 'liked_project_titles';

  final ValueNotifier<bool> darkModeListenable = ValueNotifier<bool>(false);
  SharedPreferences? _prefs;

  Future<void> init() async {
    try {
      _prefs ??= await SharedPreferences.getInstance();
      darkModeListenable.value = darkMode;
    } catch (e) {
      if (kDebugMode) {
        print('PreferencesService init error: $e');
      }
    }
  }

  bool get isOnboardingComplete =>
      _prefs?.getBool(_keyIsOnboardingComplete) ?? false;
  Future<void> setOnboardingComplete(bool value) async {
    await _prefs?.setBool(_keyIsOnboardingComplete, value);
  }

  String get selectedPlan =>
      _prefs?.getString(_keySelectedPlan) ?? 'Personal';
  Future<void> setSelectedPlan(String value) async {
    await _prefs?.setString(_keySelectedPlan, value);
  }

  bool get isBusiness => selectedPlan == 'Business';

  String get selectedAvatar =>
      _prefs?.getString(_keySelectedAvatar) ??
      (isBusiness ? 'images/spacec.png' : 'images/spacea.png');
  Future<void> setSelectedAvatar(String value) async {
    await _prefs?.setString(_keySelectedAvatar, value);
  }

  String get fullName =>
      _prefs?.getString(_keyFullName) ??
      (isBusiness ? 'Ushie Tech Labs & Studio' : 'Ushie Emmanuel');
  Future<void> setFullName(String value) async {
    await _prefs?.setString(_keyFullName, value);
  }

  String get jobTitle =>
      _prefs?.getString(_keyJobTitle) ??
      (isBusiness
          ? 'Enterprise Mobile & AI Solutions'
          : 'Lead Flutter & Mobile Architect');
  Future<void> setJobTitle(String value) async {
    await _prefs?.setString(_keyJobTitle, value);
  }

  String get bio =>
      _prefs?.getString(_keyBio) ??
      (isBusiness
          ? 'Global digital consultancy engineering high-assurance mobile platforms, bespoke design systems, and cloud infrastructure.'
          : 'Crafting high-performance cross-platform applications with Flutter, Stacked Architecture, and scalable cloud backends.');
  Future<void> setBio(String value) async {
    await _prefs?.setString(_keyBio, value);
  }

  String get location =>
      _prefs?.getString(_keyLocation) ??
      (isBusiness ? 'Lagos, Nigeria & London, UK' : 'Lagos, Nigeria');
  Future<void> setLocation(String value) async {
    await _prefs?.setString(_keyLocation, value);
  }

  // Contact Links
  String get contactEmail =>
      _prefs?.getString(_keyContactEmail) ??
      (isBusiness ? 'contact@ushietechlabs.io' : 'ushie.code@gmail.com');
  Future<void> setContactEmail(String value) async {
    await _prefs?.setString(_keyContactEmail, value);
  }

  String get contactPhone =>
      _prefs?.getString(_keyContactPhone) ??
      (isBusiness ? '+234 800 USHIE LABS' : '+234 810 000 0000');
  Future<void> setContactPhone(String value) async {
    await _prefs?.setString(_keyContactPhone, value);
  }

  String get githubUrl =>
      _prefs?.getString(_keyGithubUrl) ?? 'https://github.com/Ushie-E';
  Future<void> setGithubUrl(String value) async {
    await _prefs?.setString(_keyGithubUrl, value);
  }

  String get linkedinUrl =>
      _prefs?.getString(_keyLinkedinUrl) ??
      'https://linkedin.com/in/ushie-emmanuel';
  Future<void> setLinkedinUrl(String value) async {
    await _prefs?.setString(_keyLinkedinUrl, value);
  }

  String get websiteUrl =>
      _prefs?.getString(_keyWebsiteUrl) ??
      'https://ushie-digital-resume.vercel.app';
  Future<void> setWebsiteUrl(String value) async {
    await _prefs?.setString(_keyWebsiteUrl, value);
  }

  // Skills
  List<String> get skills {
    final list = _prefs?.getStringList(_keySkills);
    if (list != null && list.isNotEmpty) return list;
    return isBusiness
        ? const [
            'Custom Enterprise Software',
            'Cloud Architecture & DevOps',
            'UI/UX Strategy & Design Systems',
            'FinTech & High Assurance',
            'Microservices & APIs',
            '24/7 SLA Support',
            'Agile Augmentation',
          ]
        : const [
            'Flutter',
            'Dart',
            'Stacked Architecture',
            'Supabase & Firebase',
            'REST & GraphQL APIs',
            'State Management',
            'CI/CD Automation',
            'Golden Testing',
            'UI/UX Design',
          ];
  }
  Future<void> setSkills(List<String> value) async {
    await _prefs?.setStringList(_keySkills, value);
  }

  // Interests / Markets
  List<String> get interests {
    final list = _prefs?.getStringList(_keyInterests);
    if (list != null && list.isNotEmpty) return list;
    return isBusiness
        ? const ['Enterprise Tech', 'Architecture & Real Estate', 'FinTech']
        : const ['Technology', 'Design', 'Business'];
  }
  Future<void> setInterests(List<String> value) async {
    await _prefs?.setStringList(_keyInterests, value);
  }

  // Hobbies / Core Services
  List<String> get hobbies {
    final list = _prefs?.getStringList(_keyHobbies);
    if (list != null && list.isNotEmpty) return list;
    return isBusiness
        ? const [
            'Enterprise Mobile Apps',
            'AI & ML Integration',
            'Cloud Migration & Infra',
            'Security Audits',
            'Design Systems',
          ]
        : const [
            'Mobile Architecture Research',
            'Open Source Contributing',
            'Chess & Strategy',
            'Tech Mentorship',
            'Spatial Computing',
          ];
  }
  Future<void> setHobbies(List<String> value) async {
    await _prefs?.setStringList(_keyHobbies, value);
  }

  // Work Experience
  List<ExperienceItem> get experiences {
    final rawJson = _prefs?.getString(_keyExperiences);
    if (rawJson != null && rawJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawJson) as List<dynamic>;
        return decoded
            .map((item) => ExperienceItem.fromMap(item as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }
    return _defaultExperiences(isBusiness);
  }

  Future<void> setExperiences(List<ExperienceItem> items) async {
    final encoded = jsonEncode(items.map((e) => e.toMap()).toList());
    await _prefs?.setString(_keyExperiences, encoded);
  }

  static List<ExperienceItem> _defaultExperiences(bool forBusiness) {
    if (forBusiness) {
      return const [
        ExperienceItem(
          company: 'Finovate Global Banking',
          role: 'Enterprise Mobile Overhaul',
          period: '2023 - 2024',
          description:
              'Delivered next-generation banking Flutter suite with biometric auth, sub-50ms render latency, and ISO-27001 compliance.',
          highlights: [
            'Engineered micro-frontend Flutter module integrating with legacy core banking mainframe',
            'Achieved 99.99% crash-free rate across 1.2M active accounts',
            'Decreased customer transaction drop-off by 28%',
          ],
        ),
        ExperienceItem(
          company: 'AeroLogistics International',
          role: 'Fleet Tracking & Telemetry System',
          period: '2022 - 2023',
          description:
              'Built real-time telemetry dashboard and cross-platform driver suite handling 10M+ daily events.',
          highlights: [
            'Implemented offline-first SQLite sync engine for out-of-coverage transit zones',
            'Reduced fleet turnaround time by 18% with automated dispatch routing',
          ],
        ),
        ExperienceItem(
          company: 'HealthSync Telemedicine',
          role: 'HIPAA Cloud & Patient Platform',
          period: '2021 - 2022',
          description:
              'Engineered encrypted video consultations and patient health records portal with zero-trust security.',
          highlights: [
            'Seamless integration with WebRTC and HL7 healthcare standards',
            'Passed independent external security audit with zero critical vulnerabilities',
          ],
        ),
      ];
    }

    return const [
      ExperienceItem(
        company: 'Vertex Mobile Solutions',
        role: 'Lead Flutter Architect',
        period: '2023 - Present',
        description:
            'Architecting enterprise fintech and logistics apps with Stacked architecture, automated CI/CD, and 99.9% crash-free sessions across 500k+ MAU.',
        highlights: [
          'Modularized multi-package Dart codebase reducing build times by 40%',
          'Established golden testing pipeline eliminating visual regression across Android/iOS/Web',
          'Mentored team of 6 engineers in reactive MVVM state management and clean architecture',
        ],
      ),
      ExperienceItem(
        company: 'CloudPulse Tech',
        role: 'Senior Mobile Engineer',
        period: '2021 - 2023',
        description:
            'Spearheaded Flutter cross-platform migration, reducing code duplication by 45% and accelerating release cycles from bi-weekly to daily.',
        highlights: [
          'Implemented cached network repositories reducing network data usage by 35%',
          'Built custom animation package improving frame rates to steady 60fps on low-end hardware',
        ],
      ),
      ExperienceItem(
        company: 'Nexus Innovations',
        role: 'Software Engineer',
        period: '2019 - 2021',
        description:
            'Developed RESTful backend microservices, real-time WebSockets, and stateful mobile interfaces with responsive design.',
        highlights: [
          'Built push notification engine handling over 2M delivered alerts daily',
          'Optimized database queries decreasing average API response time from 320ms to 75ms',
        ],
      ),
    ];
  }

  // Certifications
  List<CertificationItem> get certifications {
    final rawJson = _prefs?.getString(_keyCertifications);
    if (rawJson != null && rawJson.isNotEmpty) {
      try {
        final decoded = jsonDecode(rawJson) as List<dynamic>;
        return decoded
            .map((item) =>
                CertificationItem.fromMap(item as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }
    return _defaultCertifications(isBusiness);
  }

  Future<void> setCertifications(List<CertificationItem> items) async {
    final encoded = jsonEncode(items.map((e) => e.toMap()).toList());
    await _prefs?.setString(_keyCertifications, encoded);
  }

  static List<CertificationItem> _defaultCertifications(bool forBusiness) {
    if (forBusiness) {
      return const [
        CertificationItem(
          title: 'ISO/IEC 27001 Information Security Management',
          issuer: 'BSI Standards Authority',
          year: '2023',
          credentialUrl: 'https://bsigroup.com',
        ),
        CertificationItem(
          title: 'AWS Advanced Tier Services Partner',
          issuer: 'Amazon Web Services',
          year: '2022',
          credentialUrl: 'https://aws.amazon.com',
        ),
        CertificationItem(
          title: 'Google Cloud Premier Partner Accreditation',
          issuer: 'Google Cloud',
          year: '2021',
          credentialUrl: 'https://cloud.google.com',
        ),
      ];
    }

    return const [
      CertificationItem(
        title: 'Google Certified Associate Cloud Engineer',
        issuer: 'Google Cloud',
        year: '2023',
        credentialUrl: 'https://cloud.google.com/certification',
      ),
      CertificationItem(
        title: 'Meta Certified Senior Flutter Specialist',
        issuer: 'Meta / Coursera',
        year: '2022',
        credentialUrl: 'https://coursera.org',
      ),
      CertificationItem(
        title: 'Professional Scrum Master (PSM I)',
        issuer: 'Scrum.org',
        year: '2021',
        credentialUrl: 'https://scrum.org',
      ),
    ];
  }

  // Settings
  bool get darkMode => _prefs?.getBool(_keyDarkMode) ?? false;
  Future<void> setDarkMode(bool value) async {
    await _prefs?.setBool(_keyDarkMode, value);
    darkModeListenable.value = value;
  }

  bool get notificationsEnabled =>
      _prefs?.getBool(_keyNotifications) ?? true;
  Future<void> setNotificationsEnabled(bool value) async {
    await _prefs?.setBool(_keyNotifications, value);
  }

  bool get analyticsEnabled => _prefs?.getBool(_keyAnalytics) ?? true;
  Future<void> setAnalyticsEnabled(bool value) async {
    await _prefs?.setBool(_keyAnalytics, value);
  }

  List<String> get likedProjects {
    return _prefs?.getStringList(_keyLikedProjects) ?? const [];
  }
  Future<void> setLikedProjects(List<String> value) async {
    await _prefs?.setStringList(_keyLikedProjects, value);
  }

  // Full Profile Save
  Future<void> saveProfile({
    required String plan,
    required String avatar,
    required String name,
    required String title,
    required String bio,
    required String location,
    required List<String> skills,
    required List<String> interests,
    String? contactEmail,
    String? contactPhone,
    String? githubUrl,
    String? linkedinUrl,
    String? websiteUrl,
    List<ExperienceItem>? experiences,
    List<CertificationItem>? certifications,
    List<String>? hobbies,
  }) async {
    await setSelectedPlan(plan);
    await setSelectedAvatar(avatar);
    await setFullName(name);
    await setJobTitle(title);
    await setBio(bio);
    await setLocation(location);
    await setSkills(skills);
    await setInterests(interests);
    if (contactEmail != null) await setContactEmail(contactEmail);
    if (contactPhone != null) await setContactPhone(contactPhone);
    if (githubUrl != null) await setGithubUrl(githubUrl);
    if (linkedinUrl != null) await setLinkedinUrl(linkedinUrl);
    if (websiteUrl != null) await setWebsiteUrl(websiteUrl);
    if (experiences != null) await setExperiences(experiences);
    if (certifications != null) await setCertifications(certifications);
    if (hobbies != null) await setHobbies(hobbies);
    await setOnboardingComplete(true);
  }

  // Persona Switcher (Personal <-> Business)
  Future<void> switchPersona(String newPlan) async {
    final bool forBusiness = newPlan == 'Business';
    await setSelectedPlan(newPlan);
    await setSelectedAvatar(forBusiness ? 'images/spacec.png' : 'images/spacea.png');
    await setFullName(forBusiness ? 'Ushie Tech Labs & Studio' : 'Ushie Emmanuel');
    await setJobTitle(forBusiness ? 'Enterprise Mobile & AI Solutions' : 'Lead Flutter & Mobile Architect');
    await setBio(forBusiness
        ? 'Global digital consultancy engineering high-assurance mobile platforms, bespoke design systems, and cloud infrastructure.'
        : 'Crafting high-performance cross-platform applications with Flutter, Stacked Architecture, and scalable cloud backends.');
    await setLocation(forBusiness ? 'Lagos, Nigeria & London, UK' : 'Lagos, Nigeria');
    await setContactEmail(forBusiness ? 'contact@ushietechlabs.io' : 'ushie.code@gmail.com');
    await setContactPhone(forBusiness ? '+234 800 USHIE LABS' : '+234 810 000 0000');
    await setGithubUrl('https://github.com/Ushie-E');
    await setLinkedinUrl(forBusiness
        ? 'https://linkedin.com/company/ushie-tech-labs'
        : 'https://linkedin.com/in/ushie-emmanuel');
    await setWebsiteUrl('https://ushie-digital-resume.vercel.app');
    await setSkills(forBusiness
        ? const [
            'Custom Enterprise Software',
            'Cloud Architecture & DevOps',
            'UI/UX Strategy & Design Systems',
            'FinTech & High Assurance',
            'Microservices & APIs',
            '24/7 SLA Support',
            'Agile Augmentation',
          ]
        : const [
            'Flutter',
            'Dart',
            'Stacked Architecture',
            'Supabase & Firebase',
            'REST & GraphQL APIs',
            'State Management',
            'CI/CD Automation',
            'Golden Testing',
            'UI/UX Design',
          ]);
    await setInterests(forBusiness
        ? const ['Enterprise Tech', 'Architecture & Real Estate', 'FinTech']
        : const ['Technology', 'Design', 'Business']);
    await setHobbies(forBusiness
        ? const [
            'Enterprise Mobile Apps',
            'AI & ML Integration',
            'Cloud Migration & Infra',
            'Security Audits',
            'Design Systems',
          ]
        : const [
            'Mobile Architecture Research',
            'Open Source Contributing',
            'Chess & Strategy',
            'Tech Mentorship',
            'Spatial Computing',
          ]);
    await setExperiences(_defaultExperiences(forBusiness));
    await setCertifications(_defaultCertifications(forBusiness));
    await setOnboardingComplete(true);
  }

  // Export profile as JSON
  Map<String, dynamic> exportProfileMap() {
    return {
      'profile': {
        'plan': selectedPlan,
        'avatar': selectedAvatar,
        'fullName': fullName,
        'jobTitle': jobTitle,
        'bio': bio,
        'location': location,
      },
      'contact': {
        'email': contactEmail,
        'phone': contactPhone,
        'github': githubUrl,
        'linkedin': linkedinUrl,
        'website': websiteUrl,
      },
      'skills': skills,
      'interests': interests,
      'hobbiesOrServices': hobbies,
      'experiences': experiences.map((e) => e.toMap()).toList(),
      'certifications': certifications.map((c) => c.toMap()).toList(),
      'preferences': {
        'darkMode': darkMode,
        'notificationsEnabled': notificationsEnabled,
        'analyticsEnabled': analyticsEnabled,
        'likedProjects': likedProjects,
      },
    };
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
