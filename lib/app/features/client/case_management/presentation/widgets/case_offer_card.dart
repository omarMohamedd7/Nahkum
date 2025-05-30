import 'package:flutter/material.dart';
import '../../data/models/case_offer.dart';
import '../../../../../core/theme/app_colors.dart';

class CaseOfferCard extends StatelessWidget {
  final CaseOffer offer;
  final VoidCallback onTap;

  const CaseOfferCard({
    Key? key,
    required this.offer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5FBFF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFBFBFBF),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Case type
                Text(
                  offer.caseType,
                  style: const TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),

                // Details button
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(40, 22),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'تفاصيل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Lawyer name
            Text(
              offer.lawyerName,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 15,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),

            // Case number
            Text(
              'رقم القضية: ${offer.caseNumber}# ',
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 15,
                color: Color(0xFF767676),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
