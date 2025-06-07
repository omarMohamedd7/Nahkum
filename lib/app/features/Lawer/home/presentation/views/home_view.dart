import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import '../controllers/home_controller.dart';
import '../widgets/case_card.dart';
import '../widgets/lawyer_bottom_navigation_bar.dart';

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
                    SizedBox(height: screenWidth * 0.06),
                    _buildPowerOfAttorneyRequestsSection(context),
                    SizedBox(height: screenWidth * 0.06),
                    _buildPublishedCasesSection(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: LawyerBottomNavigationBar(
        key: const ValueKey('lawyer_home_view_bottom_nav'),
        currentIndex: 0,
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth < 360 ? 13 : 14;
    final double iconSize = screenWidth < 360 ? 22 : 24;
    final double avatarSize = screenWidth < 360 ? 36 : 40;
    final double circleSize = screenWidth < 360 ? 32 : 36;

    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Get.toNamed('/notifications'),
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/lawyer home/notification.svg',
                      width: iconSize,
                      height: iconSize,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              GestureDetector(
                onTap: () => Get.toNamed('/messages'),
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/lawyer home/message.svg',
                      width: iconSize,
                      height: iconSize,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              GestureDetector(
                onTap: () => Get.toNamed('/settings'),
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/lawyer home/setting-2.svg',
                      width: iconSize,
                      height: iconSize,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // Using a placeholder since the image doesn't exist in the project structure
                    color: Colors.grey,
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
      height: screenWidth * 0.42,
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
            'assets/images/main_logo.svg',
            width: logoWidth,
            height: logoHeight,
            color: AppColors.gold,
          ),
        ],
      ),
    );
  }

  Widget _buildPowerOfAttorneyRequestsSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize = screenWidth < 360 ? 14 : 15;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => controller.navigateToAllAttorneyRequests(),
              child: Text(
                'عرض الكل',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),
            ),
            Text(
              'طلبات توكيل مرسلة أليك',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181E3C),
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildAttorneyRequestCards(context),
      ],
    );
  }

  Widget _buildAttorneyRequestCards(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardHeight = screenWidth < 360 ? 210 : 220;

    return SizedBox(
      height: cardHeight,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.attorneyRequests.isEmpty) {
          return const Center(child: Text('لا يوجد طلبات توكيل حالياً'));
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: controller.attorneyRequests.length,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          itemBuilder: (context, index) {
            final request = controller.attorneyRequests[index];
            return Padding(
              padding: EdgeInsets.only(
                left: index == controller.attorneyRequests.length - 1 ? 0 : 8,
                right: index == 0 ? 0 : 8,
              ),
              child: CaseCard.fromAttorneyRequestModel(
                request,
                onTap: () =>
                    controller.navigateToAttorneyRequestDetails(request),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildPublishedCasesSection(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double titleFontSize = screenWidth < 360 ? 14 : 15;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => controller.navigateToAllPublishedCases(),
              child: Text(
                'عرض الكل',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),
            ),
            Text(
              'قضايا منشورة من اختصاصك',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF181E3C),
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.03),
        _buildPublishedCaseCards(context),
        SizedBox(height: screenWidth * 0.06),
      ],
    );
  }

  Widget _buildPublishedCaseCards(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double cardHeight = screenWidth < 360 ? 210 : 220;

    return SizedBox(
      height: cardHeight,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.publishedCases.isEmpty) {
          return const Center(child: Text('لا يوجد قضايا منشورة حالياً'));
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse: true,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          itemCount: controller.publishedCases.length,
          itemBuilder: (context, index) {
            final caseData = controller.publishedCases[index];
            return Padding(
              padding: EdgeInsets.only(
                left: index == controller.publishedCases.length - 1 ? 0 : 8,
                right: index == 0 ? 0 : 8,
              ),
              child: CaseCard.fromPublishedCaseModel(
                caseData,
                caseNumber: '#${2000 + index}',
                onTap: () =>
                    controller.navigateToPublishedCaseDetails(caseData),
              ),
            );
          },
        );
      }),
    );
  }
}
