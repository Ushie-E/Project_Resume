import 'package:flutter_test/flutter_test.dart';
import 'package:project/app.locator.dart';
import 'package:project/ui/views/explore/explore_viewmodel.dart';
import '../helpers/test_helpers.dart';

void main() {
  group('ExploreViewModelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    test('When initialized, should have default projects and filters', () {
      final model = ExploreViewModel();
      expect(model.selectedCategoryFilter, 'All');
      expect(model.searchQuery, isEmpty);
      expect(model.filteredExploreProjects.length, 5);
    });

    test('When setCategoryFilter is called, should filter projects', () {
      final model = ExploreViewModel();
      model.setCategoryFilter('Mobile');
      expect(model.filteredExploreProjects.length, 1);
      expect(model.filteredExploreProjects.first['category'], 'Mobile');
    });

    test('When toggleProjectLike is called, should increment likes', () {
      final model = ExploreViewModel();
      final title = 'Ushie Digital Resume Builder';
      final initialLikes = model.exploreProjects.firstWhere((p) => p['title'] == title)['likes'] as int;

      model.toggleProjectLike(title);
      final updatedLikes = model.exploreProjects.firstWhere((p) => p['title'] == title)['likes'] as int;
      expect(updatedLikes, initialLikes + 1);

      // Toggle again should decrement
      model.toggleProjectLike(title);
      final finalLikes = model.exploreProjects.firstWhere((p) => p['title'] == title)['likes'] as int;
      expect(finalLikes, initialLikes);
    });
  });
}
