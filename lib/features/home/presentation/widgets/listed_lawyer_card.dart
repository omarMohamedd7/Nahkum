import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/core/theme/app_colors.dart';
import 'package:legal_app/core/utils/app_router.dart';
import '../../domain/entities/lawyer.dart';

class ListedLawyerCard extends StatelessWidget {
  final Lawyer lawyer;
  final VoidCallback? onConsultTap;
  final VoidCallback? onRepresentTap;

  const ListedLawyerCard({
    super.key,
    required this.lawyer,
    this.onConsultTap,
    this.onRepresentTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 420,
      height: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFBFBFBF),
          width: 1,
        ),
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerRight, // Pin to right side
                child: Container(
                  width: 350, // Fixed width content block
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top section: Name, Location, Avatar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name + Location info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  lawyer.name,
                                  style: const TextStyle(
                                    fontFamily: 'Almarai',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      lawyer.location,
                                      style: const TextStyle(
                                        fontFamily: 'Almarai',
                                        fontSize: 14,
                                        color: Color(0xFF737373),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    SvgPicture.asset(
                                      'assets/images/location.svg',
                                      width: 14,
                                      height: 14,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 16),

                          // Avatar on far right
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[200],
                            child: _buildLawyerImage(),
                          ),
                        ],
                      ),

                      // Description aligned right
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
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

                      // Price and Specialization aligned right
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            textAlign: TextAlign.right,
                            text: TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Almarai',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                              children: [
                                const TextSpan(text: 'سعر الاستشارة: '),
                                TextSpan(
                                  text: '\$${lawyer.price}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
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

                      // Bottom buttons centered
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                AppRouter.instance
                                    .navigateToConsultationRequest(context,
                                        lawyer: lawyer);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide(color: AppColors.primary),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                minimumSize: const Size(0, 32),
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
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () {
                                AppRouter.instance
                                    .navigateToPublishCase(context);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF181E3C),
                                backgroundColor: AppColors.primary,
                                side:
                                    const BorderSide(color: Color(0xFF181E3C)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                minimumSize: const Size(0, 32),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLawyerImage() {
    try {
      if (lawyer.imageUrl.endsWith('.svg')) {
        return SvgPicture.asset(
          lawyer.imageUrl,
          width: 60,
          height: 60,
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
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.person, size: 40, color: Colors.grey);
          },
        );
      } else {
        return Image.asset(
          lawyer.imageUrl,
          width: 60,
          height: 60,
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
