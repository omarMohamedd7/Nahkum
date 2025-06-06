import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/features/client/case_management/data/models/case_offer.dart';
import 'package:legal_app/app/features/client/case_offer/presentation/controllers/case_offer_detail_controller.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';

class CaseOfferDetailView extends GetView<CaseOfferDetailController> {
  const CaseOfferDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: AppColors.primary),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'تفاصيل القضية',
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: 'Almarai',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          final offer = controller.offer.value;
          if (offer == null) {
            return const Center(
              child: Text(
                'لا يوجد بيانات للعرض',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontFamily: 'Almarai',
                  fontSize: 16,
                ),
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Price section with wallet-3.svg
                  _buildPriceSection(offer as CaseOffer),
                  const SizedBox(height: 24),

                  // Case type and number
                  _buildCaseInfoSection(offer as CaseOffer),
                  const SizedBox(height: 16),

                  // Lawyer card
                  _buildLawyerCard(),
                  const SizedBox(height: 24),

                  // Case description
                  _buildCaseDescription(offer as CaseOffer),
                  const SizedBox(height: 24),

                  // Case files section
                  _buildCaseFilesSection(),
                  const SizedBox(height: 24),

                  // Accept button
                  _buildAcceptButton(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPriceSection(CaseOffer offer) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x26C8A45D), // Light gold background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFEEE3CD), // Lighter gold for the circle
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/images/wallet-3.svg',
              width: 24,
              height: 24,
              color: const Color(0xFFC8A45D),
            ),
          ),
          const SizedBox(width: 16),
          const Text(
            'العرض المقدم لك',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const Spacer(),
          Text(
            '\$${offer.price}',
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

  Widget _buildCaseInfoSection(CaseOffer offer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          offer.caseType,
          style: const TextStyle(
            fontFamily: 'Almarai',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'رقم القضية: ${offer.caseNumber}# ',
          style: const TextStyle(
            fontFamily: 'Almarai',
            fontSize: 15,
            color: Color(0xFF767676),
          ),
        ),
      ],
    );
  }

  Widget _buildLawyerCard() {
    return Obx(() {
      final lawyer = controller.lawyer.value;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5FBFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFBFBFBF),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lawyer?.name ?? 'أسم المحامي',
                    style: const TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  if (lawyer?.specialization != null)
                    Text(
                      lawyer!.specialization,
                      style: const TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 12,
                        color: Color(0xFF767676),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(
                  lawyer?.imageUrl ?? 'assets/images/lawyer_profile.png'),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCaseDescription(CaseOffer offer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'وصف القضية',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xFFBFBFBF),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            offer.description,
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 11,
              color: Color(0xFF737373),
              height: 1.4,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildCaseFilesSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0x1AC8A45D),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFBFBFBF),
          width: 1,
          style: BorderStyle.none,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'ملفات القضية',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 14,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'تم رفع أربع صور',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 11,
              color: Color(0xFF777777),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/maximize-4.svg',
                width: 20,
                height: 20,
                color: const Color(0xFFC8A45D),
              ),
              const SizedBox(width: 8),
              const Text(
                'عرض الصور',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 11,
                  color: Color(0xFFC8A45D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAcceptButton() {
    return ElevatedButton(
      onPressed: controller.acceptOffer,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        'الموافقة و الانتقال للمحادثة',
        style: TextStyle(
          fontFamily: 'Almarai',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
