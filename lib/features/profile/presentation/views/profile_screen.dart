import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../data/providers/user_profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  bool _isSaving = false;
  String? _selectedImagePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    final userProfile =
        Provider.of<UserProfileProvider>(context, listen: false).userProfile;
    _nameController = TextEditingController(text: userProfile.name);
    _emailController = TextEditingController(text: userProfile.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImagePath = pickedFile.path;
          // No success snackbar here
        });

        final profileProvider =
            Provider.of<UserProfileProvider>(context, listen: false);
        await profileProvider.updateProfileImage(_selectedImagePath!);
      }
    } catch (e) {
      if (mounted) {
        final failure = FileFailure.uploadFailed();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);

    try {
      final profileProvider =
          Provider.of<UserProfileProvider>(context, listen: false);
      profileProvider.updateUserProfile(
        name: _nameController.text,
        email: _emailController.text,
      );

      await profileProvider.saveUserProfile();

      setState(() {
        _isSaving = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم حفظ التغييرات بنجاح'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      setState(() => _isSaving = false);

      if (mounted) {
        final failure = e is Failure
            ? e
            : const UnexpectedFailure(message: 'حدث خطأ أثناء حفظ التغييرات');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(failure.message),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 16),
        const Text(
          'حساب المستخدم',
          style: AppStyles.headingMedium,
        ),
        GestureDetector(
          onTap: () => AppRouter.instance.goBack(context),
          child: SvgPicture.asset(
            'assets/images/arrow-right.svg',
            height: 24,
            width: 24,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(UserProfile userProfile) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: AppStyles.roundedProfileImage,
              child: ClipOval(
                child: _selectedImagePath != null
                    ? Image.file(
                        File(_selectedImagePath!),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      )
                    : SvgPicture.asset(
                        "assets/images/profile_image.svg",
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
              ),
            ),
            GestureDetector(
              onTap: _pickProfileImage,
              child: Container(
                height: 32,
                width: 32,
                decoration: AppStyles.editProfileButton,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/edit-2.svg',
                    height: 16,
                    width: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          userProfile.name,
          style: AppStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          userProfile.email,
          style: AppStyles.captionText.copyWith(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildCustomFieldWithRightLabel(
          label: 'أسم المستخدم',
          controller: _nameController,
          hintText: 'أدخل أسم المستخدم',
          iconPath: 'assets/images/user.svg',
        ),
        const SizedBox(height: 24),
        _buildCustomFieldWithRightLabel(
          label: 'البريد الألكتروني',
          controller: _emailController,
          hintText: 'أدخل البريد الألكتروني',
          iconPath: 'assets/images/email_icon.svg',
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  // Custom widget with right-aligned label
  Widget _buildCustomFieldWithRightLabel({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required String iconPath,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end, // Right-align the content
      children: [
        // Label row
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0, right: 4.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: AppStyles.labelText,
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                iconPath,
                height: 20,
                width: 20,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
        // Text field
        Container(
          decoration: AppStyles.inputFieldDecoration,
          child: TextFormField(
            controller: controller,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            keyboardType: keyboardType,
            style: AppStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppStyles.bodyMedium.copyWith(
                color: const Color(0xFFB8B8B8),
              ),
              border: InputBorder.none,
              contentPadding: AppStyles.inputFieldContentPadding,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _isSaving ? null : _saveProfile,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
      ),
      child: _isSaving
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : const Text(
              'حفظ',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProfileProvider>(
      builder: (context, profileProvider, child) {
        final userProfile = profileProvider.userProfile;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAppBar(),
                  const SizedBox(height: 32),
                  _buildProfileHeader(userProfile),
                  const SizedBox(height: 40),
                  _buildProfileFields(),
                  const Spacer(),
                  _buildSaveButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
