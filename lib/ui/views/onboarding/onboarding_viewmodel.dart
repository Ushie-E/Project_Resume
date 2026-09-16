import 'package:project/app/app.locator.dart';
import 'package:project/app/app.dialogs.dart';
import 'package:project/models/resume_models.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

typedef OnboardingCompleteCallback = void Function(OnboardingViewModel viewModel);

class OnboardingViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();

  int _currentStep = 1;
  int get currentStep => _currentStep;

  String _selectedPlan = 'Personal';
  String get selectedPlan => _selectedPlan;
  bool get isBusinessPlan => _selectedPlan == 'Business';

  // Available Avatars
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
  // PERSONAL PLAN FIELDS
  // ---------------------------------------------------------------------------
  String _fullName = '';
  String get fullName => _fullName;
  String get displayName => _fullName.trim().isEmpty ? 'Ushie Emmanuel' : _fullName;

  String _jobTitle = '';
  String get jobTitle => _jobTitle;
  String get displayJobTitle =>
      _jobTitle.trim().isEmpty ? 'Lead Flutter & Mobile Architect' : _jobTitle;

  String _bio = '';
  String get bio => _bio;

  String _location = '';
  String get location => _location;

  String _contactEmail = '';
  String get contactEmail =>
      _contactEmail.trim().isEmpty ? 'ushie.code@gmail.com' : _contactEmail;

  String _contactPhone = '';
  String get contactPhone =>
      _contactPhone.trim().isEmpty ? '+234 810 000 0000' : _contactPhone;

  String _githubUrl = '';
  String get githubUrl =>
      _githubUrl.trim().isEmpty ? 'https://github.com/Ushie-E' : _githubUrl;

  String _linkedinUrl = '';
  String get linkedinUrl =>
      _linkedinUrl.trim().isEmpty ? 'https://linkedin.com/in/ushie-emmanuel' : _linkedinUrl;

  String _websiteUrl = '';
  String get websiteUrl =>
      _websiteUrl.trim().isEmpty ? 'https://ushie-digital-resume.vercel.app' : _websiteUrl;

  final List<String> availablePersonalSkills = const [
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

  Set<String> _selectedPersonalSkills = {
    'Flutter',
    'Dart',
    'Stacked Architecture',
    'CI/CD Automation'
  };
  Set<String> get selectedPersonalSkills => _selectedPersonalSkills;

  Set<String> _selectedPersonalInterests = {};
  Set<String> get selectedPersonalInterests => _selectedPersonalInterests;

  // ---------------------------------------------------------------------------
  // BUSINESS PLAN FIELDS
  // ---------------------------------------------------------------------------
  String _companyName = '';
  String get companyName => _companyName;
  String get displayCompanyName =>
      _companyName.trim().isEmpty ? 'Ushie Tech Labs & Studio' : _companyName;

  String _companySector = '';
  String get companySector => _companySector;
  String get displayCompanySector =>
      _companySector.trim().isEmpty ? 'Enterprise Mobile & AI Solutions' : _companySector;

  String _teamSize = '';
  String get teamSize => _teamSize;

  String _companyLocation = '';
  String get companyLocation => _companyLocation;

  String _companyOverview = '';
  String get companyOverview => _companyOverview;

  final List<String> availableBusinessCapabilities = const [
    'Custom Enterprise Software',
    'Cloud Architecture & DevOps',
    'UI/UX Strategy & Design Systems',
    'FinTech & High Assurance',
    'Microservices & APIs',
    '24/7 SLA Support',
    'Agile Augmentation',
  ];

  Set<String> _selectedBusinessCapabilities = {
    'Custom Enterprise Software',
    'Cloud Architecture & DevOps',
    'UI/UX Strategy & Design Systems',
    'FinTech & High Assurance'
  };
  Set<String> get selectedBusinessCapabilities => _selectedBusinessCapabilities;

  Set<String> _selectedTargetMarkets = {};
  Set<String> get selectedTargetMarkets => _selectedTargetMarkets;

  // ---------------------------------------------------------------------------
  // WORK EXPERIENCE & CERTIFICATIONS
  // ---------------------------------------------------------------------------
  List<ExperienceItem> _experiences = [];
  List<ExperienceItem> get experiences => _experiences;

  List<CertificationItem> _certifications = [];
  List<CertificationItem> get certifications => _certifications;

  List<String> _hobbies = [];
  List<String> get hobbies => _hobbies;

  OnboardingViewModel() {
    _initDefaultExperiencesAndCerts();
  }

  void _initDefaultExperiencesAndCerts() {
    if (isBusinessPlan) {
      _experiences = [
        const ExperienceItem(
          company: 'Finovate Global Banking',
          role: 'Enterprise Mobile Overhaul',
          period: '2023 - 2024',
          description:
              'Delivered next-generation banking Flutter suite with biometric auth, sub-50ms render latency, and ISO-27001 compliance.',
          highlights: [
            'Engineered micro-frontend Flutter module integrating with core banking mainframe',
            'Achieved 99.99% crash-free rate across 1.2M active accounts',
          ],
        ),
        const ExperienceItem(
          company: 'AeroLogistics International',
          role: 'Fleet Telemetry System',
          period: '2022 - 2023',
          description:
              'Built real-time telemetry dashboard and driver cross-platform suite handling 10M+ events daily.',
          highlights: [
            'Implemented offline-first SQLite sync engine for out-of-coverage transit zones',
          ],
        ),
      ];
      _certifications = [
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
      ];
      _hobbies = [
        'Enterprise Mobile Apps',
        'AI & ML Integration',
        'Cloud Migration & Infra',
        'Security Audits',
      ];
    } else {
      _experiences = [
        const ExperienceItem(
          company: 'Vertex Mobile Solutions',
          role: 'Lead Flutter Architect',
          period: '2023 - Present',
          description:
              'Architecting enterprise fintech and logistics apps with Stacked architecture, automated CI/CD, and 99.9% crash-free sessions across 500k+ MAU.',
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
      ];
      _certifications = [
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
      ];
      _hobbies = [
        'Mobile Architecture Research',
        'Open Source Contributing',
        'Chess & Strategy',
        'Tech Mentorship',
      ];
    }
  }

  // ---------------------------------------------------------------------------
  // SETTERS & METHODS
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
    _initDefaultExperiencesAndCerts();
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

  void setContactEmail(String value) {
    _contactEmail = value;
    rebuildUi();
  }

  void setContactPhone(String value) {
    _contactPhone = value;
    rebuildUi();
  }

  void setGithubUrl(String value) {
    _githubUrl = value;
    rebuildUi();
  }

  void setLinkedinUrl(String value) {
    _linkedinUrl = value;
    rebuildUi();
  }

  void setWebsiteUrl(String value) {
    _websiteUrl = value;
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

  // Experience Mutations
  void addExperience(ExperienceItem item) {
    _experiences.add(item);
    rebuildUi();
  }

  void removeExperience(int index) {
    if (index >= 0 && index < _experiences.length) {
      _experiences.removeAt(index);
      rebuildUi();
    }
  }

  // Certification Mutations
  void addCertification(CertificationItem item) {
    _certifications.add(item);
    rebuildUi();
  }

  void removeCertification(int index) {
    if (index >= 0 && index < _certifications.length) {
      _certifications.removeAt(index);
      rebuildUi();
    }
  }

  // ---------------------------------------------------------------------------
  // QUICK FILL & LOGIN ACTIONS
  // ---------------------------------------------------------------------------
  void quickFillPersonal() {
    _selectedPlan = 'Personal';
    _fullName = 'Ushie Emmanuel';
    _jobTitle = 'Lead Flutter & Mobile Architect';
    _bio =
        'Crafting high-performance cross-platform applications with Flutter, Stacked Architecture, and scalable cloud backends.';
    _location = 'Lagos, Nigeria';
    _contactEmail = 'ushie.code@gmail.com';
    _contactPhone = '+234 810 000 0000';
    _githubUrl = 'https://github.com/Ushie-E';
    _linkedinUrl = 'https://linkedin.com/in/ushie-emmanuel';
    _websiteUrl = 'https://ushie-digital-resume.vercel.app';
    _selectedPersonalSkills = {
      'Flutter',
      'Dart',
      'Stacked Architecture',
      'CI/CD Automation',
      'Supabase & Firebase',
    };
    _selectedPersonalInterests = {'Technology', 'Design', 'Business'};
    _selectedAvatar = 'images/spacea.png';
    _initDefaultExperiencesAndCerts();
    rebuildUi();
  }

  void quickFillBusiness() {
    _selectedPlan = 'Business';
    _companyName = 'Ushie Tech Labs & Studio';
    _companySector = 'Enterprise Mobile & AI Solutions';
    _teamSize = '11-50 Employees';
    _companyLocation = 'Lagos, Nigeria & London, UK';
    _companyOverview =
        'Global digital consultancy engineering high-assurance mobile platforms, bespoke design systems, and cloud infrastructure.';
    _contactEmail = 'contact@ushietechlabs.io';
    _contactPhone = '+234 800 USHIE LABS';
    _githubUrl = 'https://github.com/Ushie-E/Project_Resume';
    _linkedinUrl = 'https://linkedin.com/company/ushie-tech-labs';
    _websiteUrl = 'https://ushie-digital-resume.vercel.app';
    _selectedBusinessCapabilities = {
      'Custom Enterprise Software',
      'Cloud Architecture & DevOps',
      'UI/UX Strategy & Design Systems',
      'FinTech & High Assurance',
    };
    _selectedTargetMarkets = {'Enterprise Tech', 'Architecture & Real Estate', 'FinTech'};
    _selectedAvatar = 'images/spacec.png';
    _initDefaultExperiencesAndCerts();
    rebuildUi();
  }

  void loginAsPersonalAccount(OnboardingCompleteCallback onComplete) {
    quickFillPersonal();
    onComplete(this);
  }

  void loginAsBusinessAccount(OnboardingCompleteCallback onComplete) {
    quickFillBusiness();
    onComplete(this);
  }

  // ---------------------------------------------------------------------------
  // VALIDATIONS & STEP NAVIGATION
  // ---------------------------------------------------------------------------
  bool get isStep2Valid {
    if (isBusinessPlan) {
      return _companyName.trim().isNotEmpty && _companySector.trim().isNotEmpty;
    }
    return _fullName.trim().isNotEmpty && _jobTitle.trim().isNotEmpty;
  }

  bool get isStep3Valid {
    return _experiences.isNotEmpty;
  }

  bool get isStep4Valid {
    if (isBusinessPlan) {
      return _selectedBusinessCapabilities.length >= 2;
    }
    return _selectedPersonalSkills.length >= 2;
  }

  bool get isStep5Valid {
    if (isBusinessPlan) {
      return _selectedTargetMarkets.length >= 3;
    }
    return _selectedPersonalInterests.length >= 3;
  }

  void nextStep(OnboardingCompleteCallback onComplete) {
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
      onComplete(this);
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
    final String name = isBusinessPlan ? displayCompanyName : displayName;
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
