import 'package:flutter/material.dart';

class CaseTypeDropdown extends StatelessWidget {
  final List<String> caseTypes;
  final String? selectedType;
  final Function(String?) onChanged;
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
        const Text(
          'نوع القضية',
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF181E3C),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            hintText: 'اختر نوع القضية',
            hintStyle: const TextStyle(
              fontFamily: 'Almarai',
              fontSize: 14,
              color: Color(0xFFBFBFBF),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFBFBFBF)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFBFBFBF)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFC8A45D)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          isExpanded: true,
          dropdownColor: Colors.white,
          value: selectedType,
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF181E3C)),
          items: caseTypes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontFamily: 'Almarai',
                  fontSize: 14,
                  color: Color(0xFF181E3C),
                ),
                textAlign: TextAlign.right,
              ),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
