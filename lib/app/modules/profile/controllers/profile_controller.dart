import 'package:get/get.dart';

class UserProfile {
  final String name;
  final String email;
  final String? imageUrl;

  UserProfile({
    required this.name,
    required this.email,
    this.imageUrl,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? imageUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class ProfileController extends GetxController {
  // Observable variables with .obs suffix
  final _userProfile = UserProfile(
    name: 'أسم المستخدم',
    email: 'username1234@gmail.com',
    imageUrl: null,
  ).obs;

  // Getters to access the reactive state
  UserProfile get userProfile => _userProfile.value;
  String get name => _userProfile.value.name;
  String get email => _userProfile.value.email;
  String? get imageUrl => _userProfile.value.imageUrl;

  // Update user profile function
  void updateUserProfile({String? name, String? email, String? imageUrl}) {
    _userProfile.update((profile) {
      profile = profile!.copyWith(
        name: name,
        email: email,
        imageUrl: imageUrl,
      );
    });
  }

  // This method would typically handle uploading the image to a server
  // and updating the user profile with the new image URL
  Future<void> updateProfileImage(String imagePath) async {
    // Show loading indicator
    final isLoading = true.obs;

    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 1));

      // Update the profile with the new image
      updateUserProfile(imageUrl: imagePath);
    } catch (e) {
      // Handle errors
      Get.snackbar(
        'Error',
        'Failed to update profile image: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // This method would typically make an API call to update the user's profile
  // on the server
  Future<bool> saveUserProfile() async {
    // Show loading indicator
    final isLoading = true.obs;

    try {
      // Simulate a network request
      await Future.delayed(const Duration(seconds: 1));

      // Show success message
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
      );

      return true;
    } catch (e) {
      // Handle errors
      Get.snackbar(
        'Error',
        'Failed to save profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
