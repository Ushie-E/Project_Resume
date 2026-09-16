import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/app/app.locator.dart';
import 'package:project/services/preferences_service.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

class ExploreViewModel extends BaseViewModel implements Initialisable {
  final _preferencesService = locator<PreferencesService>();

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

  ExploreViewModel() {
    _initProjects();
  }

  @override
  void initialise() {
    _initProjects();
  }

  void _initProjects() {
    final liked = _preferencesService.likedProjects;
    _exploreProjects = [
      {
        'title': 'Ushie Digital Resume Builder',
        'category': 'Architecture',
        'description':
            'Multi-step interactive digital resume & portfolio platform built with Stacked architecture & Flutter.',
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
            'Real-time analytics dashboard with dynamic theme tokens and responsive layouts.',
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
        'tags': ['Dart', 'REST APIs', 'Charts'],
        'isBusiness': false,
      },
      {
        'title': 'Stitch Enterprise Design System',
        'category': 'UI/UX',
        'description':
            'AI-assisted enterprise design system with high-contrast color palettes and Google Sans typography.',
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
        'likes': liked.contains('Stitch Enterprise Design System') ? 211 : 210,
        'isLiked': liked.contains('Stitch Enterprise Design System'),
        'tags': ['Google Sans', 'Enterprise', 'Stitch'],
        'isBusiness': true,
      },
      {
        'title': 'Cloud CI/CD Pipeline Kit',
        'category': 'DevOps',
        'description':
            'Automated golden snapshot generator and cross-platform build release pipeline.',
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
        'tags': ['CI/CD', 'Golden Testing', 'DevOps'],
        'isBusiness': true,
      },
      {
        'title': 'Ushie Digital Solutions Agency',
        'category': 'Architecture',
        'description':
            'Full-service enterprise app architecture, cloud migration, and high-performance Flutter mobile solutions.',
        'architectureSummary':
            'Enterprise microservices ecosystem with zero-trust token authentication, high-throughput message brokers, and multi-cloud resilience.',
        'keyFeatures': [
          'End-to-end encryption & HIPAA / SOC2 compliance',
          'Global multi-region replication on Supabase & AWS',
          '99.99% enterprise service-level agreement guarantees',
        ],
        'liveDemoUrl': 'https://ushie-digital-resume.vercel.app',
        'githubUrl': 'https://github.com/Ushie-E/Project_Resume',
        'image': 'images/spaceg.png',
        'likes': liked.contains('Ushie Digital Solutions Agency') ? 326 : 325,
        'isLiked': liked.contains('Ushie Digital Solutions Agency'),
        'tags': ['Enterprise', 'Agency', 'Architecture'],
        'isBusiness': true,
      },
    ];
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
      if (project['isLiked'] == true) {
        if (!liked.contains(title)) liked.add(title);
      } else {
        liked.remove(title);
      }
      _preferencesService.setLikedProjects(liked);
      rebuildUi();
    }
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

  void copyLink(BuildContext context, String url, String label) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text('$label copied to clipboard!'),
          ],
        ),
        backgroundColor: const Color(0xFF254EDB),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showProjectDetailsModal(BuildContext context, Map<String, dynamic> project, bool darkMode) {
    final cardBgColor = darkMode ? const Color(0xFF1E293B) : Colors.white;
    final primaryTextColor = darkMode ? Colors.white : const Color(0xFF0F172A);
    final secondaryTextColor = darkMode ? Colors.white70 : Colors.grey[800];
    final bool isBusiness = project['isBusiness'] == true;
    final List<String> keyFeatures = (project['keyFeatures'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: cardBgColor,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.82,
          maxChildSize: 0.94,
          minChildSize: 0.5,
          expand: false,
          builder: (_, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      project['image'] as String,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        height: 180,
                        color: kcOnboardingBlue,
                        child: const Center(
                          child: Icon(Icons.palette_outlined, size: 60, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isBusiness ? kcPurpleBackground : kcTealBackground,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              project['category'] as String,
                              style: TextStyle(
                                color: isBusiness ? kcPurpleIcon : kcTealIcon,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          if (isBusiness) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Enterprise Spec',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          project['isLiked'] == true ? Icons.favorite : Icons.favorite_border,
                          color: project['isLiked'] == true ? Colors.redAccent : Colors.grey,
                        ),
                        onPressed: () {
                          toggleProjectLike(project['title'] as String);
                          Navigator.pop(ctx);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    project['title'] as String,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project['description'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                      height: 1.4,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 12),
                  Text(
                    'Architecture & Implementation Highlights',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project['architectureSummary'] as String? ?? 'Engineered with clean architectural patterns and responsive UI components.',
                    style: TextStyle(
                      fontSize: 13,
                      color: secondaryTextColor,
                      height: 1.4,
                    ),
                  ),
                  if (keyFeatures.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Key Deliverables',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: primaryTextColor,
                        fontFamily: 'Google Sans',
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...keyFeatures.map((f) => Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.check_circle, color: kcOnboardingBlue, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  f,
                                  style: TextStyle(fontSize: 13, color: secondaryTextColor),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Tech Stack',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: primaryTextColor,
                      fontFamily: 'Google Sans',
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: (project['tags'] as List<String>).map((tag) {
                      return Chip(
                        label: Text('#$tag', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        backgroundColor: darkMode ? const Color(0xFF0F172A) : kcTealBackground,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF254EDB),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () {
                            copyLink(context, project['liveDemoUrl'] as String? ?? 'https://ushie-digital-resume.vercel.app', 'Live Demo URL');
                          },
                          icon: const Icon(Icons.open_in_new, size: 18),
                          label: const Text('Live Demo Link', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: primaryTextColor,
                            side: const BorderSide(color: kcOnboardingBlue),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          onPressed: () {
                            copyLink(context, project['githubUrl'] as String? ?? 'https://github.com/Ushie-E/Project_Resume', 'GitHub Repo');
                          },
                          icon: const Icon(Icons.code, size: 18, color: kcOnboardingBlue),
                          label: const Text('Source Code', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
