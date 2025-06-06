import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../controllers/direct_case_request_controller.dart';

class FilePickerDialog extends StatelessWidget {
  final Function(FileType) onSelectFileType;

  const FilePickerDialog({
    Key? key,
    required this.onSelectFileType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'اختر نوع الملف',
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 20),
            _buildOptionTile(
              context,
              icon: Icons.image,
              title: 'صورة',
              fileType: FileType.image,
            ),
            _buildOptionTile(
              context,
              icon: Icons.description,
              title: 'مستند',
              fileType: FileType.document,
            ),
            _buildOptionTile(
              context,
              icon: Icons.audiotrack,
              title: 'ملف صوتي',
              fileType: FileType.audio,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required FileType fileType,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Almarai',
          fontSize: 14,
        ),
      ),
      onTap: () {
        Get.back();
        onSelectFileType(fileType);
      },
    );
  }
}

void showFilePickerDialog(
  BuildContext context, {
  required Function(FileType) onSelectFileType,
}) {
  Get.bottomSheet(
    FilePickerDialog(onSelectFileType: onSelectFileType),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
  );
}
