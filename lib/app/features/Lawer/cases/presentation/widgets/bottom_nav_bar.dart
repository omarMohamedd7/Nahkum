import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A121212),
            blurRadius: 36.0,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.note_add_outlined,
                label: 'طلباتي',
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.menu_book_outlined,
                label: 'التوكيلات',
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.people_outline,
                label: 'الموكلين',
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.gavel,
                label: 'قضايا',
                index: 3,
                isActive: true,
              ),
              _buildNavItem(
                icon: Icons.home_outlined,
                label: 'الرئيسية',
                index: 4,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: 183,
            height: 7,
            decoration: BoxDecoration(
              color: const Color(0xFF121212),
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: () {
        if (index != currentIndex) {
          switch (index) {
            case 0:
              // Requests route - needs to be created or use an existing one
              Get.toNamed(Routes.DIRECT_CASE_REQUEST);
              break;
            case 1:
              // Authorizations route - needs to be created or use an existing one
              Get.toNamed(Routes.Agencies_View);
              break;
            case 2:
              // Clients route - needs to be created or use an existing one
              Get.toNamed(Routes.PROFILE);
              break;
            case 3:
              // Cases route
              Get.toNamed(Routes.LAWYER_CASES);
              break;
            case 4:
              // Home route
              Get.toNamed(Routes.LAWYER_HOME);
              break;
          }
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFFC8A45D) : const Color(0xFFB8B8B8),
            size: 24,
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color:
                  isActive ? const Color(0xFFC8A45D) : const Color(0xFFB8B8B8),
              fontSize: 12,
              fontFamily: 'Almarai',
            ),
          ),
        ],
      ),
    );
  }
}
