import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/app.locator.dart';
import 'package:project/app.dialogs.dart';
import 'package:project/models/resume_models.dart';
import 'package:project/services/preferences_service.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel implements Initialisable {
  final _dialogService = locator<DialogService>();
  final _preferencesService = locator<PreferencesService>();

  int _currentStep = 1;
  int get currentStep => _currentStep;

  bool _isOnboardingComplete = false;
  bool get isOnboardingComplete => _isOnboardingComplete;

  // Bottom Navigation Tab Index: 0 = Explore, 1 = My Profile, 2 = Settings
  int _selectedTabIndex = 1;
  int get selectedTabIndex => _selectedTabIndex;

  HomeViewModel() {
    _initExploreProjects();
  }

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    rebuildUi();
  }

  // ---------------------------------------------------------------------------
  // INITIALIZATION & PERSISTENCE
  // ---------------------------------------------------------------------------
  @override
  void initialise() {
    initFromPreferences();
    _initExploreProjects();
  }

  void initFromPreferences() {
    if (_preferencesService.isOnboardingComplete) {
      _isOnboardingComplete = true;
      _selectedPlan = _preferencesService.selectedPlan;
      _selectedAvatar = _preferencesService.selectedAvatar;
      _fullName = _preferencesService.fullName;
      _jobTitle = _preferencesService.jobTitle;
      _bio = _preferencesService.bio;
      _location = _preferencesService.location;
      _contactEmail = _preferencesService.contactEmail;
      _contactPhone = _preferencesService.contactPhone;
      _githubUrl = _preferencesService.githubUrl;
      _linkedinUrl = _preferencesService.linkedinUrl;
      _websiteUrl = _preferencesService.websiteUrl;
      _experiences = List.from(_preferencesService.experiences);
      _certifications = List.from(_preferencesService.certifications);
      _hobbies = List.from(_preferencesService.hobbies);
      _selectedSkills = Set.from(_preferencesService.skills);
      _selectedInterests = Set.from(_preferencesService.interests);
      _darkMode = _preferencesService.darkMode;
      _notificationsEnabled = _preferencesService.notificationsEnabled;
      _analyticsEnabled = _preferencesService.analyticsEnabled;
      rebuildUi();
    } else {
      _isOnboardingComplete = false;
      rebuildUi();
    }
  }

  // ---------------------------------------------------------------------------
  // PROFILE & AVATAR STATE
  // ---------------------------------------------------------------------------
  String _selectedPlan = 'Personal';
  String get selectedPlan => _selectedPlan;
  bool get isBusiness => _selectedPlan == 'Business';

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

  String _fullName = 'Ushie Emmanuel';
  String get fullName => _fullName;

  String _jobTitle = 'Lead Flutter & Mobile Architect';
  String get jobTitle => _jobTitle;

  String _bio =
      'Crafting high-performance cross-platform applications with Flutter, Stacked Architecture, and scalable cloud backends.';
  String get bio => _bio;

  String _location = 'Lagos, Nigeria';
  String get location => _location;

  String _contactEmail = 'ushie.code@gmail.com';
  String get contactEmail => _contactEmail;

  String _contactPhone = '+234 810 000 0000';
  String get contactPhone => _contactPhone;

  String _githubUrl = 'https://github.com/Ushie-E';
  String get githubUrl => _githubUrl;

  String _linkedinUrl = 'https://linkedin.com/in/ushie-emmanuel';
  String get linkedinUrl => _linkedinUrl;

  String _websiteUrl = 'https://ushie-digital-resume.vercel.app';
  String get websiteUrl => _websiteUrl;

  List<ExperienceItem> _experiences = [];
  List<ExperienceItem> get experiences => _experiences;

  List<CertificationItem> _certifications = [];
  List<CertificationItem> get certifications => _certifications;

  List<String> _hobbies = [];
  List<String> get hobbies => _hobbies;

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

  Set<String> _selectedSkills = {'Flutter', 'Dart', 'Stacked Architecture'};
  Set<String> get selectedSkills => _selectedSkills;

  Set<String> _selectedInterests = {};
  Set<String> get selectedInterests => _selectedInterests;

  // ---------------------------------------------------------------------------
  // SETTINGS TAB STATE
  // ---------------------------------------------------------------------------
  bool _darkMode = false;
  bool get darkMode => _darkMode;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  bool _analyticsEnabled = true;
  bool get analyticsEnabled => _analyticsEnabled;

  void toggleDarkMode(bool value) {
    _darkMode = value;
    _preferencesService.setDarkMode(value);
    rebuildUi();
  }

  void toggleNotifications(bool value) {
    _notificationsEnabled = value;
    _preferencesService.setNotificationsEnabled(value);
    rebuildUi();
  }

  void toggleAnalytics(bool value) {
    _analyticsEnabled = value;
    _preferencesService.setAnalyticsEnabled(value);
    rebuildUi();
  }

  // ---------------------------------------------------------------------------
  // EXPLORE TAB STATE
  // ---------------------------------------------------------------------------
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String _selectedCategoryFilter = 'All';
  String get selectedCategoryFilter => _selectedCategoryFilter;

  void setSearchQuery(String query) {
    _searchQuery = query;
    rebuildUi();
  }

  void setCategoryFilter(String filter) {
    _selectedCategoryFilter = filter;
    rebuildUi();
  }

  late List<Map<String, dynamic>> _exploreProjects;
  List<Map<String, dynamic>> get exploreProjects => _exploreProjects;

  void _initExploreProjects() {
    final liked = _preferencesService.likedProjects;
    _exploreProjects = [
      {
        'title': 'Ushie Digital Resume Builder',
        'category': 'Architecture',
        'description':
            'Multi-step interactive digital resume & portfolio platform with Stacked architecture & offline storage.',
        'architectureSummary':
            'Clean MVVM layered architecture with Stacked framework, Mockito automated unit testing harness, responsive design system, and multi-flavor quality gate.',
        'keyFeatures': [
          'Interactive Resume Timeline & Verified Credential Badges',
          'Instant Formatted CV / Markdown & A4 Export',
          'Persistent Shared Preferences with Web & Mobile Sync',
          'Supabase Cloud DB Integration & Vercel Automated Deploy',
        ],
        'liveDemoUrl': 'https://ushie-digital-resume.vercel.app',
        'githubUrl': 'https://github.com/Ushie-E/Project_Resume',
        'image': 'images/spacea.png',
        'likes': liked.contains('Ushie Digital Resume Builder') ? 143 : 142,
        'isLiked': liked.contains('Ushie Digital Resume Builder'),
        'tags': ['Flutter', 'Stacked', 'MVVM', 'Dart'],
        'isBusiness': false,
      },
      {
        'title': 'Quantum Portfolio Dashboard',
        'category': 'Mobile',
        'description':
            'Real-time analytics dashboard with dynamic theme tokens, KPI counter metrics, and responsive layouts.',
        'architectureSummary':
            'Reactive state stream management utilizing Provider and ValueNotifiers, optimized caching layer, and microsecond render pipeline.',
        'keyFeatures': [
          'Sub-60fps smooth animations on low-power devices',
          'Dynamic Dark & Light Mode Theme Tokenizer',
          'Zero-latency metric caching',
        ],
        'liveDemoUrl': 'https://quantum-portfolio.vercel.app',
        'githubUrl': 'https://github.com/Ushie-E/Project_Resume',
        'image': 'images/spacec.png',
        'likes': liked.contains('Quantum Portfolio Dashboard') ? 99 : 98,
        'isLiked': liked.contains('Quantum Portfolio Dashboard'),
        'tags': ['Dart', 'REST APIs', 'Charts', 'Analytics'],
        'isBusiness': false,
      },
      {
        'title': 'Stitch Design System',
        'category': 'UI/UX',
        'description':
            'AI-assisted design system with high-contrast color palettes and Google Sans typography tokens.',
        'architectureSummary':
            'Modular atomic design system with reusable typography, responsive containers, card containers, and accessibility WCAG AA compliance.',
        'keyFeatures': [
          'WCAG 2.1 AA High-Contrast Compliance',
          'Pixel-independent responsive breakpoints (320px - 1440px)',
          'Modular CSS & Flutter Design Tokens',
        ],
        'liveDemoUrl': 'https://stitch-design.vercel.app',
        'githubUrl': 'https://github.com/Ushie-E/Project_Resume',
        'image': 'images/spaced.png',
        'likes': liked.contains('Stitch Design System') ? 211 : 210,
        'isLiked': liked.contains('Stitch Design System'),
        'tags': ['Google Sans', 'Design System', 'Stitch', 'Accessibility'],
        'isBusiness': true,
      },
      {
        'title': 'Cloud CI/CD Pipeline Kit',
        'category': 'DevOps',
        'description':
            'Automated golden snapshot generator and cross-platform release pipeline supporting dev, staging, and prod.',
        'architectureSummary':
            'GitHub Actions automated cloud workflow executing multi-platform linting, static code analysis, unit test suites, and Vercel edge deployment.',
        'keyFeatures': [
          'Multi-branch deployment automation (staging & production)',
          'Golden image visual regression detector',
          'flavor_manifest.json verification promotion gate',
        ],
        'liveDemoUrl': 'https://staging-ushie-digital-resume.vercel.app',
        'githubUrl': 'https://github.com/Ushie-E/Project_Resume',
        'image': 'images/spacee.png',
        'likes': liked.contains('Cloud CI/CD Pipeline Kit') ? 77 : 76,
        'isLiked': liked.contains('Cloud CI/CD Pipeline Kit'),
        'tags': ['CI/CD', 'Golden Testing', 'DevOps', 'GitHub Actions'],
        'isBusiness': true,
      },
    ];
  }

  List<Map<String, dynamic>> get filteredExploreProjects {
    return _exploreProjects.where((project) {
      final matchesCategory = _selectedCategoryFilter == 'All' ||
          project['category'] == _selectedCategoryFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          (project['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (project['description'] as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void toggleProjectLike(String title) {
    final index = _exploreProjects.indexWhere((p) => p['title'] == title);
    if (index != -1) {
      final project = Map<String, dynamic>.from(_exploreProjects[index]);
      final bool wasLiked = project['isLiked'] == true;
      project['isLiked'] = !wasLiked;
      project['likes'] = (project['likes'] as int) + (wasLiked ? -1 : 1);
      _exploreProjects[index] = project;

      final liked = _preferencesService.likedProjects.toList();
      if (project['isLiked']) {
        if (!liked.contains(title)) liked.add(title);
      } else {
        liked.remove(title);
      }
      _preferencesService.setLikedProjects(liked);
      rebuildUi();
    }
  }

  // ---------------------------------------------------------------------------
  // INTERACTIVE RESUME EXPORT & DOWNLOAD (CV FORMATTER)
  // ---------------------------------------------------------------------------
  String generateResumeMarkdown() {
    final buffer = StringBuffer();
    buffer.writeln('# $_fullName');
    buffer.writeln('**$_jobTitle** | $_location');
    buffer.writeln('Email: $_contactEmail | Phone: $_contactPhone');
    buffer.writeln('GitHub: $_githubUrl | LinkedIn: $_linkedinUrl');
    buffer.writeln('Portfolio: $_websiteUrl\n');
    buffer.writeln('## Professional Summary');
    buffer.writeln('$_bio\n');

    buffer.writeln('## Technical Expertise & Skills');
    buffer.writeln(_selectedSkills.join(' • '));
    buffer.writeln();

    buffer.writeln(isBusiness ? '## Enterprise Client Deliveries' : '## Work Experience');
    for (final exp in _experiences) {
      buffer.writeln('### ${exp.role} — ${exp.company} (${exp.period})');
      buffer.writeln(exp.description);
      if (exp.highlights.isNotEmpty) {
        for (final h in exp.highlights) {
          buffer.writeln('- $h');
        }
      }
      buffer.writeln();
    }

    buffer.writeln(isBusiness ? '## Accreditations & Standards' : '## Certifications & Education');
    for (final cert in _certifications) {
      buffer.writeln('- **${cert.title}** — ${cert.issuer} (${cert.year})');
    }
    buffer.writeln();

    buffer.writeln(isBusiness ? '## Core Offerings & Markets' : '## Hobbies & Interests');
    buffer.writeln(_hobbies.isNotEmpty ? _hobbies.join(' • ') : _selectedInterests.join(' • '));
    buffer.writeln();

    return buffer.toString();
  }

  void showDownloadResumeModal(BuildContext context) {
    final isDark = _darkMode;
    final cardBgColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF0F172A);

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: cardBgColor,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isBusiness ? 'Export Company Profile' : 'Download Resume / CV',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: isDark ? Colors.white70 : Colors.black54),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'Choose your preferred export format for printing, sending to recruiters, or client presentation.',
                style: TextStyle(fontSize: 13, color: isDark ? Colors.white60 : Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              ListTile(
                tileColor: isDark ? const Color(0xFF0F172A) : kcTealBackground,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kcOnboardingBlue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.copy_all, color: kcOnboardingBlue),
                ),
                title: Text(
                  'Copy Formatted Markdown / Plain Text CV',
                  style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                ),
                subtitle: const Text('Instantly copy complete resume to clipboard'),
                onTap: () {
                  final md = generateResumeMarkdown();
                  Clipboard.setData(ClipboardData(text: md));
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text('Complete Resume CV copied to clipboard!'),
                        ],
                      ),
                      backgroundColor: Color(0xFF254EDB),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              ListTile(
                tileColor: isDark ? const Color(0xFF0F172A) : kcPurpleBackground,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kcPurpleIcon.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.print_outlined, color: kcPurpleIcon),
                ),
                title: Text(
                  'View Printable A4 Resume Preview',
                  style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
                ),
                subtitle: const Text('Clean printable layout with print / save options'),
                onTap: () {
                  Navigator.pop(ctx);
                  showPrintableResumeDialog(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void showPrintableResumeDialog(BuildContext context) {
    final isDark = _darkMode;
    final resumeText = generateResumeMarkdown();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isBusiness ? 'Company Capability Document' : 'Printable Resume Preview',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Google Sans',
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(ctx),
            ),
          ],
        ),
        content: SizedBox(
          width: 540,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.white12 : Colors.grey.shade300),
              ),
              child: SelectableText(
                resumeText,
                style: TextStyle(
                  fontFamily: 'Courier',
                  fontSize: 12,
                  height: 1.4,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF254EDB),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: resumeText));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied formatted text for printing/PDF export!'),
                  backgroundColor: Color(0xFF254EDB),
                ),
              );
            },
            icon: const Icon(Icons.copy, size: 16),
            label: const Text('Copy to Clipboard'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // INTERACTIVE ACTION HELPERS
  // ---------------------------------------------------------------------------
  void copyEmail(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _contactEmail));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Email copied: $_contactEmail'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void copyPhone(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _contactPhone));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Phone copied: $_contactPhone'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void copyGithub(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _githubUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('GitHub copied: $_githubUrl'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void copyLinkedin(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _linkedinUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('LinkedIn copied: $_linkedinUrl'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void sharePortfolio(BuildContext context) {
    Clipboard.setData(ClipboardData(text: _websiteUrl));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 20),
            SizedBox(width: 8),
            Text('Portfolio link copied to clipboard!'),
          ],
        ),
        backgroundColor: const Color(0xFF254EDB),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showContactModal(BuildContext context) {
    final isDark = _darkMode;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Get in Touch',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: isDark ? Colors.white70 : Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Connect directly for consulting, executive architecture, or full-time roles.',
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? Colors.white60 : Colors.grey[600],
                  fontFamily: 'Google Sans',
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF254EDB).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.email_outlined, color: Color(0xFF254EDB)),
                ),
                title: Text(
                  'Email Inquiry',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Google Sans',
                  ),
                ),
                subtitle: Text(_contactEmail),
                trailing: const Icon(Icons.copy, size: 18),
                onTap: () {
                  copyEmail(context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone_outlined, color: Colors.green),
                ),
                title: Text(
                  'Phone / WhatsApp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Google Sans',
                  ),
                ),
                subtitle: Text(_contactPhone),
                trailing: const Icon(Icons.copy, size: 18),
                onTap: () {
                  copyPhone(context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.code, color: Colors.purple),
                ),
                title: Text(
                  'GitHub Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Google Sans',
                  ),
                ),
                subtitle: Text(_githubUrl),
                trailing: const Icon(Icons.copy, size: 18),
                onTap: () {
                  copyGithub(context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.link, color: Colors.blue),
                ),
                title: Text(
                  'LinkedIn Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                    fontFamily: 'Google Sans',
                  ),
                ),
                subtitle: Text(_linkedinUrl),
                trailing: const Icon(Icons.copy, size: 18),
                onTap: () {
                  copyLinkedin(context);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // SETTERS & METHODS
  // ---------------------------------------------------------------------------
  void setAvatar(String avatarPath) {
    _selectedAvatar = avatarPath;
    _preferencesService.setSelectedAvatar(avatarPath);
    rebuildUi();
  }

  void cycleAvatar() {
    final currentIndex = availableAvatars.indexOf(_selectedAvatar);
    final nextIndex = (currentIndex + 1) % availableAvatars.length;
    _selectedAvatar = availableAvatars[nextIndex];
    _preferencesService.setSelectedAvatar(_selectedAvatar);
    rebuildUi();
  }

  void setPlan(String plan) {
    _selectedPlan = plan;
    _preferencesService.setSelectedPlan(plan);
    rebuildUi();
  }

  void setFullName(String value) {
    _fullName = value;
    _preferencesService.setFullName(value);
    rebuildUi();
  }

  void setJobTitle(String value) {
    _jobTitle = value;
    _preferencesService.setJobTitle(value);
    rebuildUi();
  }

  void setBio(String value) {
    _bio = value;
    _preferencesService.setBio(value);
    rebuildUi();
  }

  void setLocation(String value) {
    _location = value;
    _preferencesService.setLocation(value);
    rebuildUi();
  }

  void toggleSkill(String skill) {
    if (_selectedSkills.contains(skill)) {
      _selectedSkills.remove(skill);
    } else {
      _selectedSkills.add(skill);
    }
    _preferencesService.setSkills(_selectedSkills.toList());
    rebuildUi();
  }

  void addCustomSkill(String skill) {
    final trimmed = skill.trim();
    if (trimmed.isNotEmpty) {
      _selectedSkills.add(trimmed);
      _preferencesService.setSkills(_selectedSkills.toList());
      rebuildUi();
    }
  }

  void toggleInterest(String interest) {
    if (_selectedInterests.contains(interest)) {
      _selectedInterests.remove(interest);
    } else {
      _selectedInterests.add(interest);
    }
    _preferencesService.setInterests(_selectedInterests.toList());
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
      _selectedTabIndex = 1;
      rebuildUi();
    }
  }

  void completeOnboarding() {
    _isOnboardingComplete = true;
    _selectedTabIndex = 1;
    _preferencesService.saveProfile(
      plan: _selectedPlan,
      avatar: _selectedAvatar,
      name: _fullName,
      title: _jobTitle,
      bio: _bio,
      location: _location,
      skills: _selectedSkills.toList(),
      interests: _selectedInterests.toList(),
      contactEmail: _contactEmail,
      contactPhone: _contactPhone,
      githubUrl: _githubUrl,
      linkedinUrl: _linkedinUrl,
      websiteUrl: _websiteUrl,
      experiences: _experiences,
      certifications: _certifications,
      hobbies: _hobbies,
    );
    rebuildUi();
    showSuccessDialog();
  }

  void completeOnboardingWithData(OnboardingViewModel onboardingVm) {
    _selectedPlan = onboardingVm.selectedPlan;
    _selectedAvatar = onboardingVm.selectedAvatar;

    if (onboardingVm.isBusinessPlan) {
      _fullName = onboardingVm.displayCompanyName;
      _jobTitle = onboardingVm.displayCompanySector;
      _bio = onboardingVm.companyOverview.isNotEmpty
          ? onboardingVm.companyOverview
          : 'Delivering enterprise cross-platform mobile products, cloud architectures, and digital design systems for global clients.';
      _location = onboardingVm.companyLocation.isNotEmpty
          ? onboardingVm.companyLocation
          : 'Lagos, Nigeria & Remote';
      _contactEmail = onboardingVm.contactEmail;
      _contactPhone = onboardingVm.contactPhone;
      _githubUrl = onboardingVm.githubUrl;
      _linkedinUrl = onboardingVm.linkedinUrl;
      _websiteUrl = onboardingVm.websiteUrl;
      _selectedSkills = Set.from(onboardingVm.selectedBusinessCapabilities);
      _selectedInterests = Set.from(onboardingVm.selectedTargetMarkets.isNotEmpty
          ? onboardingVm.selectedTargetMarkets
          : {'Enterprise Tech', 'Architecture & Real Estate', 'FinTech'});
      _experiences = List.from(onboardingVm.experiences);
      _certifications = List.from(onboardingVm.certifications);
      _hobbies = List.from(onboardingVm.hobbies);
    } else {
      _fullName = onboardingVm.displayName;
      _jobTitle = onboardingVm.displayJobTitle;
      _bio = onboardingVm.bio.isNotEmpty
          ? onboardingVm.bio
          : 'Crafting high-performance cross-platform applications with Flutter & Stacked.';
      _location = onboardingVm.location.isNotEmpty ? onboardingVm.location : 'Lagos, Nigeria';
      _contactEmail = onboardingVm.contactEmail;
      _contactPhone = onboardingVm.contactPhone;
      _githubUrl = onboardingVm.githubUrl;
      _linkedinUrl = onboardingVm.linkedinUrl;
      _websiteUrl = onboardingVm.websiteUrl;
      _selectedSkills = Set.from(onboardingVm.selectedPersonalSkills);
      _selectedInterests = Set.from(onboardingVm.selectedPersonalInterests);
      _experiences = List.from(onboardingVm.experiences);
      _certifications = List.from(onboardingVm.certifications);
      _hobbies = List.from(onboardingVm.hobbies);
    }

    _isOnboardingComplete = true;
    _selectedTabIndex = 1;
    _preferencesService.saveProfile(
      plan: _selectedPlan,
      avatar: _selectedAvatar,
      name: _fullName,
      title: _jobTitle,
      bio: _bio,
      location: _location,
      skills: _selectedSkills.toList(),
      interests: _selectedInterests.toList(),
      contactEmail: _contactEmail,
      contactPhone: _contactPhone,
      githubUrl: _githubUrl,
      linkedinUrl: _linkedinUrl,
      websiteUrl: _websiteUrl,
      experiences: _experiences,
      certifications: _certifications,
      hobbies: _hobbies,
    );
    rebuildUi();
    showSuccessDialog();
  }

  void restartOnboarding() {
    _currentStep = 1;
    _isOnboardingComplete = false;
    _selectedTabIndex = 1;
    _preferencesService.setOnboardingComplete(false);
    rebuildUi();
  }

  void showSuccessDialog() {
    _dialogService.showCustomDialog(
      variant: DialogType.infoAlert,
      title: _selectedPlan == 'Business' ? 'Company Profile Configured!' : 'Profile Created!',
      description:
          'Congratulations $_fullName! Your profile as $_jobTitle has been created successfully for $_selectedPlan use with ${selectedSkills.length} items.',
    );
  }
}
