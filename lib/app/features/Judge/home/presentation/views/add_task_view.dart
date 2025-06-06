import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_app/app/core/theme/app_colors.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final textController = TextEditingController();
    final descriptionController = TextEditingController();
    bool notifyBefore = true;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: const Icon(Icons.arrow_back_ios, color: Colors.black),
          title: const Text(
            'إضافة مهمة جديدة',
            style: TextStyle(
              fontFamily: 'Almarai',
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        backgroundColor: const Color(0xFFFAFAFA),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 16),
              _buildLabel('عنوان المهمة'),
              _buildTextField(hint: 'أدخل عنوان المهمة'),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildLabel('تاريخ تنفيذ المهمة'),
                        _buildTextField(hint: 'يوم/شهر/سنة'),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildLabel('وقت بدء المهمة'),
                        Row(
                          children: [
                            Expanded(child: _buildTextField(hint: 'أدخل وقت البدء')),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.inputBorder),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'AM',
                                style: TextStyle(fontFamily: 'Almarai'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildLabel('نوع المهمة'),
              _buildTextField(hint: 'اختر نوع المهمة'),
              const SizedBox(height: 20),
              _buildLabel('وصف إضافي (اختياري)'),
              _buildTextField(hint: 'أدخل وصف المهمة'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'تفعيل إرسال الاشعار قبل الموعد؟',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  StatefulBuilder(
                    builder: (context, setState) {
                      return Switch(
                        value: notifyBefore,
                        activeColor: Colors.green,
                        onChanged: (value) {
                          setState(() => notifyBefore = value);
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'تم',
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Almarai',
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          fontSize: 13,
        ),
        textAlign: TextAlign.right,
      ),
    );
  }

  Widget _buildTextField({String? hint}) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Almarai',
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.inputBorder),
        ),
      ),
      style: const TextStyle(fontFamily: 'Almarai', fontSize: 14),
    );
  }
}
