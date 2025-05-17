import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

class FileListView extends StatelessWidget {
  final List<File> files;
  final Function(int) onRemove;

  const FileListView({
    super.key,
    required this.files,
    required this.onRemove,
  });

  String _getFileExtension(String path) {
    return p.extension(path).replaceAll('.', '').toUpperCase();
  }

  String _getFileName(String path) {
    return p.basename(path);
  }

  IconData _getIconByExtension(String extension) {
    switch (extension.toLowerCase()) {
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: files.length,
      itemBuilder: (context, index) {
        final file = files[index];
        final extension = _getFileExtension(file.path);
        final fileName = _getFileName(file.path);

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Icon(
                _getIconByExtension(extension),
                color: const Color(0xFF181E3C),
              ),
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
              extension,
              style: TextStyle(
                fontFamily: 'Almarai',
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete_outline,
                color: Colors.red,
              ),
              onPressed: () => onRemove(index),
            ),
          ),
        );
      },
    );
  }
}
