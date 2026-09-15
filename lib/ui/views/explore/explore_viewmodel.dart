import 'package:project/app/app.locator.dart';
import 'package:project/services/preferences_service.dart';
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
        'description': 'Multi-step interactive digital resume built with Stacked architecture & Flutter.',
        'image': 'images/spacea.png',
        'likes': liked.contains('Ushie Digital Resume Builder') ? 143 : 142,
        'isLiked': liked.contains('Ushie Digital Resume Builder'),
        'tags': ['Flutter', 'Stacked', 'UI/UX'],
        'isBusiness': false,
      },
      {
        'title': 'Quantum Portfolio Dashboard',
        'category': 'Mobile',
        'description': 'Real-time analytics dashboard with dynamic theme tokens and responsive layouts.',
        'image': 'images/spacec.png',
        'likes': liked.contains('Quantum Portfolio Dashboard') ? 99 : 98,
        'isLiked': liked.contains('Quantum Portfolio Dashboard'),
        'tags': ['Dart', 'REST APIs', 'Charts'],
        'isBusiness': false,
      },
      {
        'title': 'Stitch Enterprise Design System',
        'category': 'UI/UX',
        'description': 'AI-assisted enterprise design system with high-contrast color palettes and Google Sans typography.',
        'image': 'images/spaced.png',
        'likes': liked.contains('Stitch Enterprise Design System') ? 211 : 210,
        'isLiked': liked.contains('Stitch Enterprise Design System'),
        'tags': ['Google Sans', 'Enterprise', 'Stitch'],
        'isBusiness': true,
      },
      {
        'title': 'Cloud CI/CD Pipeline Kit',
        'category': 'DevOps',
        'description': 'Automated golden snapshot generator and cross-platform build release pipeline.',
        'image': 'images/spacee.png',
        'likes': liked.contains('Cloud CI/CD Pipeline Kit') ? 77 : 76,
        'isLiked': liked.contains('Cloud CI/CD Pipeline Kit'),
        'tags': ['CI/CD', 'Golden Testing', 'DevOps'],
        'isBusiness': true,
      },
      {
        'title': 'Ushie Digital Solutions Agency',
        'category': 'Architecture',
        'description': 'Full-service enterprise app architecture, cloud migration, and high-performance Flutter mobile solutions.',
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
}
