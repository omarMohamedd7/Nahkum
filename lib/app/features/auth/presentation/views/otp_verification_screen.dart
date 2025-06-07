import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:legal_app/app/features/auth/presentation/widgets/build_otp.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import 'dart:async';

enum OtpVerificationPurpose {
  login,
  resetPassword,
}

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final OtpVerificationPurpose purpose;

  const OtpVerificationScreen({
    super.key,
    required this.email,
    this.purpose = OtpVerificationPurpose.login,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  int _remainingSeconds = 60;
  Timer? _resendTimer;
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _sendInitialOtp();
    _startResendTimer();
  }

  void _sendInitialOtp() async {
    await _authController.sendOtpToEmail(widget.email);
  }

  @override
  void dispose() {
    _otpControllers.forEach((c) => c.dispose());
    _focusNodes.forEach((f) => f.dispose());
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() {
      _remainingSeconds = 60;
    });
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _resendTimer?.cancel();
        }
      });
    });
  }

  String get _formattedTime {
    int minutes = _remainingSeconds ~/ 60;
    int seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get _getOtpString =>
      _otpControllers.map((c) => c.text).join();

  void _handleResendOtp() async {
    if (_remainingSeconds > 0) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.sendOtpToEmail(widget.email);
      _showMessage('تم إعادة إرسال رمز التحقق إلى بريدك');
      _startResendTimer();
    } catch (e) {
      _showMessage('فشل إعادة إرسال رمز التحقق', isError: true);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleVerifyOtp() async {
    final otp = _getOtpString;
    if (otp.length != 6 || !RegExp(r'^\d{6}$').hasMatch(otp)) {
      _showMessage('يرجى إدخال رمز التحقق كاملاً', isError: true);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.verifyOtp(widget.email, otp);

      if (mounted) {
        _showMessage('تم التحقق بنجاح');
        if (widget.purpose == OtpVerificationPurpose.login) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.toNamed(Routes.RESET_PASSWORD);
        }
      }
    } catch (e) {
      if (mounted) {
        _showMessage('فشل التحقق من الرمز', isError: true);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/images/arrow-right.svg',
                color: AppColors.primary),
            onPressed: () => Get.back(),
          ),
        ],
        backgroundColor: AppColors.ScreenBackground,
        elevation: 0,
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final horizontalPadding = isSmallScreen ? 24.0 : 80.0;
              return SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  20,
                  horizontalPadding,
                  MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'التحقق من الرمز',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: isSmallScreen ? 24 : 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'أدخل رمز التفعيل المكوّن من 6 خانات المُرسل إلى بريدك ${widget.email}',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: isSmallScreen ? 16 : 18,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          6,
                              (index) => OtpTextField(
                            controller: _otpControllers[index],
                            focusNode: _focusNodes[index],
                            nextFocusNode:
                            index < 5 ? _focusNodes[index + 1] : null,
                            previousFocusNode:
                            index > 0 ? _focusNodes[index - 1] : null,
                            index: index,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('لم تتلق الرمز؟',
                              style: TextStyle(
                                  fontFamily: 'Almarai',
                                  fontSize: 16,
                                  color: AppColors.textSecondary)),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed:
                            _remainingSeconds == 0 ? _handleResendOtp : null,
                            child: Text(
                              _remainingSeconds > 0
                                  ? 'إعادة الإرسال خلال $_formattedTime'
                                  : 'إعادة الإرسال',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: _remainingSeconds == 0
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: isSmallScreen
                            ? double.infinity
                            : screenSize.width * 0.5,
                        child: CustomButton(
                          text: 'تأكيد',
                          onTap: _handleVerifyOtp,
                          isLoading: _isLoading,
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
