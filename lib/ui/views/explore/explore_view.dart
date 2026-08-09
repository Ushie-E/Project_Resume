import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'explore_viewmodel.dart';

class ExploreView extends StackedView<ExploreViewModel> {
  const ExploreView({super.key});

  @override
  Widget builder(BuildContext context, ExploreViewModel viewModel, Widget? child) {
    final filters = ['All', 'Architecture', 'Mobile', 'UI/UX', 'DevOps'];
    final projects = viewModel.filteredExploreProjects;

    return Scaffold(
      backgroundColor: kcBackgroundColor,
      appBar: AppBar(
        backgroundColor: kcBackgroundColor,
        elevation: 0,
        title: const Text(
          'Explore Showcase',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            fontFamily: 'Google Sans',
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: viewModel.setSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search projects, enterprise solutions, tags...',
                prefixIcon: const Icon(Icons.search, color: kcOnboardingBlue),
                suffixIcon: viewModel.searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () => viewModel.setSearchQuery(''),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: filters.map((filter) {
                  final isSelected = viewModel.selectedCategoryFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(filter),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Google Sans',
                      ),
                      selectedColor: kcOnboardingBlue,
                      backgroundColor: Colors.white,
                      onSelected: (_) => viewModel.setCategoryFilter(filter),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            // Project Cards List
            if (projects.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Text(
                    'No projects found matching your search.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final p = projects[index];
                  final bool isBusiness = p['isBusiness'] == true;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          child: Image.asset(
                            p['image'] as String,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 160,
                                color: kcOnboardingBlue,
                                child: const Center(
                                  child: Icon(Icons.palette_outlined, size: 60, color: Colors.white),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                          p['category'] as String,
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
                                          child: const Row(
                                            children: [
                                              Icon(Icons.business, size: 12, color: Colors.amber),
                                              SizedBox(width: 4),
                                              Text(
                                                'Enterprise',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.favorite, size: 16, color: Colors.redAccent),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${p['likes']}',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                p['title'] as String,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                p['description'] as String,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[700],
                                  height: 1.3,
                                  fontFamily: 'Google Sans',
                                ),
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 6,
                                children: (p['tags'] as List<String>).map((tag) {
                                  return Chip(
                                    label: Text('#$tag', style: const TextStyle(fontSize: 11)),
                                    backgroundColor: kcBackgroundColor,
                                    visualDensity: VisualDensity.compact,
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  ExploreViewModel viewModelBuilder(BuildContext context) => ExploreViewModel();
}
