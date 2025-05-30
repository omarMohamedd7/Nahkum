import 'package:flutter/material.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';

class UserProfileCard extends StatelessWidget {
  final String userName;
  final String userEmail;
  final VoidCallback onTap;

  const UserProfileCard({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          children: [
            // Edit button
            const Icon(
              Icons.edit,
              size: 20,
              color: Color(0xFFC8A45D),
            ),

            // Spacer to push user info and avatar to the right
            const Spacer(),

            // User info (name and email)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            // Avatar with spacing
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFF0F0F0),
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : '',
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC8A45D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
