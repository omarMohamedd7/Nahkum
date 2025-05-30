import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/routes/app_routes.dart';
import 'package:legal_app/app/features/client/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:legal_app/app/features/shared/chat/presentation/controllers/chat_controller.dart';
import 'package:legal_app/app/features/shared/chat/presentation/widgets/chat_card.dart';

class ChatsView extends GetView<ChatController> {
  const ChatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ScreenBackground,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'المحادثات',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.ScreenBackground,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              SizedBox(
                height: 25,
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
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
