import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/theme/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../controllers/chat_controller.dart';
import '../widgets/chat_card.dart';

class ChatsView extends GetView<ChatController> {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(top: 21.0, bottom: 32.0),
                child: Text(
                  'المحادثات',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),

              // Chat list with Obx for reactivity
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.chats.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.separated(
                    itemCount: controller.chats.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return ChatCard(
                        chat: controller.chats[index],
                        onTap: () => controller
                            .navigateToChatDetail(controller.chats[index]),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'المحادثات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gavel),
            label: 'المحامين',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'قضاياي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
        onTap: (index) {
          if (index == 0) Get.offAllNamed(Routes.HOME);
          if (index == 2) Get.toNamed(Routes.LAWYERS_LISTING);
          if (index == 3) Get.toNamed(Routes.CASES);
          if (index == 4) Get.toNamed(Routes.SETTINGS);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/empty_chats.svg',
            height: 120,
            width: 120,
          ),
          const SizedBox(height: 24),
          const Text(
            'لا توجد محادثات',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'عند بدء محادثة مع محامي، ستظهر هنا',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 14,
              color: Color(0xFF737373),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
