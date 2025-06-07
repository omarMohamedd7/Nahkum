import 'package:flutter/material.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/client.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/case_item.dart';
import '../../../../../core/theme/app_colors.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  final CaseItem? caseItem;
  final VoidCallback onTap;

  const ClientCard({
    Key? key,
    required this.client,
    this.caseItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double fontSize = screenWidth < 360 ? 13 : 14;
    final double smallFontSize = screenWidth < 360 ? 11 : 12;

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
                    child: client.profileImageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.network(
                              client.profileImageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  color: AppColors.gold,
                                  size: 24,
                                );
                              },
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
                        // Client name
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              client.name,
                              style: TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Almarai',
                                color: const Color(0xFF181E3C),
                              ),
                              textAlign: TextAlign.right,
                            ),
                            const Text(
                              ' :اسم الموكل',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF181E3C),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Case type
                        if (caseItem != null) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                caseItem!.caseType,
                                style: TextStyle(
                                  fontSize: smallFontSize,
                                  fontFamily: 'Almarai',
                                  color: const Color(0xFF181E3C),
                                ),
                              ),
                              const Text(
                                ' :نوع القضية',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Almarai',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF181E3C),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          // Case number
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                caseItem!.caseNumber,
                                style: TextStyle(
                                  fontSize: smallFontSize,
                                  fontFamily: 'Almarai',
                                  color: const Color(0xFF181E3C),
                                ),
                              ),
                              const Text(
                                ' :رقم القضية',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Almarai',
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF181E3C),
                                ),
                              ),
                            ],
                          ),
                        ] else ...[
                          Text(
                            'رقم الهاتف: ${client.phoneNumber}',
                            style: TextStyle(
                              fontSize: smallFontSize,
                              fontFamily: 'Almarai',
                              color: const Color(0xFF737373),
                            ),
                            textAlign: TextAlign.right,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'المدينة: ${client.city}',
                            style: TextStyle(
                              fontSize: smallFontSize,
                              fontFamily: 'Almarai',
                              color: const Color(0xFF737373),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Details button
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
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
                  Icon(
                    Icons.arrow_back_ios,
                    size: 12,
                    color: const Color(0xFF181E3C),
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
