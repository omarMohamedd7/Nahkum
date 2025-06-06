import 'package:flutter/material.dart';
import 'package:legal_app/app/core/data/models/case.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:intl/intl.dart';

class CaseCard extends StatelessWidget {
  final Case caseItem;
  final VoidCallback onTap;

  const CaseCard({
    Key? key,
    required this.caseItem,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row - Case Number and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Status Chip
                  _buildStatusChip(caseItem.status),

                  // Case Number
                  Text(
                    'رقم القضية: ${caseItem.caseNumber}',
                    style: const TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Case Title
              Text(
                caseItem.title,
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 8),

              // Case Description
              Text(
                caseItem.description,
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 14,
                  color: Colors.black54,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Footer Row - Case Type and Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Case Type
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEE3CD),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      caseItem.caseType,
                      style: const TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 12,
                        color: Color(0xFFC8A45D),
                      ),
                    ),
                  ),

                  // Creation Date
                  Text(
                    _formatDate(DateTime.now()),
                    style: const TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              // If assigned lawyer exists, show lawyer name
              if (caseItem.lawyerId != null && caseItem.lawyerId!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'المحامي: ${caseItem.lawyerId}',
                        style: const TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color chipColor;
    Color textColor;

    switch (status) {
      case 'بانتظار الموافقة':
        chipColor = const Color(0xFFFFE4B8);
        textColor = const Color(0xFFD18E00);
        break;
      case 'موافق عليه':
        chipColor = const Color(0xFFCEF2DA);
        textColor = const Color(0xFF4CAF50);
        break;
      case 'مغلق':
        chipColor = const Color(0xFFE8E8E8);
        textColor = const Color(0xFF757575);
        break;
      default:
        chipColor = const Color(0xFFE0E0E0);
        textColor = const Color(0xFF757575);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontFamily: 'Almarai',
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }
}
