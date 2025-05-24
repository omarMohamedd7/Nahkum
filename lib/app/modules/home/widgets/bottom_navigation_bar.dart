import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/theme/app_colors.dart';
import 'package:legal_app/app/utils/app_assets.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fixed list of nav items to ensure consistent order
    final navItems = [
      _NavItemData(
        activeIcon: AppAssets.activeHome,
        inactiveIcon: AppAssets.unactiveHome,
        fallbackIcon: Icons.home,
        label: 'الرئيسية',
        index: 0,
        onTap: () {
          if (currentIndex != 0) {
            Get.offAllNamed('/home');
          }
        },
      ),
      _NavItemData(
        activeIcon: AppAssets.activeMessage,
        inactiveIcon: AppAssets.unactiveMessage,
        fallbackIcon: Icons.message,
        label: 'المحادثات',
        index: 1,
        onTap: () {
          if (currentIndex != 1) {
            Get.toNamed('/chats');
          }
        },
      ),
      _NavItemData(
        activeIcon: AppAssets.activeJudge,
        inactiveIcon: AppAssets.unactiveJudge,
        fallbackIcon: Icons.gavel,
        label: 'المحامين',
        index: 2,
        onTap: () => Get.toNamed('/lawyers_listing'),
      ),
      _NavItemData(
        activeIcon: AppAssets.activeFolderOpen,
        inactiveIcon: AppAssets.unactiveFolderOpen,
        fallbackIcon: Icons.folder_open,
        label: 'قضاياي',
        index: 3,
        onTap: () => Get.toNamed('/cases'),
      ),
      _NavItemData(
        activeIcon: AppAssets.activeSetting,
        inactiveIcon: AppAssets.unactiveSetting,
        fallbackIcon: Icons.settings,
        label: 'الإعدادات',
        index: 4,
        onTap: () {
          if (currentIndex != 4) {
            Get.toNamed('/settings');
          }
        },
      ),
    ];

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navItems
            .map((item) => _buildNavItem(
                  context: context,
                  data: item,
                  isSelected: currentIndex == item.index,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required _NavItemData data,
    required bool isSelected,
  }) {
    final color = isSelected ? AppColors.primary : const Color(0xFFB8B8B8);

    return InkWell(
      onTap: data.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width / 5, // Ensure equal widths
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isSelected ? data.activeIcon : data.inactiveIcon,
              width: 24,
              height: 24,
              placeholderBuilder: (context) => Icon(
                data.fallbackIcon,
                size: 24,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.label,
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class to store nav item data
class _NavItemData {
  final String activeIcon;
  final String inactiveIcon;
  final IconData fallbackIcon;
  final String label;
  final int index;
  final VoidCallback onTap;

  _NavItemData({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.fallbackIcon,
    required this.label,
    required this.index,
    required this.onTap,
  });
}
