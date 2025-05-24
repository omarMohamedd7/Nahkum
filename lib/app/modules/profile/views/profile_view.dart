import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:legal_app/app/theme/app_colors.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        centerTitle: true,
        backgroundColor: AppColors.ScreenBackground,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          Obx(() => CircleAvatar(
                radius: 50,
                backgroundImage: controller.imageUrl != null
                    ? NetworkImage(controller.imageUrl!)
                    : null,
                child: controller.imageUrl == null
                    ? const Icon(Icons.person, size: 50)
                    : null,
              )),
          const SizedBox(height: 16.0),
          TextButton.icon(
            icon: const Icon(Icons.camera_alt),
            label: const Text('تغيير الصورة'),
            onPressed: () {
              // Implement image picker functionality
              controller.updateProfileImage('https://example.com/profile.jpg');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileForm() {
    return Column(
      children: [
        TextFormField(
          initialValue: controller.name,
          decoration: const InputDecoration(
            labelText: 'الاسم',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => controller.updateUserProfile(name: value),
        ),
        const SizedBox(height: 16.0),
        TextFormField(
          initialValue: controller.email,
          decoration: const InputDecoration(
            labelText: 'البريد الإلكتروني',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => controller.updateUserProfile(email: value),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => controller.saveUserProfile(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: const Text(
          'حفظ التغييرات',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
