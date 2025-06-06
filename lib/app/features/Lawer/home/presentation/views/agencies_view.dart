import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import 'package:legal_app/app/features/Lawer/home/data/controllers/agencies_controller.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/agency_model.dart';
import 'package:legal_app/app/features/Lawer/home/presentation/widgets/lawyer_bottom_navigation_bar.dart';

class AgenciesView extends GetView<AgenciesController> {
  const AgenciesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 56),
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1, color: const Color(0xffBFBFBF))),
                      child: SvgPicture.asset(
                        height: 20,
                        width: 20,
                        AppAssets.unactiveSetting,
                      )),
                  const SizedBox(width: 11),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1, color: const Color(0xffBFBFBF))),
                      child: SvgPicture.asset(
                        height: 20,
                        width: 20,
                        AppAssets.unactiveMessage,
                      )),
                  const SizedBox(width: 11),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 1, color: const Color(0xffBFBFBF))),
                      child: SvgPicture.asset(
                        height: 20,
                        width: 20,
                        AppAssets.notification,
                      )),
                  const SizedBox(width: 25),
                  const Text(
                    'التوكيلات',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                } else if (controller.errorMessage.value != null) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.errorMessage.value!,
                            style: const TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => controller.fetchAgencies(),
                            child: const Text('إعادة المحاولة'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (controller.agencies.isEmpty) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'لا توجد توكيلات',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 16,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.agencies.length,
                      itemBuilder: (context, index) {
                        return _buildAgencyCard(controller.agencies[index]);
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LawyerBottomNavigationBar(
        currentIndex: 3,
      ),
    );
  }

  Widget _buildAgencyCard(AgencyModel agency) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                AppAssets.document,
                color: AppColors.gold,
                width: 24,
              ),
              Text(
                agency.caseType,
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'اسم الموكل: ${agency.clientName}',
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.right,
          ),
          Text(
            'رقم القضية: ${agency.caseNumber}',
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            "الوصف",
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          const Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'تفاصيل',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_back, size: 16, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
