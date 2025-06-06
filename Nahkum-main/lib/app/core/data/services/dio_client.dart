import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.1.108:8000/api',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ));
  }

  void updateToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void removeToken() {
    dio.options.headers.remove('Authorization');
  }

  Future<String> loginUser(String email, String password) async {
    final response = await dio.post('/login', data: {
      'email': email,
      'password': password,
    });

    final requiresOtp = response.data['requires_otp'] ?? false;
    if (requiresOtp) {
      return response.data['email']; // نرجع الإيميل للتعامل معه في OtpVerification
    } else {
      throw Exception('لم يتم طلب التحقق برمز OTP من الخادم.');
    }
  }


  Future<String> loginWithGoogle({required String email, required String name}) async {
    final response = await dio.post('/google-login', data: {
      'email': email,
      'name': name,
    });
    return response.data['token'];
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String city,
    required String specialization,
    required String role,
    String? profileImagePath,
  }) async {
    final formData = FormData.fromMap({
      'name': name,
      'email': email,
      'password': password,
      'phone_number': phone,
      'city': city,
      'specializations': [specialization],
      'role': role,
      if (profileImagePath != null && profileImagePath.isNotEmpty)
        'profile_image_url': await MultipartFile.fromFile(profileImagePath),
    });

    await dio.post('/register', data: formData);
  }

  Future<void> requestPasswordReset(String email) async {
    await dio.post('/reset-password', data: {
      'email': email,
    });
  }

  Future<void> verifyOtp(String email, String code) async {
    final response = await dio.post('/login/verify-otp', data: {
      'email': email,
      'otp': code,
    });

    if (response.statusCode != 200) {
      throw Exception('OTP verification failed');
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    await dio.post('/reset-password', data: {
      'email': email,
      'password': newPassword,
    });
  }


  Future<void> sendOtpToEmail(String email) async {
    final response = await dio.post('/login/verify-otp', data: {
      'email': email,
    });

    if (response.statusCode != 200) {
      throw Exception('فشل إرسال رمز التحقق إلى البريد');
    }
  }

  Future<void> verifyResetOtp(String email, String code) async {
    final response = await dio.post('/reset-password/verify-otp', data: {
      'email': email,
      'otp': code,
    });

    if (response.statusCode != 200) {
      throw Exception('فشل التحقق من رمز التحقق');
    }
  }
}
