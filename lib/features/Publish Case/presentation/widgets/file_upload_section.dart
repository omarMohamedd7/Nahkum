import 'package:flutter/material.dart';
import 'dart:io';
import 'file_list_view.dart';

class FileUploadSection extends StatelessWidget {
  final List<File> selectedFiles;
  final VoidCallback onUploadTap;
  final Function(int) onRemoveFile;

  const FileUploadSection({
    super.key,
    required this.selectedFiles,
    required this.onUploadTap,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'المرفقات',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF181E3C),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFBFBFBF)),
          ),
          child: Column(
            children: [
              // Upload button
              InkWell(
                onTap: onUploadTap,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFBFBFBF)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload_file,
                        color: Colors.grey[700],
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'رفع ملف',
                        style: TextStyle(
                          fontFamily: 'Almarai',
                          fontSize: 14,
                          color: Color(0xFF181E3C),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Files list if any
              if (selectedFiles.isNotEmpty) ...[
                const SizedBox(height: 16),
                FileListView(
                  files: selectedFiles,
                  onRemove: onRemoveFile,
                ),
              ]
            ],
          ),
        ),
      ],
    );
  }
}
