import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
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
            fileIcon = const Icon(Icons.audio_file, color: Colors.orange);
            break;
          default:
            fileIcon =
                const Icon(Icons.insert_drive_file, color: AppColors.primary);
        }

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: fileIcon,
            ),
            title: Text(
              fileName,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontSize: 14,
                color: Color(0xFF181E3C),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              extension.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
            trailing: onRemove != null
                ? IconButton(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    onPressed: () => onRemove!(index),
                  )
                : null,
          ),
        );
      },
    );
  }
}
