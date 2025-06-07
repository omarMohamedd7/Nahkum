import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/features/shared/onboarding/data/models/user_role.dart';
import 'package:legal_app/app/shared/widgets/custom_text_field.dart';
import 'package:legal_app/app/shared/widgets/custom_button.dart';
import 'package:legal_app/app/core/theme/app_styles.dart';
import 'package:legal_app/app/core/utils/form_validator.dart';
import '../widgets/terms_checkbox.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    // Get user role from arguments
    final Map<String, dynamic> args = Get.arguments ?? {};
    final UserRole? userRole = args['role'];

    // Debug print to check if role is being received
    print('Register Screen - Received role: ${userRole?.toString() ?? "null"}');

    // Get role from controller if not in arguments, only default to client if both are null
    final effectiveRole =
        userRole ?? controller.userRole.value ?? UserRole.client;

    // Update controller's user role
    if (controller.userRole.value != effectiveRole) {
      controller.userRole.value = effectiveRole;
      print(
          'Register Screen - Updated controller role to: ${effectiveRole.toString()}');
    }

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
                          'إنشاء حساب جديد ${effectiveRole.getArabicName()}',
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

                      // Show profile picture section for client and lawyer roles
                      if (effectiveRole != UserRole.judge)
                        _buildProfilePictureSection(profilePictureWidth),

                      SizedBox(height: isSmallScreen ? 16 : 24),

                      // Responsive form fields
                      isSmallScreen
                          ? _buildFormFieldsColumn(effectiveRole)
                          : _buildFormFieldsGrid(effectiveRole),

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

  Widget _buildProfilePictureSection(double width) {
    return Column(
      children: [
        Obx(() => GestureDetector(
          onTap: controller.showImageSourceDialog,
          child: Container(
            width: width,
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
                image: FileImage(controller.selectedImage.value!),
                fit: BoxFit.cover,
              )
                  : null,
            ),
            child: controller.selectedImage.value == null
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
      ],
    );
  }

  // Form fields in column layout for small screens
  Widget _buildFormFieldsColumn(UserRole userRole) {
    // Debug print to check role in form builder
    print('Building column form fields for role: ${userRole.toString()}');

    return Column(
      children: [
        // Common fields for all roles
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

        // Fields for client and lawyer roles
        if (userRole == UserRole.client || userRole == UserRole.lawyer) ...[
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
        ],

        // Lawyer-specific fields
        if (userRole == UserRole.lawyer) ...[
          CustomTextField(
            hintText: 'أدخل تخصصك القانوني',
            labelText: 'التخصص',
            iconPath: 'assets/images/briefcase.svg',
            controller: controller.specializationController,
            validator: (value) =>
                value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hintText: 'أدخل رسوم الاستشارة',
            labelText: 'رسوم الاستشارة',
            iconPath: 'assets/images/money.svg',
            controller: controller.consultationFeeController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
          ),
          const SizedBox(height: 16),
        ],

        // Judge-specific fields
        if (userRole == UserRole.judge) ...[
          CustomTextField(
            hintText: 'أدخل تخصصك القضائي',
            labelText: 'التخصص',
            iconPath: 'assets/images/unactive navbar/folder-open.svg',
            controller: controller.judgeSpecializationController,
            validator: (value) =>
                value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            hintText: 'أدخل اسم المحكمة',
            labelText: 'اسم المحكمة',
            iconPath: 'assets/images/unactive navbar/judge.svg',
            controller: controller.courtNameController,
            validator: (value) =>
                value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
          ),
          const SizedBox(height: 16),
        ],

        // Password fields for all roles
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
          labelText: 'تأكيد كلمة المرور',
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
  Widget _buildFormFieldsGrid(UserRole userRole) {
    // Debug print to check role in form builder
    print('Building grid form fields for role: ${userRole.toString()}');

    return Wrap(
      runSpacing: 16,
      spacing: 16,
      alignment: WrapAlignment.center,
      children: [
        // Common fields for all roles
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

        // Fields for client and lawyer roles
        if (userRole == UserRole.client || userRole == UserRole.lawyer) ...[
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
        ],

        // Lawyer-specific fields
        if (userRole == UserRole.lawyer) ...[
          SizedBox(
            width: 300,
            child: CustomTextField(
              hintText: 'أدخل تخصصك القانوني',
              labelText: 'التخصص',
              iconPath: 'assets/images/briefcase.svg',
              controller: controller.specializationController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
          ),
          SizedBox(
            width: 300,
            child: CustomTextField(
              hintText: 'أدخل رسوم الاستشارة',
              labelText: 'رسوم الاستشارة',
              iconPath: 'assets/images/money.svg',
              controller: controller.consultationFeeController,
              keyboardType: TextInputType.number,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
          ),
        ],

        // Judge-specific fields
        if (userRole == UserRole.judge) ...[
          SizedBox(
            width: 300,
            child: CustomTextField(
              hintText: 'أدخل تخصصك القضائي',
              labelText: 'التخصص',
              iconPath: 'assets/images/unactive navbar/folder-open.svg',
              controller: controller.judgeSpecializationController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
          ),
          SizedBox(
            width: 300,
            child: CustomTextField(
              hintText: 'أدخل اسم المحكمة',
              labelText: 'اسم المحكمة',
              iconPath: 'assets/images/unactive navbar/judge.svg',
              controller: controller.courtNameController,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'هذا الحقل مطلوب' : null,
            ),
          ),
        ],

        // Password fields for all roles
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
            labelText: 'تأكيد كلمة المرور',
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
