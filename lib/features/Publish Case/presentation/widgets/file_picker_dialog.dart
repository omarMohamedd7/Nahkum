import 'package:flutter/material.dart';

enum FileType { image, document, audio }

void showFilePickerDialog(
  BuildContext context, {
  required Function(FileType) onSelectFileType,
}) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'اختر نوع الملف',
                style: TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF181E3C),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOptionItem(
                    context: context,
                    icon: Icons.image,
                    label: 'صورة',
                    onTap: () {
                      Navigator.pop(context);
                      onSelectFileType(FileType.image);
                    },
                  ),
                  _buildOptionItem(
                    context: context,
                    icon: Icons.description,
                    label: 'ملف',
                    onTap: () {
                      Navigator.pop(context);
                      onSelectFileType(FileType.document);
                    },
                  ),
                  _buildOptionItem(
                    context: context,
                    icon: Icons.mic,
                    label: 'صوت',
                    onTap: () {
                      Navigator.pop(context);
                      onSelectFileType(FileType.audio);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildOptionItem({
  required BuildContext context,
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF181E3C).withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF181E3C),
            size: 30,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Almarai',
            fontSize: 14,
            color: Color(0xFF181E3C),
          ),
        ),
      ],
    ),
  );
}
