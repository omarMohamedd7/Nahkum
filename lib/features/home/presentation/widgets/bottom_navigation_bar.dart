import 'package:flutter/material.dart';
import '../../../../core/utils/app_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context: context,
            icon: Icons.home,
            label: 'الرئيسية',
            index: 0,
            onTap: () {
              if (currentIndex != 0) {
                AppRouter.instance.replaceWithHome(context);
              }
            },
          ),
          _buildNavItem(
            context: context,
            icon: Icons.chat_bubble_outline,
            label: 'المحادثات',
            index: 1,
          ),
          _buildNavItem(
            context: context,
            icon: Icons.person_outline,
            label: 'المحامين',
            index: 2,
            onTap: () => AppRouter.instance.navigateToLawyersListing(context),
          ),
          _buildNavItem(
            context: context,
            icon: Icons.folder_open_outlined,
            label: 'قضاياي',
            index: 3,
            onTap: () => AppRouter.instance.navigateToCasesPage(context),
          ),
          _buildNavItem(
            context: context,
            icon: Icons.settings,
            label: 'الإعدادات',
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    VoidCallback? onTap,
  }) {
    final selected = index == currentIndex;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24,
            color: selected ? const Color(0xFFC8A45D) : const Color(0xFFB8B8B8),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Almarai',
              fontSize: 12,
              color:
                  selected ? const Color(0xFFC8A45D) : const Color(0xFFB8B8B8),
            ),
          ),
        ],
      ),
    );
  }
}
