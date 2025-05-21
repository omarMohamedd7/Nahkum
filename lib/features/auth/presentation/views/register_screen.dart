import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/form_validator.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../widgets/terms_checkbox.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _acceptTerms = false;

  // Image picker instance
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Method to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل في اختيار الصورة: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  // Method to pick image from camera
  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل في التقاط الصورة: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  // Method to show image selection dialog
  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'اختر مصدر الصورة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Almarai',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('معرض الصور'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('الكاميرا'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImageFromCamera();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/arrow-right.svg',
              color: AppColors.primary,
            ),
            onPressed: () => Navigator.of(context).pop(),
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
              final double horizontalPadding = isSmallScreen ? 24.0 : 80.0;
              final double profilePictureWidth = 392;

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
                      // Header section - responsive text sizes
                      Container(
                        width: double.infinity,
                        child: Text(
                          'إنشاء حساب جديد',
                          style: isSmallScreen
                              ? AppStyles.headingLarge
                              : AppStyles.headingLarge.copyWith(fontSize: 30),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        child: Text(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          'للبدء، يرجى تعبئة البيانات التالية',
                          style: AppStyles.captionText.copyWith(
                            fontSize: 18,
                            letterSpacing: -0.5,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      SizedBox(height: isSmallScreen ? 24 : 32),

                      // Profile picture section - now functional
                      GestureDetector(
                        onTap: _showImageSourceDialog,
                        child: Container(
                          width: profilePictureWidth,
                          height: 86,
                          decoration: BoxDecoration(
                            color: AppColors.goldLight.withOpacity(0.1),
                            borderRadius: AppStyles.radiusMedium,
                            border: Border.all(
                              color: AppColors.textSecondary,
                              width: 1,
                            ),
                            image: _selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(_selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _selectedImage == null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/gallery.svg',
                                      height: 24,
                                      width: 24,
                                      color: AppColors.primary,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'أضف صورتك الشخصية',
                                      style: AppStyles.bodySmall,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                              : null,
                        ),
                      ),
                      if (_selectedImage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: TextButton(
                            onPressed: _showImageSourceDialog,
                            child: Text(
                              'تغيير الصورة',
                              style: TextStyle(
                                color: AppColors.goldDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: isSmallScreen ? 16 : 24),

                      // Responsive form fields
                      // Form fields grid layout on larger screens
                      isSmallScreen
                          ? _buildFormFieldsColumn()
                          : _buildFormFieldsGrid(),

                      SizedBox(height: isSmallScreen ? 16 : 24),

                      // Terms and conditions
                      TermsCheckbox(
                        value: _acceptTerms,
                        onChanged: (value) {
                          setState(() {
                            _acceptTerms = value ?? false;
                          });
                        },
                      ),
                      SizedBox(height: isSmallScreen ? 16 : 24),

                      // Register button - responsive width
                      SizedBox(
                        width: isSmallScreen
                            ? double.infinity
                            : screenSize.width * 0.5,
                        child: CustomButton(
                          text: 'إنشاء حساب',
                          onTap: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              if (!_acceptTerms) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'يرجى الموافقة على الشروط والأحكام'),
                                    backgroundColor: AppColors.error,
                                  ),
                                );
                                return;
                              }

                              // Registration logic would go here
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('تم إنشاء الحساب بنجاح'),
                                  backgroundColor: AppColors.success,
                                ),
                              );
                            }
                          },
                          backgroundColor: AppColors.primary,
                          textColor: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
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

  // Form fields in column layout for small screens
  Widget _buildFormFieldsColumn() {
    return Column(
      children: [
        CustomTextField(
          hintText: 'أدخل أسم المستخدم',
          labelText: 'أسم المستخدم',
          iconPath: 'assets/images/user.svg',
          controller: _usernameController,
          validator: FormValidators.validateUsername,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أدخل بريد الكتروني فعال',
          labelText: 'البريد الألكتروني',
          iconPath: 'assets/images/email_icon.svg',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: FormValidators.validateEmail,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أدخل رقم الهاتف الخاص بك',
          labelText: 'رقم الهاتف',
          iconPath: 'assets/images/mobile.svg',
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          validator: FormValidators.validatePhone,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أدخل عنوانك الحالي',
          labelText: 'المدينة',
          iconPath: 'assets/images/location.svg',
          controller: _cityController,
          validator: FormValidators.validateCity,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أدخل كلمة المرور الخاصة بك',
          labelText: 'كلمة المرور',
          iconPath: 'assets/images/lock_icon.svg',
          controller: _passwordController,
          isPassword: true,
          validator: FormValidators.validatePassword,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أعد كتابة كلمة المرور للتأكيد',
          labelText: 'كلمة المرور',
          iconPath: 'assets/images/lock_icon.svg',
          controller: _confirmPasswordController,
          isPassword: true,
          validator: (value) => FormValidators.validateConfirmPassword(
              value, _passwordController.text),
        ),
      ],
    );
  }

  // Form fields in grid layout for larger screens
  Widget _buildFormFieldsGrid() {
    return Wrap(
      runSpacing: 16,
      spacing: 16,
      alignment: WrapAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: CustomTextField(
            hintText: 'أدخل أسم المستخدم',
            labelText: 'أسم المستخدم',
            iconPath: 'assets/images/user.svg',
            controller: _usernameController,
            validator: FormValidators.validateUsername,
          ),
        ),
        SizedBox(
          width: 300,
          child: CustomTextField(
            hintText: 'أدخل بريد الكتروني فعال',
            labelText: 'البريد الألكتروني',
            iconPath: 'assets/images/email_icon.svg',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: FormValidators.validateEmail,
          ),
        ),
        SizedBox(
          width: 300,
          child: CustomTextField(
            hintText: 'أدخل رقم الهاتف الخاص بك',
            labelText: 'رقم الهاتف',
            iconPath: 'assets/images/mobile.svg',
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            validator: FormValidators.validatePhone,
          ),
        ),
        SizedBox(
          width: 300,
          child: CustomTextField(
            hintText: 'أدخل عنوانك الحالي',
            labelText: 'المدينة',
            iconPath: 'assets/images/location.svg',
            controller: _cityController,
            validator: FormValidators.validateCity,
          ),
        ),
        SizedBox(
          width: 300,
          child: CustomTextField(
            hintText: 'أدخل كلمة المرور الخاصة بك',
            labelText: 'كلمة المرور',
            iconPath: 'assets/images/lock_icon.svg',
            controller: _passwordController,
            isPassword: true,
            validator: FormValidators.validatePassword,
          ),
        ),
        SizedBox(
          width: 300,
          child: CustomTextField(
            hintText: 'أعد كتابة كلمة المرور للتأكيد',
            labelText: 'كلمة المرور',
            iconPath: 'assets/images/lock_icon.svg',
            controller: _confirmPasswordController,
            isPassword: true,
            validator: (value) => FormValidators.validateConfirmPassword(
                value, _passwordController.text),
          ),
        ),
      ],
    );
  }
}
