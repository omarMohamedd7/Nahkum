import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legal_app/core/theme/app_colors.dart';
import 'package:legal_app/core/widgets/custom_button.dart';
import 'package:legal_app/core/widgets/custom_text_field.dart';
import 'dart:io';

// Import direct case request file upload section
import '../../../direct case request/presentation/widgets/file_upload_section.dart';
import '../../../direct case request/presentation/widgets/file_picker_dialog.dart';
import '../widgets/case_type_dropdown.dart';

class PublishCase extends StatefulWidget {
  const PublishCase({super.key});

  @override
  State<PublishCase> createState() => _PublishCaseState();
}

class _PublishCaseState extends State<PublishCase> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? _caseType;
  final TextEditingController _caseDescriptionController =
      TextEditingController();

  // Files
  List<File> _selectedFiles = [];
  bool _isSubmitting = false;

  // Case types dropdown options
  final List<String> _caseTypes = [
    'جنائي',
    'مدني',
    'تجاري',
    'أحوال شخصية',
    'إداري',
    'عمالي',
  ];

  @override
  void dispose() {
    _caseDescriptionController.dispose();
    super.dispose();
  }

  void _handleFilePickerSelect(FileType fileType) {
    switch (fileType) {
      case FileType.image:
        _pickFiles();
        break;
      case FileType.document:
        _pickDocuments();
        break;
      case FileType.audio:
        _showAudioNotSupportedMessage();
        break;
    }
  }

  Future<void> _pickFiles() async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedFiles.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      _showErrorMessage('فشل في رفع الملف: ${e.toString()}');
    }
  }

  Future<void> _pickDocuments() async {
    // In a real app, you would implement document picking functionality
    // This is a placeholder to demonstrate the UI
    setState(() {
      _selectedFiles.add(File('document.pdf'));
    });
  }

  void _showAudioNotSupportedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('سيتم دعم الملفات الصوتية قريباً')),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      // Simulate form submission
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم نشر القضية بنجاح')),
          );
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.ScreenBackground,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'نشر قضية',
            style: TextStyle(
              color: AppColors.primary,
              fontFamily: 'Almarai',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Document upload section at the top
                  const SizedBox(height: 8),
                  FileUploadSection(
                    selectedFiles: _selectedFiles,
                    onUploadTap: () => showFilePickerDialog(
                      context,
                      onSelectFileType: _handleFilePickerSelect,
                    ),
                    onRemoveFile: _removeFile,
                  ),

                  const SizedBox(height: 24),

                  // Case Type Dropdown
                  CaseTypeDropdown(
                    caseTypes: _caseTypes,
                    selectedType: _caseType,
                    onChanged: (value) => setState(() => _caseType = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى اختيار نوع القضية';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Case Description
                  CustomTextField(
                    labelText: 'وصف القضية',
                    hintText: 'أكتب وصف القضية',
                    controller: _caseDescriptionController,
                    isMultiline: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'يرجى إدخال وصف القضية';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Submit Button
                  CustomButton(
                    backgroundColor: AppColors.primary,
                    text: 'نشر القضية',
                    onTap: _submitForm,
                    isLoading: _isSubmitting,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
