import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legal_app/core/errors/failure.dart';
import 'package:legal_app/core/theme/app_colors.dart';
import 'package:legal_app/core/utils/form_validator.dart';
import 'package:legal_app/core/widgets/custom_button.dart';
import 'package:legal_app/core/widgets/custom_text_field.dart';
import 'dart:io';

// Import extracted widgets
import '../widgets/file_upload_section.dart';
import '../widgets/file_picker_dialog.dart';

class DirectCaseRequest extends StatefulWidget {
  const DirectCaseRequest({super.key});

  @override
  State<DirectCaseRequest> createState() => _DirectCaseRequestState();
}

class _DirectCaseRequestState extends State<DirectCaseRequest> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? _caseType;
  final TextEditingController _plaintiffNameController =
      TextEditingController();
  final TextEditingController _defendantNameController =
      TextEditingController();
  final TextEditingController _caseNumberController = TextEditingController();
  final TextEditingController _caseDescriptionController =
      TextEditingController();

  // Files
  List<File> _selectedFiles = [];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _plaintiffNameController.dispose();
    _defendantNameController.dispose();
    _caseNumberController.dispose();
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
      final failure = FileFailure.uploadFailed();
      _showErrorMessage(failure.message);
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
        backgroundColor: AppColors.error,
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
            const SnackBar(
                content: Text('تم ارسال طلبك الى المحامي بانتظار الموافقة')),
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
            'طلب توكيل جديد',
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

                  const SizedBox(height: 16),

                  // Plaintiff Name
                  CustomTextField(
                    labelText: 'أسم المدعي',
                    hintText: 'أكتب اسم المدعي',
                    controller: _plaintiffNameController,
                    validator: FormValidators.validatePlaintiffName,
                  ),

                  const SizedBox(height: 16),

                  // Defendant Name
                  CustomTextField(
                    labelText: 'أسم المدعي عليه',
                    hintText: 'أكتب اسم المدعي عليه',
                    controller: _defendantNameController,
                    validator: FormValidators.validateDefendantName,
                  ),

                  const SizedBox(height: 16),

                  // Case Number
                  CustomTextField(
                    labelText: 'رقم الدعوى',
                    hintText: 'أكتب رقم الدعوى',
                    controller: _caseNumberController,
                    isMultiline: false,
                    isNumeric: true,
                    validator: (value) => FormValidators.validateNumeric(value),
                  ),

                  const SizedBox(height: 16),

                  // Case Description
                  CustomTextField(
                    labelText: 'وصف القضية',
                    hintText: 'أكتب وصف القضية',
                    controller: _caseDescriptionController,
                    isMultiline: true,
                    validator: FormValidators.validateCaseDescription,
                  ),

                  const SizedBox(height: 32),

                  // Submit Button
                  CustomButton(
                    backgroundColor: AppColors.primary,
                    text: 'ارسال الطلب',
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
