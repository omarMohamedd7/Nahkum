import 'package:flutter/material.dart';

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

class UserProfileProvider extends ChangeNotifier {
  UserProfile _userProfile = UserProfile(
    name: 'أسم المستخدم',
    email: 'username1234@gmail.com',
    imageUrl: null,
  );

  UserProfile get userProfile => _userProfile;

  void updateUserProfile({String? name, String? email, String? imageUrl}) {
    _userProfile = _userProfile.copyWith(
      name: name,
      email: email,
      imageUrl: imageUrl,
    );
    notifyListeners();
  }

  // This method would typically handle uploading the image to a server
  // and updating the user profile with the new image URL
  Future<void> updateProfileImage(String imagePath) async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 1));

    // Update the profile with the new image
    updateUserProfile(imageUrl: imagePath);
  }

  // This method would typically make an API call to update the user's profile
  // on the server
  Future<bool> saveUserProfile() async {
    // Simulate a network request
    await Future.delayed(const Duration(seconds: 1));

    // Return success
    return true;
  }
}
