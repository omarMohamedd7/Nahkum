import 'package:flutter/material.dart';
import '../../data/models/user_role.dart';

class RoleButton extends StatelessWidget {
  final UserRole role;
  final bool isSelected;
  final VoidCallback onTap;
  final double fontSize;
  final double height;

  const RoleButton({
    Key? key,
    required this.role,
    required this.isSelected,
    required this.onTap,
    required this.fontSize,
    required this.height,
  }) : super(key: key);

  static const Color goldColor = Color(0xFFC8A45D);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? goldColor : Colors.transparent,
          border: isSelected ? null : Border.all(color: goldColor),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          role.getArabicName(),
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontFamily: 'Almarai',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : goldColor,
          ),
        ),
      ),
    );
  }
}
