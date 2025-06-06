import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';
import 'package:legal_app/app/core/utils/app_assets.dart';

class CaseDetailsView extends StatelessWidget {
  const CaseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Row(
                children: const [
                  Spacer(),
                  Text(
                    'تفاصيل القضية',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.arrow_forward_ios,
                      size: 16, color: AppColors.primary),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'قضية أسرية',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.primary,
                ),
              ),
              const Text(
                'رقم القضية: #3345',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'نشطة',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    color: Colors.green,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _infoRow('اسم الموكل', 'طارق الشعار', AppAssets.person),
              const SizedBox(height: 12),
              _infoRow('موعد الجلسة', '8:30 am', AppAssets.activeHome),
              const SizedBox(height: 12),
              _infoRow('تاريخ', '2025/5/12 - الاثنين', AppAssets.activeMessage),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'وصف القضية',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Text(
                  'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة لقد تم توليد هذا النص من مولد النص العربي حيث...',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF8F1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        'ملفات القضية',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'تم رفع ٤ صور',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 13,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'عرض الصور ',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 13,
                          color: AppColors.gold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => _showOfferDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'محادثة مع الموكل',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, String iconAsset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Almarai',
            fontSize: 13,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(iconAsset, width: 18, color: AppColors.gold),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Almarai',
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

void _showOfferDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
                color: const Color(0xFFC8A45D),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'تقديم العرض',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 14,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                Text(
                  'قدم عرضك و وصف لمعالجة القضية',
                  style: TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(21),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('العرض',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'اكتب العرض',
                    hintStyle: const TextStyle(
                        color: Color(0xffBFBFBF),
                        fontSize: 14,
                        fontFamily: 'Almarai'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 16),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Text('وصف المعالجة',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'اكتب وصف لما ستفعله بالقضية',
                    hintStyle: const TextStyle(
                        color: Color(0xffBFBFBF),
                        fontSize: 14,
                        fontFamily: 'Almarai'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('تم',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff181E3C))),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('خروج',
                          style: TextStyle(color: Colors.grey)),
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
