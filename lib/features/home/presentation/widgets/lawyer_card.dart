import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/core/theme/app_colors.dart';
import 'package:legal_app/core/utils/app_router.dart';
import '../../domain/entities/lawyer.dart';

class LawyerCard extends StatelessWidget {
  final Lawyer lawyer;
  final VoidCallback? onConsultTap;
  final VoidCallback? onRepresentTap;
  final bool fullWidth;

  const LawyerCard({
    super.key,
    required this.lawyer,
    this.onConsultTap,
    this.onRepresentTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : 280,
      margin: EdgeInsets.only(left: fullWidth ? 0 : 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFBFBFBF),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Top section
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/images/location.svg',
                        width: 14,
                        height: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          lawyer.location,
                          style: const TextStyle(
                            fontFamily: 'Almarai',
                            fontSize: 14,
                            color: Color(0xFF737373),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey[200],
                    child: _buildLawyerImage(),
                  ),
                ),
              ],
            ),
          ),

          // Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: Text(
              lawyer.name,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: Text(
              lawyer.description,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 14,
                color: Color(0xFF737373),
              ),
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(height: 4),

          // Price and Specialization
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${lawyer.price} \$',
                        style: const TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'سعر الاستشارة:',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        lawyer.specialization,
                        style: const TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 12,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'التخصص:',
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Bottom buttons
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: fullWidth
                ? Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            AppRouter.instance
                                .navigateToDirectCaseRequest(context);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF181E3C),
                            backgroundColor: AppColors.primary,
                            side: const BorderSide(color: Color(0xFF181E3C)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: const Size(0, 30),
                          ),
                          child: const Text(
                            'طلب توكيل',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            AppRouter.instance.navigateToConsultationRequest(
                                context,
                                lawyer: lawyer);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: BorderSide(color: AppColors.primary),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            minimumSize: const Size(0, 30),
                          ),
                          child: const Text(
                            'طلب استشارة',
                            style: TextStyle(
                              fontFamily: 'Almarai',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildCompactActionButtons(context),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactActionButtons(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 8,
        children: [
          OutlinedButton(
            onPressed: () {
              AppRouter.instance.navigateToDirectCaseRequest(context);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF181E3C),
              backgroundColor: AppColors.primary,
              side: const BorderSide(color: Color(0xFF181E3C)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(0, 30),
            ),
            child: const Text(
              'طلب توكيل',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              AppRouter.instance
                  .navigateToConsultationRequest(context, lawyer: lawyer);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(color: AppColors.primary),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: const Size(0, 30),
            ),
            child: const Text(
              'طلب استشارة',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLawyerImage() {
    try {
      if (lawyer.imageUrl.endsWith('.svg')) {
        return SvgPicture.asset(
          lawyer.imageUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          placeholderBuilder: (context) => const Icon(
            Icons.person,
            size: 40,
            color: Colors.grey,
          ),
        );
      } else if (lawyer.imageUrl.startsWith('http')) {
        return Image.network(
          lawyer.imageUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 40, color: Colors.grey);
          },
        );
      } else {
        return Image.asset(
          lawyer.imageUrl,
          width: 70,
          height: 70,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 40, color: Colors.grey);
          },
        );
      }
    } catch (e) {
      return const Icon(Icons.person, size: 40, color: Colors.grey);
    }
  }
}
