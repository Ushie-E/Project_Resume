import 'package:flutter/material.dart';
import 'package:project/ui/common/app_colors.dart';
import 'package:project/ui/views/onboarding/onboarding_viewmodel.dart';

Widget buildAvatarWidget(String avatarPath, {double radius = 40}) {
  if (avatarPath == 'images/empty_profile.png') {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFE2E8F0),
      child: Icon(
        Icons.person_outline,
        size: radius * 1.1,
        color: const Color(0xFF64748B),
      ),
    );
  }
  return CircleAvatar(
    radius: radius,
    backgroundColor: Colors.white24,
    backgroundImage: AssetImage(avatarPath),
  );
}

Widget buildProgressBar(BuildContext context, double factor) {
  return Container(
    width: double.infinity,
    height: 4,
    color: Colors.grey[200],
    child: Align(
      alignment: Alignment.centerLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: MediaQuery.of(context).size.width * factor,
        height: 4,
        color: kcOnboardingBlue,
      ),
    ),
  );
}

Widget buildNavigationButtons({
  required OnboardingViewModel viewModel,
  required bool isValid,
  required String nextText,
  required OnboardingCompleteCallback onComplete,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      TextButton(
        onPressed: viewModel.prevStep,
        child: const Text(
          'Back',
          style: TextStyle(
            color: kcOnboardingBlue,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Google Sans',
          ),
        ),
      ),
      const SizedBox(width: 8),
      Flexible(
        child: GestureDetector(
          onTap: isValid ? () => viewModel.nextStep(onComplete) : null,
          child: Opacity(
            opacity: isValid ? 1.0 : 0.5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: isValid
                    ? const LinearGradient(
                        colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isValid ? null : Colors.grey[400],
              ),
              child: Text(
                nextText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Google Sans',
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildTextField({
  required String label,
  String? hintText,
  required String initialValue,
  required IconData icon,
  int maxLines = 1,
  required ValueChanged<String> onChanged,
}) {
  return TextFormField(
    initialValue: initialValue,
    maxLines: maxLines,
    onChanged: onChanged,
    decoration: InputDecoration(
      labelText: label,
      hintText: hintText,
      prefixIcon: Icon(icon, color: kcOnboardingBlue),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
  );
}

Widget buildPlanCard({
  required String title,
  required String description,
  required IconData icon,
  required Color iconBg,
  required Color iconColor,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : kcOnboardingUnselectedCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? kcOnboardingSelectedBorder : Colors.transparent,
          width: 2,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBg,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kcOnboardingCardText,
                    fontFamily: 'Google Sans',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    height: 1.3,
                    fontFamily: 'Google Sans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

void showAvatarPicker(BuildContext context, OnboardingViewModel viewModel) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Update Profile Picture',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Google Sans',
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.photo_library, color: kcOnboardingBlue),
              title: const Text('Choose from Gallery / Photos'),
              onTap: () {
                Navigator.pop(context);
                viewModel.setAvatar('images/spacea.png');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Selected photo from device gallery')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: kcOnboardingBlue),
              title: const Text('Take Photo with Camera'),
              onTap: () {
                Navigator.pop(context);
                viewModel.setAvatar('images/spacec.png');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Captured profile photo with camera')),
                );
              },
            ),
            const Divider(),
            const Text(
              'Or Select Preset Avatars',
              style: TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: viewModel.availableAvatars.map((avatarPath) {
                final isSelected = viewModel.selectedAvatar == avatarPath;
                return GestureDetector(
                  onTap: () {
                    viewModel.setAvatar(avatarPath);
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? kcOnboardingBlue : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: buildAvatarWidget(avatarPath, radius: 24),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    },
  );
}

void showLoginSheet(
  BuildContext context,
  OnboardingViewModel viewModel,
  OnboardingCompleteCallback onComplete,
) {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Log In to Your Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Google Sans',
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Select a registered profile below or enter credentials to sign in directly.',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            const Text(
              'Sign In As Registered Account:',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            ListTile(
              tileColor: kcTealBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: buildAvatarWidget('images/spacea.png', radius: 20),
              title: const Text('Ushie Emmanuel', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Personal Account • Flutter Mobile Engineer'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: kcOnboardingBlue),
              onTap: () {
                Navigator.pop(context);
                viewModel.loginAsPersonalAccount(onComplete);
              },
            ),
            const SizedBox(height: 8),
            ListTile(
              tileColor: kcPurpleBackground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              leading: buildAvatarWidget('images/spacec.png', radius: 20),
              title: const Text('Ushie Tech Labs', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Business Account • Software & AI Solutions'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: kcPurpleIcon),
              onTap: () {
                Navigator.pop(context);
                viewModel.loginAsBusinessAccount(onComplete);
              },
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('OR ENTER CREDENTIALS',
                      style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                hintText: 'user@domain.com',
                prefixIcon: const Icon(Icons.email_outlined, color: kcOnboardingBlue),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: '••••••••',
                prefixIcon: const Icon(Icons.lock_outline, color: kcOnboardingBlue),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                viewModel.loginAsPersonalAccount(onComplete);
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3F6AD8), Color(0xFF254EDB)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Log In to My Account',
                    style: TextStyle(
                      fontSize: 16,
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
      );
    },
  );
}
