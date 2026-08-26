import 'package:stacked/stacked.dart';

class ExploreViewModel extends BaseViewModel {
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

  final List<Map<String, dynamic>> exploreProjects = const [
    {
      'title': 'Ushie Digital Resume Builder',
      'category': 'Architecture',
      'description': 'Multi-step interactive digital resume built with Stacked architecture & Flutter.',
      'image': 'images/spacea.png',
      'likes': 142,
      'tags': ['Flutter', 'Stacked', 'UI/UX'],
      'isBusiness': false,
    },
    {
      'title': 'Quantum Portfolio Dashboard',
      'category': 'Mobile',
      'description': 'Real-time analytics dashboard with dynamic theme tokens and responsive layouts.',
      'image': 'images/spacec.png',
      'likes': 98,
      'tags': ['Dart', 'REST APIs', 'Charts'],
      'isBusiness': false,
    },
    {
      'title': 'Stitch Enterprise Design System',
      'category': 'UI/UX',
      'description': 'AI-assisted enterprise design system with high-contrast color palettes and Google Sans typography.',
      'image': 'images/spaced.png',
      'likes': 210,
      'tags': ['Google Sans', 'Enterprise', 'Stitch'],
      'isBusiness': true,
    },
    {
      'title': 'Cloud CI/CD Pipeline Kit',
      'category': 'DevOps',
      'description': 'Automated golden snapshot generator and cross-platform build release pipeline.',
      'image': 'images/spacee.png',
      'likes': 76,
      'tags': ['CI/CD', 'Golden Testing', 'DevOps'],
      'isBusiness': true,
    },
    {
      'title': 'Ushie Digital Solutions Agency',
      'category': 'Architecture',
      'description': 'Full-service enterprise app architecture, cloud migration, and high-performance Flutter mobile solutions.',
      'image': 'images/spaceg.png',
      'likes': 325,
      'tags': ['Enterprise', 'Agency', 'Architecture'],
      'isBusiness': true,
    },
  ];

  List<Map<String, dynamic>> get filteredExploreProjects {
    return exploreProjects.where((project) {
      final matchesCategory = _selectedCategoryFilter == 'All' ||
          project['category'] == _selectedCategoryFilter;
      final matchesSearch = _searchQuery.isEmpty ||
          (project['title'] as String).toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (project['description'] as String).toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
}
