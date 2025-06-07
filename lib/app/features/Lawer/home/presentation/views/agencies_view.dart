import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import '../widgets/lawyer_bottom_navigation_bar.dart';
import '../controllers/agencies_controller.dart';
import 'package:legal_app/app/routes/app_routes.dart';

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
              const SizedBox(height: 20),
              // App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                    ],
                  ),
                  const Text(
                    'منشورات التوكيل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Search bar can be added here if needed

              // Agencies List
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                        child:
                            CircularProgressIndicator(color: AppColors.gold));
                  }

                  if (controller.hasError.value) {
                    return Center(
                      child: Text(
                        controller.errorMessage.value,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Mock data for demonstration
                  final agencyItems = [
                    {
                      'caseType': 'قضية أسرية',
                      'city': 'الرياض',
                      'description':
                          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي حيث...',
                    },
                    {
                      'caseType': 'قضية تجارية',
                      'city': 'جدة',
                      'description':
                          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي حيث...',
                    },
                    {
                      'caseType': 'قضية مدنية',
                      'city': 'الدمام',
                      'description':
                          'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربي حيث...',
                    },
                  ];

                  return ListView.builder(
                    itemCount: agencyItems.length,
                    itemBuilder: (context, index) {
                      final item = agencyItems[index];
                      return _buildAgencyCard(
                        caseType: item['caseType'] ?? '',
                        city: item['city'] ?? '',
                        description: item['description'] ?? '',
                        onSubmitOffer: () {
                          // Navigate to submit offer page
                          Get.toNamed(Routes.LAWYER_SUBMIT_OFFER, arguments: {
                            'caseType': item['caseType'],
                            'city': item['city'],
                          });
                        },
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const LawyerBottomNavigationBar(
        currentIndex: 3,
      ),
    );
  }

  Widget _buildAgencyCard({
    required String caseType,
    required String city,
    required String description,
    required VoidCallback onSubmitOffer,
  }) {
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
          // Case Type with Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFEEE3CD),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.document,
                    color: AppColors.gold,
                    width: 20,
                    height: 20,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    caseType,
                    style: const TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'المدينة: $city',
                    style: const TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 13,
                      color: Color(0xFF737373),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFEEEEEE)),
          const SizedBox(height: 12),

          // Description
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF737373),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),

          const SizedBox(height: 16),

          // Submit Offer Button (Centered)
          Center(
            child: ElevatedButton(
              onPressed: onSubmitOffer,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gold,
                foregroundColor: Colors.white,
                minimumSize: const Size(160, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'تقديم عرض',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
