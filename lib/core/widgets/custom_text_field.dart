import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final String? iconPath;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final bool isMultiline;
  final bool isNumeric;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.iconPath,
    this.prefixIcon,
    required this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.isMultiline = false,
    this.isNumeric = false,
    this.validator,
    this.contentPadding,
  }) : assert(
            iconPath != null ||
                prefixIcon != null ||
                (iconPath == null && prefixIcon == null),
            'Provide either iconPath or prefixIcon, not both');

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final secondaryColor = AppColors.textSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: const TextStyle(
                fontFamily: 'Almarai',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.primary,
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: secondaryColor),
          ),
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.isPassword ? _obscureText : false,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            maxLines: widget.isMultiline ? null : 1,
            keyboardType: widget.keyboardType ??
                (widget.isMultiline
                    ? TextInputType.multiline
                    : widget.isNumeric
                        ? TextInputType.number
                        : TextInputType.text),
            style: const TextStyle(
              fontFamily: 'Almarai',
              color: AppColors.primary,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: secondaryColor,
                fontFamily: 'Almarai',
                fontSize: 15,
              ),
              prefixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/images/eye_icon.png',
                          colorFilter:
                              ColorFilter.mode(secondaryColor, BlendMode.srcIn),
                        ),
                      ),
                    )
                  : null,
              suffixIcon: widget.iconPath != null
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(
                        widget.iconPath!,
                        colorFilter: ColorFilter.mode(
                            AppColors.primary, BlendMode.srcIn),
                      ),
                    )
                  : widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          color: AppColors.primary,
                        )
                      : null,
              border: InputBorder.none,
              contentPadding: widget.contentPadding ??
                  (widget.isMultiline
                      ? const EdgeInsets.all(16)
                      : const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16)),
            ),
          ),
        ),
      ],
    );
  }
}
