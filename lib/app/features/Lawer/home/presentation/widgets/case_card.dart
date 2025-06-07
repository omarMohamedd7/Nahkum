import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/attorney_request_model.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/published_case_model.dart';
import 'package:legal_app/app/routes/app_routes.dart';

class CaseCard extends StatelessWidget {
  final String caseType;
  final String clientName;
  final String caseStatus;
  final String caseNumber;
  final String? description;
  final String? date;
  final String? city;
  final bool isAttorneyRequest;
  final bool isPublishedCase;
  final VoidCallback onTap;

  const CaseCard({
    Key? key,
    required this.caseType,
    required this.clientName,
    required this.caseStatus,
    required this.caseNumber,
    this.description,
    this.date,
    this.city,
    this.isAttorneyRequest = false,
    this.isPublishedCase = false,
    required this.onTap,
  }) : super(key: key);

  // Constructor for attorney request card
  factory CaseCard.fromAttorneyRequestModel(
    AttorneyRequestModel request, {
    required VoidCallback onTap,
  }) {
    return CaseCard(
      caseType: request.caseType,
      clientName: request.clientName,
      caseStatus: request.caseStatus,
      caseNumber: request.caseNumber,
      description: request.description,
      isAttorneyRequest: true,
      onTap: onTap,
    );
  }

  // Constructor for published case card
  factory CaseCard.fromPublishedCaseModel(
    PublishedCaseModel publishedCase, {
    required VoidCallback onTap,
    required String caseNumber,
  }) {
    return CaseCard(
      caseType: publishedCase.caseType,
      clientName: publishedCase.clientName,
      caseStatus: 'منشورة',
      caseNumber: caseNumber,
      description: publishedCase.description,
      city: publishedCase.city,
      isPublishedCase: true,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Make card width responsive and slightly smaller to prevent overflow
    final cardWidth =
        screenWidth < 360 ? screenWidth * 0.68 : screenWidth * 0.53;
    final double fontSize = screenWidth < 360 ? 12 : 14;
    final double smallFontSize = screenWidth < 360 ? 9 : 10;
    final double iconSize = screenWidth < 360 ? 18 : 22;
    final double containerPadding = screenWidth < 360 ? 6 : 10;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFBFBFBF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(containerPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Top row with icon and case type
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Case type
                            Text(
                              caseType,
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF181E3C),
                              ),
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: screenWidth < 360 ? 2 : 4),

                            // Client name or city
                            Text(
                              isPublishedCase
                                  ? 'المدينة: ${city ?? "غير محدد"}'
                                  : 'اسم الموكل: $clientName',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: smallFontSize,
                                color: const Color(0xFF181E3C),
                              ),
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: screenWidth < 360 ? 2 : 4),

                            // Case status
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  caseStatus,
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: smallFontSize,
                                    fontWeight: FontWeight.bold,
                                    color: _getCaseStatusColor(caseStatus),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  ' :حالة القضية',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: smallFontSize,
                                    color: const Color(0xFF181E3C),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: screenWidth < 360 ? 2 : 4),

                            // Case number
                            Text(
                              'رقم القضية: $caseNumber',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: smallFontSize,
                                color: const Color(0xFF181E3C),
                              ),
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: screenWidth < 360 ? 28 : 34,
                        height: screenWidth < 360 ? 28 : 34,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEEE3CD),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/lawyer home/noun-law-7826376 1.svg',
                            width: screenWidth < 360 ? 16 : 20,
                            height: screenWidth < 360 ? 16 : 20,
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenWidth < 360 ? 3 : 6),
                  const Divider(color: Color(0xFFD8D8D8), height: 1),
                  SizedBox(height: screenWidth < 360 ? 3 : 6),

                  // Description
                  if (description != null) ...[
                    Text(
                      'جزء من وصف القضية:',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: smallFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF181E3C),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    SizedBox(height: screenWidth < 360 ? 2 : 3),
                    Text(
                      description!,
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: smallFontSize,
                        color: const Color(0xFF737373),
                        height: 1.2,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  SizedBox(height: screenWidth < 360 ? 3 : 6),

                  // Bottom section - either date + details or submit offer button
                  if (isPublishedCase)
                    // Submit Offer Button (Centered)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to submit offer page
                          Get.toNamed(Routes.LAWYER_SUBMIT_OFFER, arguments: {
                            'caseType': caseType,
                            'city': city ?? '',
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.gold,
                          foregroundColor: Colors.white,
                          minimumSize: Size(screenWidth < 360 ? 120 : 140,
                              screenWidth < 360 ? 32 : 36),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'تقديم عرض',
                          style: TextStyle(
                            fontFamily: 'Almarai',
                            fontSize: screenWidth < 360 ? 12 : 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else
                    // Bottom row with details and date for attorney requests
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Date
                        if (date != null)
                          Row(
                            children: [
                              Text(
                                date!,
                                style: TextStyle(
                                  fontFamily: 'Almarai',
                                  fontSize: smallFontSize,
                                  color: const Color(0xFF737373),
                                ),
                              ),
                              const SizedBox(width: 4),
                              SvgPicture.asset(
                                'assets/images/lawyer home/calendar.svg',
                                width: screenWidth < 360 ? 12 : 14,
                                height: screenWidth < 360 ? 12 : 14,
                                color: const Color(0xFF181E3C),
                              ),
                            ],
                          ),

                        // Details
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'تفاصيل',
                              style: TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: smallFontSize,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF181E3C),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Icon(
                              Icons.arrow_back_ios,
                              size: screenWidth < 360 ? 10 : 12,
                              color: const Color(0xFF181E3C),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCaseStatusColor(String status) {
    switch (status) {
      case 'مقبولة':
        return Colors.green;
      case 'مرفوضة':
        return Colors.red;
      case 'معلقة':
        return Colors.orange;
      case 'منشورة':
        return Colors.blue;
      case 'بانتظار الموافقة':
        return const Color(0xFFE6A23C); // Orange
      default:
        return const Color(0xFF181E3C);
    }
  }
}
