import 'package:flutter/material.dart';

/// A utility class providing form validation functions to use across the app.
class FormValidators {
  /// Validates an email input field.
  /// Returns null for valid input or an error message.
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال البريد الإلكتروني';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    return null;
  }

  /// Validates a password input field with basic validation.
  /// Returns null for valid input or an error message.
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون على الأقل 6 أحرف';
    }
    return null;
  }

  /// Validates a password input field with strong validation.
  /// Requires uppercase, lowercase, and numbers.
  /// Returns null for valid input or an error message.
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال كلمة المرور';
    }
    if (value.length < 8) {
      return 'كلمة المرور يجب أن تكون على الأقل 8 أحرف';
    }
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$')
        .hasMatch(value)) {
      return 'يجب أن تحتوي كلمة المرور على أحرف كبيرة وصغيرة وأرقام';
    }
    return null;
  }

  /// Validates that the confirm password matches the password field.
  ///
  /// [password] is the text from the password field to compare against.
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'يرجى تأكيد كلمة المرور';
    }
    if (value != password) {
      return 'كلمات المرور غير متطابقة';
    }
    return null;
  }

  /// Validates a required text field.
  ///
  /// [fieldName] is the name of the field to include in error message.
  static String? validateRequired(String? value, {String? fieldName}) {
    final name = fieldName ?? 'الحقل';
    if (value == null || value.isEmpty) {
      return 'إدخال $name';
    }
    return null;
  }

  /// Validates a username field.
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال اسم المستخدم';
    }
    return null;
  }

  /// Validates a phone number field.
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    }
    // Add more specific phone validation if needed
    return null;
  }

  /// Validates a case type dropdown selection.
  static String? validateCaseType(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى اختيار نوع القضية';
    }
    return null;
  }

  /// Validates a case description text field.
  static String? validateCaseDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال وصف القضية';
    }
    return null;
  }

  /// Validates a numeric input field.
  static String? validateNumeric(String? value, {bool required = false}) {
    if (required && (value == null || value.isEmpty)) {
      return 'يرجى إدخال قيمة';
    }
    if (value != null && value.isNotEmpty) {
      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
        return 'يرجى إدخال أرقام فقط';
      }
    }
    return null;
  }

  /// Validates a city/location field.
  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال المدينة';
    }
    return null;
  }

  /// Validates a plaintiff name field.
  static String? validatePlaintiffName(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال اسم المدعي';
    }
    return null;
  }

  /// Validates a defendant name field.
  static String? validateDefendantName(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال اسم المدعي عليه';
    }
    return null;
  }
}
