import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String notificationIconPath;

  const NotificationCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.notificationIconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFBFBFBF),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // الوقت على اليسار
              Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF737373),
                  fontFamily: 'Poppins',
                  fontSize: 12,
                ),
              ),
              // العنوان + الأيقونة على اليمين
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 6),
                  SvgPicture.asset(
                    'assets/images/notification.svg',
                    width: 18,
                    height: 18,
                    color: const Color(0xFFC8A45D),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF737373),
              fontFamily: 'Almarai',
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
