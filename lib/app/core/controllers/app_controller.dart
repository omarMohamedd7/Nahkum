import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/services/storage_service.dart';

class AppController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();

  // App theme
  final isDarkMode = false.obs;

  // App language
  final language = 'ar'.obs;

  // App version
  final appVersion = '1.0.0'.obs;

  // App loading state
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadAppSettings();
  }

  // Load app settings from storage
  Future<void> loadAppSettings() async {
    isLoading.value = true;

    try {
      // Load theme preference
      final savedTheme = await _storageService.getData('theme_mode');
      if (savedTheme != null) {
        isDarkMode.value = savedTheme == 'dark';
      }

      // Load language preference
      final savedLanguage = await _storageService.getData('app_language');
      if (savedLanguage != null) {
        language.value = savedLanguage;
      }

      // Apply theme
      _applyTheme();

      // Apply locale
      _applyLocale();
    } catch (e) {
      print('Error loading app settings: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Toggle theme mode
  void toggleThemeMode() {
    isDarkMode.value = !isDarkMode.value;
    _saveThemeMode();
    _applyTheme();
  }

  // Save theme mode preference
  void _saveThemeMode() {
    _storageService.saveData('theme_mode', isDarkMode.value ? 'dark' : 'light');
  }

  // Apply theme based on current preference
  void _applyTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  // Change app language
  void changeLanguage(String lang) {
    language.value = lang;
    _saveLanguage();
    _applyLocale();
  }

  // Save language preference
  void _saveLanguage() {
    _storageService.saveData('app_language', language.value);
  }

  // Apply locale based on current language
  void _applyLocale() {
    Locale locale = const Locale('ar', 'SA'); // Default Arabic

    if (language.value == 'en') {
      locale = const Locale('en', 'US');
    }

    Get.updateLocale(locale);
  }
}
