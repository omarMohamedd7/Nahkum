import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/attorney_request_model.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/published_case_model.dart';
import 'package:legal_app/app/features/Lawer/home/data/models/session_model.dart';

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

  // Constructor for session card
  factory CaseCard.fromSessionModel(
    LawyerSessionModel session, {
    required VoidCallback onTap,
  }) {
    return CaseCard(
      caseType: session.caseType,
      clientName: session.clientName,
      caseStatus: session.caseStatus,
      caseNumber: session.caseNumber,
      date: session.date,
      onTap: onTap,
    );
  }

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
    final cardWidth = screenWidth * 0.55;

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
              padding: const EdgeInsets.all(12),
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
                              style: const TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF181E3C),
                              ),
                              textAlign: TextAlign.right,
                            ),

                            const SizedBox(height: 4),

                            // Client name or city
                            Text(
                              isPublishedCase
                                  ? 'المدينة: ${city ?? "غير محدد"}'
                                  : 'اسم الموكل: $clientName',
                              style: const TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 11,
                                color: Color(0xFF181E3C),
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(height: 4),

                            // Case status
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  caseStatus,
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: _getCaseStatusColor(caseStatus),
                                  ),
                                ),
                                const Text(
                                  ' :حالة القضية',
                                  style: TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 11,
                                    color: Color(0xFF181E3C),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 4),

                            // Case number
                            Text(
                              'رقم القضية: $caseNumber',
                              style: const TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 11,
                                color: Color(0xFF181E3C),
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEEE3CD),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/lawyer home/noun-law-7826376 1.svg',
                            width: 24,
                            height: 24,
                            color: AppColors.gold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  const Divider(color: Color(0xFFD8D8D8)),

                  // Description
                  if (description != null) ...[
                    const Text(
                      'جزء من وصف القضية:',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181E3C),
                      ),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description!,
                      style: const TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 11,
                        color: Color(0xFF737373),
                        height: 1.3,
                      ),
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],

                  const SizedBox(height: 8),

                  // Bottom row with details and date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Date
                      if (date != null)
                        Row(
                          children: [
                            Text(
                              date!,
                              style: const TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 11,
                                color: Color(0xFF737373),
                              ),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              'assets/images/lawyer home/calendar.svg',
                              width: 16,
                              height: 16,
                              color: const Color(0xFF181E3C),
                            ),
                          ],
                        ),

                      // Details
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'تفاصيل',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF181E3C),
                            ),
                          ),
                          const SizedBox(width: 4),
                          SvgPicture.asset(
                            'assets/images/arrow-right.svg',
                            width: 16,
                            height: 16,
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
    if (status == 'نشطة' || status == 'منشورة') {
      return const Color(0xFF60A94D); // Green
    } else if (status == 'بانتظار الموافقة') {
      return const Color(0xFFE6A23C); // Orange
    } else if (status == 'مرفوضة') {
      return const Color(0xFFF56C6C); // Red
    }
    return const Color(0xFF181E3C); // Default dark color
  }
}
