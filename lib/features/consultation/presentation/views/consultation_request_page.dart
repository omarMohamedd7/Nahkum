import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/core/theme/app_colors.dart';
import 'package:legal_app/core/utils/app_assets.dart';
import 'package:legal_app/core/utils/app_router.dart';
import 'package:legal_app/core/widgets/custom_button.dart';
import 'package:legal_app/core/widgets/custom_text_field.dart';
import 'package:legal_app/features/home/domain/entities/lawyer.dart';

class ConsultationRequestPage extends StatefulWidget {
  final Lawyer? lawyer;

  const ConsultationRequestPage({
    super.key,
    this.lawyer,
  });

  @override
  State<ConsultationRequestPage> createState() =>
      _ConsultationRequestPageState();
}

class _ConsultationRequestPageState extends State<ConsultationRequestPage> {
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _ccvController = TextEditingController();

  Lawyer get _lawyer =>
      widget.lawyer ??
      Lawyer(
        id: '1',
        name: 'أسم المحامي',
        location: 'دمشق',
        description:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد',
        price: 20.5,
        imageUrl: 'assets/images/person.svg',
        specialization: 'قانون مدني',
      );

  @override
  void dispose() {
    _cardNameController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _ccvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  _buildPriceSection(),
                  const SizedBox(height: 24),
                  _buildLawyerCard(),
                  const SizedBox(height: 24),
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 24),
                  _buildCardDetailsForm(),
                  const SizedBox(height: 30),
                  _buildConfirmButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_forward,
            color: AppColors.primary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        const Expanded(
          child: Text(
            'طلب استشارة',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Empty container to balance the back button on the left
        Container(width: 48),
      ],
    );
  }

  Widget _buildLawyerCard() {
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
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
        children: [
          // Row for picture and location
          Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceBetween, // Spacing between image and location
            children: [
              // Lawyer picture on the left
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: SvgPicture.asset(AppAssets.edit),
              ),
              const SizedBox(width: 12),

              // Location on the right
              Row(
                children: [
                  Text(
                    _lawyer.location,
                    style: const TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 11,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 6),
                  SvgPicture.asset(
                    'assets/images/location.svg',
                    width: 14,
                    height: 14,
                    color: const Color(0xFF737373),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Lawyer name under the picture
          Text(
            _lawyer.name,
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
            _lawyer.description,
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
  }

  Widget _buildPriceSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x26C8A45D), // rgba(200, 164, 93, 0.15)
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
          const SizedBox(width: 16), // Space between the icon and text

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

          // Price value aligned to the end, no circle around it
          Text(
            '\$${_lawyer.price}',
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
          controller: _cardNameController,
        ),
        const SizedBox(height: 16),
        _buildFormField(
          label: 'رقم البطاقة',
          hintText: 'أدخل رقم البطاقة',
          controller: _cardNumberController,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildFormField(
                label: 'مدة الصلاحية',
                hintText: 'أدخل تاريخ انتهاء الصلاحية',
                controller: _expiryDateController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildFormField(
                label: 'CCV',
                hintText: 'أدخل قيمة التحقق من البطاقة',
                controller: _ccvController,
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

  Widget _buildConfirmButton(BuildContext context) {
    return CustomButton(
      onTap: () {
        // Process payment and navigate to confirmation page
        AppRouter.instance.navigateToHome(context);
      },
      text: 'تأكيد الطلب',
      backgroundColor: AppColors.primary,
      textColor: Colors.white,
      width: double.infinity,
    );
  }
}
