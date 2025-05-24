import 'package:equatable/equatable.dart';

/// Base failure class that all specific failures should extend
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic stackTrace;

  const Failure({
    required this.message,
    this.code,
    this.stackTrace,
  });

  @override
  List<Object?> get props => [message, code];
}

/// Server-related failures (API errors, backend issues)
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    required String message,
    this.statusCode,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code,
          stackTrace: stackTrace,
        );

  @override
  List<Object?> get props => [...super.props, statusCode];

  /// Factory constructor for common server errors
  factory ServerFailure.fromStatusCode(int statusCode) {
    switch (statusCode) {
      case 400:
        return ServerFailure(
          message: 'طلب غير صالح',
          statusCode: statusCode,
          code: 'BAD_REQUEST',
        );
      case 401:
        return ServerFailure(
          message: 'غير مصرح بالوصول، يرجى تسجيل الدخول',
          statusCode: statusCode,
          code: 'UNAUTHORIZED',
        );
      case 403:
        return ServerFailure(
          message: 'غير مسموح بالوصول لهذا المورد',
          statusCode: statusCode,
          code: 'FORBIDDEN',
        );
      case 404:
        return ServerFailure(
          message: 'لم يتم العثور على المورد المطلوب',
          statusCode: statusCode,
          code: 'NOT_FOUND',
        );
      case 500:
      case 501:
      case 502:
      case 503:
        return ServerFailure(
          message: 'خطأ في الخادم، يرجى المحاولة لاحقاً',
          statusCode: statusCode,
          code: 'SERVER_ERROR',
        );
      default:
        return ServerFailure(
          message: 'حدث خطأ غير متوقع',
          statusCode: statusCode,
          code: 'UNKNOWN',
        );
    }
  }
}

/// Network-related failures (connection issues)
class NetworkFailure extends Failure {
  const NetworkFailure({
    String message = 'فشل الاتصال بالإنترنت، يرجى التحقق من اتصالك',
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'NETWORK_ERROR',
          stackTrace: stackTrace,
        );
}

/// Validation failures (form validation, input validation)
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required String message,
    this.fieldErrors,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'VALIDATION_ERROR',
          stackTrace: stackTrace,
        );

  @override
  List<Object?> get props => [...super.props, fieldErrors];
}

/// Authentication failures
class AuthFailure extends Failure {
  const AuthFailure({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'AUTH_ERROR',
          stackTrace: stackTrace,
        );

  /// Factory for common auth errors
  factory AuthFailure.invalidCredentials() {
    return const AuthFailure(
      message:
          'بيانات الاعتماد غير صالحة، يرجى التحقق من البريد الإلكتروني وكلمة المرور',
      code: 'INVALID_CREDENTIALS',
    );
  }

  factory AuthFailure.userNotFound() {
    return const AuthFailure(
      message: 'لم يتم العثور على المستخدم',
      code: 'USER_NOT_FOUND',
    );
  }

  factory AuthFailure.emailAlreadyInUse() {
    return const AuthFailure(
      message: 'البريد الإلكتروني مستخدم بالفعل',
      code: 'EMAIL_ALREADY_IN_USE',
    );
  }

  factory AuthFailure.weakPassword() {
    return const AuthFailure(
      message: 'كلمة المرور ضعيفة للغاية',
      code: 'WEAK_PASSWORD',
    );
  }

  factory AuthFailure.invalidOtp() {
    return const AuthFailure(
      message: 'رمز التحقق غير صحيح',
      code: 'INVALID_OTP',
    );
  }

  factory AuthFailure.sessionExpired() {
    return const AuthFailure(
      message: 'انتهت صلاحية الجلسة، يرجى إعادة تسجيل الدخول',
      code: 'SESSION_EXPIRED',
    );
  }
}

/// Cache-related failures (local storage issues)
class CacheFailure extends Failure {
  const CacheFailure({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'CACHE_ERROR',
          stackTrace: stackTrace,
        );
}

/// File-related failures (upload, download, processing)
class FileFailure extends Failure {
  const FileFailure({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'FILE_ERROR',
          stackTrace: stackTrace,
        );

  factory FileFailure.uploadFailed() {
    return const FileFailure(
      message: 'فشل في رفع الملف',
      code: 'UPLOAD_FAILED',
    );
  }

  factory FileFailure.downloadFailed() {
    return const FileFailure(
      message: 'فشل في تنزيل الملف',
      code: 'DOWNLOAD_FAILED',
    );
  }

  factory FileFailure.invalidFormat() {
    return const FileFailure(
      message: 'تنسيق الملف غير صالح',
      code: 'INVALID_FORMAT',
    );
  }

  factory FileFailure.fileTooLarge() {
    return const FileFailure(
      message: 'حجم الملف كبير جدًا',
      code: 'FILE_TOO_LARGE',
    );
  }
}

/// Unknown or unexpected failures
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({
    String message = 'حدث خطأ غير متوقع',
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'UNEXPECTED_ERROR',
          stackTrace: stackTrace,
        );
}
