import 'package:flutter/material.dart';
import 'package:legal_app/app/features/client/case_management/data/models/case.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/features/client/case_management/presentation/widgets/lawyer_info_card.dart';
import 'package:legal_app/app/features/client/case_management/presentation/widgets/case_file_section.dart';

class CaseDetailsPage extends StatelessWidget {
  final Case caseItem;

  const CaseDetailsPage({
    super.key,
    required this.caseItem,
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
    final bool isApproved = caseItem.status == 'موافق عليه';
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.ScreenBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'تفاصيل القضية',
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: 'Almarai',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Chat activation section at the top
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC8A45D).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.lightbulb_outline,
                              color: Color(0xFFC8A45D),
                              size: 20,
                            ),
                          ),
                          Positioned(
                            top: -2,
                            right: -2,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFFC8A45D),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'سيتم تفعيل زر المحادثة عند قبول المحامي لطلب التوكيل.',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontFamily: 'Almarai',
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // 2. Row: case type (right), case status (left)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Case type and number
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          caseItem.caseType,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontFamily: 'Almarai',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'رقم القضية: ${caseItem.caseNumber}# ',
                          style: const TextStyle(
                            color: Color(0xFF767676),
                            fontFamily: 'Almarai',
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    // Status chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFC8A45D).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        caseItem.status,
                        style: const TextStyle(
                          color: Color(0xFFC8A45D),
                          fontFamily: 'Almarai',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 3. Lawyer card
                SizedBox(
                  width: 392,
                  height: 74,
                  child: LawyerInfoCard(
                    lawyerName: caseItem.assignedLawyerId ?? 'غير معين',
                    lawyerImageUrl: 'assets/images/lawyer_profile.png',
                    customHeight: 74,
                  ),
                ),
                const SizedBox(height: 24),
                // 4. Case documents
                const CaseFileSection(
                  title: 'ملفات القضية',
                  fileCount: 'تم رفع أربع صور',
                ),
                const SizedBox(height: 24),
                // 5. Case description
                Text(
                  caseItem.description,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontFamily: 'Almarai',
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 24),
                // 6. Chat button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isApproved
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: isApproved
                        ? () {
                            // Navigate to chat page
                          }
                        : null,
                    style: TextButton.styleFrom(
                      foregroundColor: isApproved
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                    ),
                    child: const Text(
                      'محادثة',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
