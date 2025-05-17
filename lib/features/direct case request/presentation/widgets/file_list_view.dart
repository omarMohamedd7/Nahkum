import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_colors.dart';
import 'dart:io';

class FileListView extends StatelessWidget {
  final List<File> selectedFiles;
  final Function(int)? onRemove;

  const FileListView({
    super.key,
    required this.selectedFiles,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: selectedFiles.length,
      itemBuilder: (context, index) {
        final file = selectedFiles[index];
        final String fileName = file.path.split('/').last;
        final String extension = fileName.split('.').last.toLowerCase();

        // Choose icon based on file extension
        Widget fileIcon;

        switch (extension) {
          case 'jpg':
          case 'jpeg':
          case 'png':
            fileIcon = const Icon(Icons.image, color: AppColors.primary);
            break;
          case 'pdf':
            fileIcon = const Icon(Icons.picture_as_pdf, color: Colors.red);
            break;
          case 'doc':
          case 'docx':
            fileIcon = const Icon(Icons.description, color: Colors.blue);
            break;
          case 'mp3':
          case 'wav':
            fileIcon = const Icon(Icons.audio_file, color: AppColors.goldLight);
            break;
          default:
            fileIcon =
                const Icon(Icons.insert_drive_file, color: AppColors.primary);
        }

        return Card(
          elevation: 0,
          color: Colors.grey[100],
          margin: const EdgeInsets.only(bottom: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: fileIcon,
            title: Text(
              fileName,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 14,
                color: AppColors.primary,
              ),
            ),
            trailing: onRemove != null
                ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.red, size: 20),
                    onPressed: () => onRemove!(index),
                  )
                : null,
          ),
        );
      },
    );
  }
}
