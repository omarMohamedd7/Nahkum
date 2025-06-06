import 'package:flutter/material.dart';
import '../../data/models/client_model.dart';
import '../../../../../core/theme/app_colors.dart';

class ClientCard extends StatelessWidget {
  final ClientModel client;
  final VoidCallback onTap;

  const ClientCard({
    Key? key,
    required this.client,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth - 48, // Full width minus padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFBFBFBF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Client image (right side in RTL)
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEEE3CD),
                      shape: BoxShape.circle,
                    ),
                    child: client.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              client.imageUrl!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(
                            Icons.person,
                            color: AppColors.gold,
                            size: 24,
                          ),
                  ),

                  const SizedBox(width: 16),

                  // Client details (center)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          client.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Almarai',
                            color: Color(0xFF181E3C),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'نوع القضية: ${client.caseType}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Almarai',
                            color: Color(0xFF737373),
                          ),
                          textAlign: TextAlign.right,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'رقم القضية: ${client.caseNumber}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'Almarai',
                            color: Color(0xFF737373),
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Details button
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'تفاصيل',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Almarai',
                      color: Color(0xFF181E3C),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Transform.rotate(
                    angle: 3.14, // 180 degrees in radians
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 14,
                      color: Color(0xFF181E3C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
