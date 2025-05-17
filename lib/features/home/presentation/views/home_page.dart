import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_router.dart';
import '../widgets/lawyer_card.dart';
import '../widgets/service_card.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../../domain/entities/lawyer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy lawyers data
    final List<Lawyer> lawyers = [
      Lawyer(
        id: '1',
        name: 'أسم المحامي',
        location: 'دمشق',
        description:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد',
        price: 20.5,
        imageUrl: 'assets/images/user-profile-image.svg',
        specialization: 'قانون مدني',
      ),
      Lawyer(
        id: '2',
        name: 'أسم المحامي',
        location: 'دمشق',
        description:
            'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد',
        price: 20.5,
        imageUrl: 'https://randomuser.me/api/portraits/men/43.jpg',
        specialization: 'قانون جنائي',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          // Allow the whole page to scroll
          child: Column(
            children: [
              _buildAppBar(),
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
                      iconPath: 'assets/images/case.svg',
                      onTap: () {
                        // Navigate to the publish case page using AppRouter
                        AppRouter.instance.navigateToPublishCase(context);
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildAvailableLawyersTitle(context),
                    const SizedBox(height: 12),
                    _buildLawyersList(lawyers),
                    const SizedBox(height: 24),
                    // Second service card
                    ServiceCard(
                      title: 'طلب توكيل مباشر',
                      description:
                          'استعرض المحامين المتخصصين في مدينتك واختر الأنسب لمتابعة قضيتك.',
                      buttonText: 'عرض',
                      iconPath: 'assets/images/user-profile-image.svg',
                      onTap: () {
                        AppRouter.instance.navigateToLawyersListing(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/images/notification.svg',
            width: 24,
            height: 24,
            color: Colors.grey,
          ),
          Row(
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
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF181E3C).withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'نحكم',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              SvgPicture.asset(
                'assets/images/Logo.svg',
                width: 30,
                height: 30,
                color: const Color(0xFFC8A45D),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
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
    );
  }

  Widget _buildAvailableLawyersTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Navigate to the lawyers listing page
            AppRouter.instance.navigateToLawyersListing(context);
          },
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  // Navigate to the lawyers listing page
                  AppRouter.instance.navigateToLawyersListing(context);
                },
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

  Widget _buildLawyersList(List<Lawyer> lawyers) {
    return SizedBox(
      height: 285,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: lawyers.length,
        reverse: true, // Right to left
        itemBuilder: (context, index) {
          return LawyerCard(
            lawyer: lawyers[index],
            onConsultTap: () {
              // Navigate to consultation request page
              AppRouter.instance.navigateToConsultationRequest(context,
                  lawyer: lawyers[index]);
            },
            onRepresentTap: () {
              // Navigate to attorney request page
              AppRouter.instance.navigateToPublishCase(context);
            },
          );
        },
      ),
    );
  }
}
