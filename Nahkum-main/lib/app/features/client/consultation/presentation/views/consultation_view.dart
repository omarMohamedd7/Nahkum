import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_styles.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../controllers/consultation_controller.dart';

class ConsultationView extends GetView<ConsultationController> {
  const ConsultationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: SvgPicture.asset(
              AppAssets.arrowRight,
              color: AppColors.primary,
            ),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'طلب استشارة',
            style: AppStyles.headingMedium,
          ),
          centerTitle: true,
          backgroundColor: AppColors.ScreenBackground,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Obx(() {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        _buildPriceSection(),
                        const SizedBox(height: 24),
                        _buildLawyerCard(),
                        const SizedBox(height: 24),
                        _buildPaymentMethodSection(),
                        const SizedBox(height: 24),
                        _buildCardDetailsForm(),
                        const SizedBox(height: 30),
                        _buildConfirmButton(),
                      ],
                    ),
                  ),
                ),
                // Loading indicator
                if (controller.isLoading.value)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildLawyerCard() {
    return Obx(() {
      final lawyer = controller.selectedLawyer.value;
      if (lawyer == null) return const SizedBox();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFBFBFBF),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for picture and location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // children: [
              //   // Lawyer picture on the left
              //   CircleAvatar(
              //     radius: 30,
              //     backgroundColor: Colors.grey[200],
              //     child: SvgPicture.asset(AppAssets.edit),
              //   ),
              //   const SizedBox(width: 12),
              //
              //   // Location on the right
              //   Row(
              //     children: [
              //       Text(
              //         lawyer.city,
              //         style: const TextStyle(
              //           fontFamily: 'Almarai',
              //           fontSize: 11,
              //           color: Colors.black,
              //         ),
              //       ),
              //       const SizedBox(width: 6),
              //       SvgPicture.asset(
              //         'assets/images/location.svg',
              //         width: 14,
              //         height: 14,
              //         color: const Color(0xFF737373),
              //       ),
              //     ],
              //   ),
              // ],
            ),
            const SizedBox(height: 10),

            // Lawyer name under the picture
            Text(
              lawyer.name,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 4),

            // Lawyer description under the name
            Text(
              lawyer.description,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 11,
                color: Color(0xFF737373),
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPriceSection() {
    return Obx(() {
      final lawyer = controller.selectedLawyer.value;
      if (lawyer == null) return const SizedBox();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0x26C8A45D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Wallet icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFEEE3CD),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                AppAssets.wallet,
                width: 24,
                height: 24,
                color: const Color(0xFFC8A45D),
              ),
            ),
            const SizedBox(width: 16),

            // Price label
            const Text(
              'سعر الاستشارة',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
              textAlign: TextAlign.center,
            ),

            // Spacer to push the price to the far right
            const Spacer(),

            // Price value aligned to the end
            Text(
              '\$${lawyer.price}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/paypal.svg',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 16),
            const Text(
              'الدفع عن طريق بايبال',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFormField(
          label: 'الأسم',
          hintText: 'أدخل أسم حامل البطاقة',
          controller: controller.cardNameController,
        ),
        const SizedBox(height: 16),
        _buildFormField(
          label: 'رقم البطاقة',
          hintText: 'أدخل رقم البطاقة',
          controller: controller.cardNumberController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: 'مدة الصلاحية',
                hintText: 'أدخل تاريخ انتهاء الصلاحية',
                controller: controller.expiryDateController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                label: 'CCV',
                hintText: 'أدخل قيمة التحقق من البطاقة',
                controller: controller.ccvController,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Almarai',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          hintText: hintText,
          keyboardType: keyboardType ?? TextInputType.text,
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return CustomButton(
      onTap: controller.submitRequest,
      text: 'تأكيد الطلب',
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
      width: double.infinity,
    );
  }
}
