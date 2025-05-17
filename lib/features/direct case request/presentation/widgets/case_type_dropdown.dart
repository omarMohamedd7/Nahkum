import 'package:flutter/material.dart';
import 'package:legal_app/core/theme/app_colors.dart';

class CaseTypeDropdown extends StatelessWidget {
  final List<String> caseTypes;
  final String? selectedType;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CaseTypeDropdown({
    super.key,
    required this.caseTypes,
    required this.selectedType,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'نوع القضية',
            style: const TextStyle(
              fontFamily: 'Almarai',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        // Dropdown field
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.textSecondary),
          ),
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              hintText: 'أختر نوع القضية',
              hintStyle: TextStyle(
                color: AppColors.textSecondary,
                fontFamily: 'Almarai',
                fontSize: 15,
              ),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            isExpanded: true,
            value: selectedType,
            icon: const Icon(Icons.keyboard_arrow_up, color: AppColors.primary),
            items: caseTypes.map((String type) {
              return DropdownMenuItem<String>(
                value: type,
                child: Text(
                  type,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontFamily: 'Almarai',
                    fontSize: 15,
                    color: AppColors.primary,
                  ),
                ),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
            alignment: AlignmentDirectional.centerEnd,
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
