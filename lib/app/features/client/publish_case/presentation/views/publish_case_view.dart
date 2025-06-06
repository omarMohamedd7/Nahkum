import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/features/auth/presentation/views/login_screen.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/form_validator.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../controllers/publish_case_controller.dart';
import '../widgets/case_type_dropdown.dart';
import '../widgets/city_dropdown.dart';
import '../widgets/file_picker_dialog.dart';
import '../widgets/file_upload_section.dart';

class PublishCaseView extends GetView<PublishCaseController> {
  const PublishCaseView({Key? key}) : super(key: key);

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
            onPressed: controller.goBack,
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
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 8),
                      FileUploadSection(
                        selectedFiles: controller.selectedFiles,
                        onUploadTap: () => showFilePickerDialog(
                          context,
                          onSelectFileType: controller.handleFilePickerSelect,
                        ),
                        onRemoveFile: controller.removeFile,
                      ),
                      const SizedBox(height: 24),
                      const CaseTypeDropdown(),
                      const SizedBox(height: 16),
                      const CityDropdown(),
                      const SizedBox(height: 16),
                      CustomTextField(
                        labelText: 'وصف القضية',
                        hintText: 'أكتب وصف القضية',
                        controller: controller.caseDescriptionController,
                        validator: FormValidators.validateCaseDescription,
                        isMultiline: true,
                      ),
                      const SizedBox(height: 32),
                      CustomButton(
                        text: 'نشر القضية',
                        onTap: controller.submitForm,
                        backgroundColor: AppColors.primary,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              return controller.isSubmitting.value
                  ? Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(child: CircularProgressIndicator()),
              )
                  : const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}
