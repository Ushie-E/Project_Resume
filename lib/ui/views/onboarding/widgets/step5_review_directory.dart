import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/common/const.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';
import 'onboarding_shared_widgets.dart';

class Step5ReviewDirectory extends StatelessWidget {
  final OnboardingViewModel viewModel;
  final OnboardingCompleteCallback onComplete;

  const Step5ReviewDirectory({
    super.key,
    required this.viewModel,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return viewModel.isBusinessPlan
        ? _buildBusinessStep5(context, viewModel)
        : _buildPersonalStep5(context, viewModel);
  }

  Widget _buildPersonalStep5(BuildContext context, OnboardingViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Review Profile',
                  style: kOnboardingTitleStyle,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Double check your details before finalizing setup.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      buildAvatarWidget(viewModel.selectedAvatar, radius: 40),
                      const SizedBox(height: 12),
                      Text(
                        viewModel.displayName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      Text(
                        viewModel.displayJobTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: kcOnboardingBlue,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Plan Type:', style: TextStyle(color: Colors.grey)),
                          Text(viewModel.selectedPlan,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Location:', style: TextStyle(color: Colors.grey)),
                          Text(
                              viewModel.location.isEmpty ? 'Not specified' : viewModel.location,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Selected Skills:',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: viewModel.selectedPersonalSkills.map((s) {
                          return Chip(
                            label: Text(s, style: const TextStyle(fontSize: 12)),
                            backgroundColor: kcTealBackground,
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                GestureDetector(
                  onTap: () => viewModel.nextStep(onComplete),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Complete Profile Setup',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        buildProgressBar(context, 1.0),
      ],
    );
  }

  Widget _buildBusinessStep5(BuildContext context, OnboardingViewModel viewModel) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        width: 160,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.9),
                                Colors.grey.shade300.withValues(alpha: 0.4),
                              ],
                              radius: 1.2,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'VISUAL DIRECTORY',
                              style: TextStyle(
                                color: Color(0xFF3F6AD8),
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.2,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'The Luminous\nAssets of\nUshie Digital',
                              style: TextStyle(
                                color: Color(0xFF1E293B),
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1.15,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              'A curated collection of architectural illustrations, editorial photography, and abstract textures that define the Effortless Architect identity.',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                                height: 1.4,
                                fontFamily: 'Google Sans',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                _buildAssetCard(
                  imagePath: 'images/spacea.png',
                  imageHeight: 160,
                  title: 'Spatial Serenity',
                  badge: 'SCREEN_14',
                  description: 'Primary background asset for high-level architectural overview screens.',
                ),
                const SizedBox(height: 20),

                _buildAssetCard(
                  imagePath: viewModel.selectedAvatar,
                  imageHeight: 240,
                  title: 'Identity Anchor',
                  badge: 'SCREEN_2',
                  description: 'Editorial profile picture placeholder for the concierge persona.',
                ),
                const SizedBox(height: 20),

                _buildAssetCard(
                  imagePath: 'images/spacec.png',
                  imageHeight: 200,
                  title: 'Organic Rhythm',
                  badge: 'SCREEN_10',
                  description: 'Background layering component used for onboarding focus areas.',
                ),
                const SizedBox(height: 20),

                _buildAssetCard(
                  imagePath: 'images/spaced.png',
                  imageHeight: 160,
                  title: 'Structural Clarity',
                  badge: 'SCREEN_9',
                  description: "High-impact header image for the 'Review and Submit' finalization phase.",
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.75,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF254EDB),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Visual Compliance: 75% Complete',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontFamily: 'Google Sans',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Exporting all brand assets & specifications...'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [Color(0xFFA5F3FC), Color(0xFF67E8F9)],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Export All\nAssets',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                              height: 1.1,
                              fontFamily: 'Google Sans',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => viewModel.nextStep(onComplete),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF3F6AD8).withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Continue\nOnboarding',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                              fontFamily: 'Google Sans',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAssetCard({
    required String imagePath,
    required double imageHeight,
    required String title,
    required String badge,
    required String description,
  }) {
    return Container(
      width: double.infinity,
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
            child: imagePath == 'images/empty_profile.png'
                ? Container(
                    height: imageHeight,
                    color: const Color(0xFFE2E8F0),
                    child: const Center(
                      child: Icon(Icons.person_outline, size: 80, color: Color(0xFF64748B)),
                    ),
                  )
                : Image.asset(
                    imagePath,
                    height: imageHeight,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: imageHeight,
                        color: kcOnboardingBlue,
                        child: const Center(
                          child: Icon(Icons.architecture_outlined, size: 60, color: Colors.white),
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Google Sans',
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        badge,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          letterSpacing: 0.5,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    height: 1.35,
                    fontFamily: 'Google Sans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
