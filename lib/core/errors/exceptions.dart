/// Base exception class for the application
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

/// Server exceptions - thrown when server errors occur
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
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
  String toString() =>
      'ServerException: $message (code: $code, statusCode: $statusCode)';
}

/// Network exceptions - thrown when network connectivity issues occur
class NetworkException extends AppException {
  const NetworkException({
    String message = 'فشل الاتصال بالإنترنت، يرجى التحقق من اتصالك',
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'NETWORK_ERROR',
          stackTrace: stackTrace,
        );
}

/// Cache exceptions - thrown when cache/local storage operations fail
class CacheException extends AppException {
  const CacheException({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'CACHE_ERROR',
          stackTrace: stackTrace,
        );
}

/// Authentication exceptions - thrown when authentication operations fail
class AuthException extends AppException {
  const AuthException({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'AUTH_ERROR',
          stackTrace: stackTrace,
        );
}

/// Validation exceptions - thrown when validation fails
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required String message,
    this.fieldErrors,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'VALIDATION_ERROR',
          stackTrace: stackTrace,
        );
}

/// File exceptions - thrown when file operations fail
class FileException extends AppException {
  const FileException({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
          message: message,
          code: code ?? 'FILE_ERROR',
          stackTrace: stackTrace,
        );
}
