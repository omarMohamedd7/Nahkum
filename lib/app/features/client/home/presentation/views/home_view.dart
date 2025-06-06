import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';
import '../controllers/home_controller.dart';
import '../widgets/lawyer_card.dart';
import '../widgets/service_card.dart';
import '../widgets/bottom_navigation_bar.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth < 360 ? 14 : 15;
    final double smallFontSize = screenWidth < 360 ? 12 : 14;
    final double titleFontSize = screenWidth < 360 ? 22 : 24;
    final double padding = screenWidth < 360 ? 12 : 16;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildAppBar(context),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildWelcomeSection(context),
                    SizedBox(height: screenWidth * 0.06), // Responsive spacing
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
                    SizedBox(height: screenWidth * 0.06), // Responsive spacing
                    _buildAvailableLawyersTitle(context),
                    SizedBox(height: screenWidth * 0.03), // Responsive spacing
                    _buildLawyersList(context),
                    SizedBox(height: screenWidth * 0.06), // Responsive spacing
                    // Second service card
                    ServiceCard(
                      title: ' طلب توكيل مباشر',
                      description:
                          'استعرض المحامين المتخصصين في مدينتك واختر الأنسب لمتابعة قضيتك.',
                      buttonText: 'عرض',
                      icon: SvgPicture.asset(
                        AppAssets.folderOpen,
                        color: const Color(0xFFC8A45D),
                      ),
                      onTap: () => controller.navigateToLawyersListing(),
                    ),
                    // Add bottom padding for scroll safety
                    SizedBox(height: screenWidth * 0.04),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        key: const ValueKey('home_view_bottom_nav'),
        currentIndex: 0,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth < 360 ? 13 : 14;
    final double iconSize = screenWidth < 360 ? 22 : 24;
    final double avatarSize = screenWidth < 360 ? 36 : 40;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Get.toNamed('/notifications'),
            child: SvgPicture.asset(
              'assets/images/notification.svg',
              width: iconSize,
              height: iconSize,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed('/profile'),
            child: Row(
              children: [
                Text(
                  'أسم المستخدم',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF181E3C),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                Container(
                  width: avatarSize,
                  height: avatarSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                    color: Colors.grey[200],
                  ),
                  child: Icon(
                    Icons.person,
                    size: iconSize,
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

  Widget _buildWelcomeSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize = screenWidth < 360 ? 22 : 24;
    final double textFontSize = screenWidth < 360 ? 13 : 14;
    final double logoWidth = screenWidth * 0.15;
    final double logoHeight = logoWidth * 1.24;

    return Container(
      width: double.infinity,
      height: screenWidth * 0.42, // Responsive height
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenWidth * 0.05,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF181E3C).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'نحكم',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(height: screenWidth * 0.025),
                Text(
                  'منصتك القانونية الموثوقة لربطك بمحامين مختصين وخدمات عدلية احترافية.',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: textFontSize,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.025),
          SvgPicture.asset(
            AppAssets.mainLogo,
            width: logoWidth,
            height: logoHeight,
            color: AppColors.goldLight,
          ),
        ],
      ),
    );
  }

  Widget _buildAvailableLawyersTitle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize = screenWidth < 360 ? 14 : 15;
    final double linkFontSize = screenWidth < 360 ? 11 : 12;
    final double iconSize = screenWidth < 360 ? 14 : 16;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => controller.navigateToLawyersListing(),
          child: Row(
            children: [
              InkWell(
                onTap: () => controller.navigateToLawyersListing(),
                child: Text(
                  'عرض الكل',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: linkFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Icon(
                Icons.arrow_back,
                size: iconSize,
                color: AppColors.primary,
              ),
            ],
          ),
        ),
        Text(
          'محامون متاحون في مدينتك',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: titleFontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF181E3C),
          ),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget _buildLawyersList(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Reduce the height slightly to prevent pixel overflow
    final cardHeight = screenWidth * 0.68;

    return SizedBox(
      height: cardHeight,
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
          padding: EdgeInsets.zero, // Remove default padding
          clipBehavior:
              Clip.none, // Prevent clipping that could cause layout issues
          physics: const BouncingScrollPhysics(), // Smoother scrolling
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
