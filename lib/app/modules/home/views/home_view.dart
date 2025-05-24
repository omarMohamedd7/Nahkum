import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/theme/app_colors.dart';
import 'package:legal_app/app/utils/app_assets.dart';
import '../controllers/home_controller.dart';
import '../widgets/lawyer_card.dart';
import '../widgets/service_card.dart';
import '../widgets/bottom_navigation_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildWelcomeSection(),
                    const SizedBox(height: 24),
                    // First service card
                    ServiceCard(
                      title: 'قدم طلب توكيل جديد',
                      description:
                          'املأ تفاصيل قضيتك ليراجعها المحامون المتخصصون في مدينتك ويقدموا عروضهم المناسبة.',
                      buttonText: 'نشر قضية',
                      icon: SvgPicture.asset(
                        AppAssets.document,
                        color: const Color(0xFFC8A45D),
                      ),
                      onTap: () => Get.toNamed(Routes.PUBLISH_CASE),
                    ),
                    const SizedBox(height: 24),
                    _buildAvailableLawyersTitle(),
                    const SizedBox(height: 12),
                    _buildLawyersList(),
                    const SizedBox(height: 24),
                    // Second service card
                    ServiceCard(
                      title: ' طلب توكيل مباشر',
                      description:
                          'استعرض المحامين المتخصصين في مدينتك واختر الأنسب لمتابعة قضيتك.',
                      buttonText: 'عرض',
                      icon: SvgPicture.asset(
                        AppAssets.edit,
                        color: const Color(0xFFC8A45D),
                      ),
                      onTap: () => controller.navigateToLawyersListing(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/notifications'),
            child: SvgPicture.asset(
              'assets/images/notification.svg',
              width: 24,
              height: 24,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/profile'),
            child: Row(
              children: [
                const Text(
                  'أسم المستخدم',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF181E3C),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    color: Colors.grey[200],
                  ),
                  child: Icon(
                    Icons.person,
                    size: 24,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      height: 165,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF181E3C).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'نحكم',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: 10),
                Text(
                  'منصتك القانونية الموثوقة لربطك بمحامين مختصين وخدمات عدلية احترافية.',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 14,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          SvgPicture.asset(
            AppAssets.mainLogo,
            width: 59,
            height: 73,
            color: AppColors.goldLight,
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableLawyersTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => controller.navigateToLawyersListing(),
          child: Row(
            children: [
              InkWell(
                onTap: () => controller.navigateToLawyersListing(),
                child: const Text(
                  'عرض الكل',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_back,
                size: 16,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
        const Text(
          'محامون متاحون في مدينتك',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color(0xFF181E3C),
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _buildLawyersList() {
    return SizedBox(
      height: 285,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.lawyers.isEmpty) {
          return const Center(child: Text('لا يوجد محامين متاحين حالياً'));
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.lawyers.length,
          reverse: true, // Right to left
          itemBuilder: (context, index) {
            return LawyerCard(
              lawyer: controller.lawyers[index],
              onConsultTap: () => controller.navigateToConsultationRequest(
                controller.lawyers[index],
              ),
              onRepresentTap: () => Get.toNamed(Routes.DIRECT_CASE_REQUEST),
            );
          },
        );
      }),
    );
  }
}
