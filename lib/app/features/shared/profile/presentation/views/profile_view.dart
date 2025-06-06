import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/theme/app_styles.dart';
import 'package:legal_app/app/features/shared/profile/presentation/controllers/profile_controller.dart';
import 'package:legal_app/app/shared/widgets/custom_button.dart';
import 'package:legal_app/app/shared/widgets/custom_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final controller = Get.find<ProfileController>();
  late final TextEditingController nameController;
  late final TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: controller.name);
    emailController = TextEditingController(text: controller.email);

    // Add listeners to update the profile
    nameController.addListener(() {
      controller.updateUserProfile(name: nameController.text);
    });

    emailController.addListener(() {
      controller.updateUserProfile(email: emailController.text);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'الملف الشخصي',
          style: AppStyles.headingMedium,
        ),
        centerTitle: true,
        backgroundColor: AppColors.ScreenBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              AppAssets.arrowRight,
              color: AppColors.primary,
            ),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: AppStyles.paddingMedium,
            child: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 24.0),
                _buildProfileForm(),
                const SizedBox(height: 24.0),
                _buildSaveButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Obx(() {
            final hasSelectedImage = controller.selectedImage.value != null;
            final hasNetworkImage =
                controller.imageUrl != null && controller.imageUrl!.isNotEmpty;

            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.goldLight.withOpacity(0.2),
                border: Border.all(
                  color: AppColors.goldLight,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.goldLight.withOpacity(0.2),
                backgroundImage: hasSelectedImage
                    ? FileImage(controller.selectedImage.value! as File)
                    : (hasNetworkImage
                        ? NetworkImage(controller.imageUrl!)
                            as ImageProvider<Object>
                        : null),
                child: (!hasSelectedImage && !hasNetworkImage)
                    ? Icon(Icons.person, size: 50, color: AppColors.primary)
                    : null,
              ),
            );
          }),
          const SizedBox(height: 16.0),
          TextButton.icon(
            icon: Icon(Icons.camera_alt, color: AppColors.goldLight),
            label: Text(
              'تغيير الصورة',
              style: AppStyles.bodyMedium.copyWith(
                color: AppColors.goldLight,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => controller.showImageSourceDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          labelText: 'الاسم',
          hintText: 'أدخل اسمك الكامل',
          controller: nameController,
          prefixIcon: Icons.person,
        ),
        const SizedBox(height: 16.0),
        CustomTextField(
          labelText: 'البريد الإلكتروني',
          hintText: 'أدخل بريدك الإلكتروني',
          controller: emailController,
          prefixIcon: Icons.email,
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Obx(() => CustomButton(
          text: 'حفظ التغييرات',
          onTap: () => controller.saveUserProfile(),
          backgroundColor: AppColors.primary,
          textColor: AppColors.white,
          height: 50,
          isLoading: controller.isLoading.value,
        ));
  }
}
