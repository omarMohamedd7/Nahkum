import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/case.dart';

class CaseCard extends StatelessWidget {
  final Case caseItem;
  final VoidCallback onTap;

  const CaseCard({
    super.key,
    required this.caseItem,
    required this.onTap,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case 'بانتظار الموافقة':
        return Colors.orange;
      case 'موافق عليه':
        return AppColors.success;
      case 'مغلق':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 392,
        height: 118,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFBFBFBF),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First Row: Case Type and Status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    caseItem.caseType,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(caseItem.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      caseItem.status,
                      style: TextStyle(
                        color: _getStatusColor(caseItem.status),
                        fontFamily: 'Almarai',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              // Lawyer Name
              const SizedBox(height: 10),
              Text(
                "المحامي: ${caseItem.assignedLawyerId ?? 'غير معين'}",
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontFamily: 'Almarai',
                  fontSize: 14,
                ),
                textAlign: TextAlign.right,
              ),

              // Bottom Row: Case Number and Details Link
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${caseItem.caseNumber} # ',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontFamily: 'Almarai',
                      fontSize: 12,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'عرض التفاصيل',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'Almarai',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
