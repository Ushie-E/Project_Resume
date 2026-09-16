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
    final bool isBusiness = viewModel.isBusinessPlan;
    final String displayName = isBusiness ? viewModel.displayCompanyName : viewModel.displayName;
    final String displayTitle = isBusiness ? viewModel.displayCompanySector : viewModel.displayJobTitle;
    final skills = isBusiness ? viewModel.selectedBusinessCapabilities : viewModel.selectedPersonalSkills;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isBusiness ? 'Review Enterprise Profile' : 'Review Digital Resume',
                  style: kOnboardingTitleStyle,
                ),
                const SizedBox(height: 8),
                Text(
                  'Review your executive profile details and resume sections before launching.',
                  style: kOnboardingSubtitleStyle,
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      buildAvatarWidget(viewModel.selectedAvatar, radius: 44),
                      const SizedBox(height: 12),
                      Text(
                        displayName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        displayTitle,
                        textAlign: TextAlign.center,
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

                      // Contact Summary Row
                      _buildReviewRow(
                        icon: Icons.email_outlined,
                        label: 'Email',
                        value: viewModel.contactEmail,
                      ),
                      const SizedBox(height: 8),
                      _buildReviewRow(
                        icon: Icons.phone_outlined,
                        label: 'Phone',
                        value: viewModel.contactPhone,
                      ),
                      const SizedBox(height: 8),
                      _buildReviewRow(
                        icon: Icons.location_on_outlined,
                        label: 'Location',
                        value: viewModel.location.isEmpty
                            ? (isBusiness ? 'Lagos & London' : 'Lagos, Nigeria')
                            : viewModel.location,
                      ),
                      const SizedBox(height: 8),
                      _buildReviewRow(
                        icon: Icons.code,
                        label: 'GitHub',
                        value: viewModel.githubUrl,
                      ),
                      const SizedBox(height: 16),
                      const Divider(),
                      const SizedBox(height: 12),

                      // Experience Highlight
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          isBusiness ? 'Enterprise Deliveries (${viewModel.experiences.length}):' : 'Work Experience (${viewModel.experiences.length}):',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Google Sans',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...viewModel.experiences.take(2).map((exp) => Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Row(
                              children: [
                                const Icon(Icons.work_outline, size: 16, color: kcOnboardingBlue),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${exp.role} at ${exp.company} (${exp.period})',
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          )),

                      const SizedBox(height: 12),
                      const Divider(),
                      const SizedBox(height: 12),

                      // Skills Section
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          isBusiness ? 'Core Capabilities:' : 'Skills & Technologies:',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: 'Google Sans',
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: skills.map((s) {
                          return Chip(
                            label: Text(s, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            backgroundColor: isBusiness ? kcPurpleBackground : kcTealBackground,
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
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF3F6AD8).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        isBusiness ? 'Launch Company Profile' : 'Complete & Launch Digital Resume',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Google Sans',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        buildProgressBar(context, 1.0),
      ],
    );
  }

  Widget _buildReviewRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Text('$label: ', style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
