import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/features/client/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:legal_app/app/features/shared/chat/presentation/controllers/chat_controller.dart';
import 'package:legal_app/app/features/shared/chat/presentation/widgets/chat_card.dart';
import 'package:legal_app/app/shared/widgets/custom_search_text_field.dart';

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
              const SizedBox(height: 25),
              CustomSearchTextField(
                controller: controller.searchController,
                hintText: 'ابحث عن محامي أو عميل...',
                onChanged: controller.filterChats,
                showFilterButton: false,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // ✅ عرض نتائج البحث إذا موجودة
                  if (controller.searchResults.isNotEmpty) {
                    return ListView.separated(
                      itemCount: controller.searchResults.length,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final user = controller.searchResults[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                          leading: CircleAvatar(
                            backgroundImage: user['profileImage'] != ''
                                ? NetworkImage(user['profileImage'])
                                : const AssetImage('assets/images/default_avatar.png')
                            as ImageProvider,
                            radius: 24,
                          ),
                          title: Text(
                            user['name'],
                            style: const TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            user['role'] == 'lawyer' ? 'محامي' : 'عميل',
                            style: const TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                          onTap: () => controller.startChatWithUser(user),
                        );
                      },
                    );
                  }

                  // ✅ عرض المحادثات القديمة
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
                        onTap: () =>
                            controller.navigateToChatDetail(controller.chats[index]),
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
            'عند بدء محادثة مع محامي أو عميل، ستظهر هنا',
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
