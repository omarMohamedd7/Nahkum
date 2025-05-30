import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/form_validator.dart';
import 'package:legal_app/app/core/theme/app_styles.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';
import '../widgets/terms_checkbox.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({Key? key}) : super(key: key);

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
                  key: controller.registerFormKey,
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

                      // Profile picture section
                      Obx(() => GestureDetector(
                            onTap: controller.showImageSourceDialog,
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
                                image: controller.selectedImage.value != null
                                    ? DecorationImage(
                                        image: FileImage(
                                            controller.selectedImage.value!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: controller.selectedImage.value == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          )),
                      Obx(() {
                        if (controller.selectedImage.value != null) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextButton(
                              onPressed: controller.showImageSourceDialog,
                              child: Text(
                                'تغيير الصورة',
                                style: TextStyle(
                                  color: AppColors.goldDark,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),

                      SizedBox(height: isSmallScreen ? 16 : 24),

                      // Responsive form fields
                      isSmallScreen
                          ? _buildFormFieldsColumn()
                          : _buildFormFieldsGrid(),

                      SizedBox(height: isSmallScreen ? 16 : 24),

                      // Terms and conditions
                      Obx(() => TermsCheckbox(
                            value: controller.acceptTerms.value,
                            onChanged: (value) =>
                                controller.setTermsAcceptance(value ?? false),
                          )),
                      SizedBox(height: isSmallScreen ? 16 : 24),

                      // Register button - responsive width
                      SizedBox(
                        width: isSmallScreen
                            ? double.infinity
                            : screenSize.width * 0.5,
                        child: Obx(() => CustomButton(
                              text: 'إنشاء حساب',
                              onTap: controller.register,
                              isLoading: controller.isLoading.value,
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                            )),
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
          controller: controller.usernameController,
          validator: FormValidators.validateUsername,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أدخل بريد الكتروني فعال',
          labelText: 'البريد الألكتروني',
          iconPath: 'assets/images/email_icon.svg',
          controller: controller.emailRegisterController,
          keyboardType: TextInputType.emailAddress,
          validator: FormValidators.validateEmail,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أدخل رقم الهاتف الخاص بك',
          labelText: 'رقم الهاتف',
          iconPath: 'assets/images/mobile.svg',
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          validator: FormValidators.validatePhone,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أدخل عنوانك الحالي',
          labelText: 'المدينة',
          iconPath: 'assets/images/location.svg',
          controller: controller.cityController,
          validator: FormValidators.validateCity,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أدخل كلمة المرور الخاصة بك',
          labelText: 'كلمة المرور',
          iconPath: 'assets/images/lock_icon.svg',
          controller: controller.passwordRegisterController,
          isPassword: true,
          validator: FormValidators.validatePassword,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          hintText: 'أعد كتابة كلمة المرور للتأكيد',
          labelText: 'كلمة المرور',
          iconPath: 'assets/images/lock_icon.svg',
          controller: controller.confirmPasswordController,
          isPassword: true,
          validator: (value) => FormValidators.validateConfirmPassword(
              value, controller.passwordRegisterController.text),
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
            controller: controller.usernameController,
            validator: FormValidators.validateUsername,
          ),
        ),
        SizedBox(
          width: 300,
          child: CustomTextField(
            hintText: 'أدخل بريد الكتروني فعال',
            labelText: 'البريد الألكتروني',
            iconPath: 'assets/images/email_icon.svg',
            controller: controller.emailRegisterController,
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
            controller: controller.phoneController,
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
            controller: controller.cityController,
            validator: FormValidators.validateCity,
          ),
        ),
        SizedBox(
          width: 300,
          child: CustomTextField(
            hintText: 'أدخل كلمة المرور الخاصة بك',
            labelText: 'كلمة المرور',
            iconPath: 'assets/images/lock_icon.svg',
            controller: controller.passwordRegisterController,
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
            controller: controller.confirmPasswordController,
            isPassword: true,
            validator: (value) => FormValidators.validateConfirmPassword(
                value, controller.passwordRegisterController.text),
          ),
        ),
      ],
    );
  }
}
