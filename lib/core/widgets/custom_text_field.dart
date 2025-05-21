import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';
import '../utils/app_styles.dart';

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
          'Provide either iconPath or prefixIcon, not both',
        );

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final secondaryColor = const Color(0xFFBFBFBF);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.labelText!,
              style: AppStyles.labelText,
            ),
          ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.white, // 👈 White background
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
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
            style: AppStyles.bodyMedium,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: AppStyles.bodyMedium.copyWith(
                color: secondaryColor,
              ),
              prefixIcon: widget.iconPath != null
                  ? Padding(
                      padding: AppStyles.paddingSmall,
                      child: SvgPicture.asset(
                        widget.iconPath!,
                        color: AppColors.primary,
                      ),
                    )
                  : widget.prefixIcon != null
                      ? Icon(
                          widget.prefixIcon,
                          color: AppColors.primary,
                        )
                      : null,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Padding(
                        padding: AppStyles.paddingSmall,
                        child: _obscureText
                            ? SvgPicture.asset(
                                'assets/images/eye-slash.svg',
                                color: secondaryColor,
                              )
                            : Image.asset(
                                'assets/images/eye_icon.png',
                                color: secondaryColor,
                              ),
                      ),
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: widget.contentPadding ??
                  (widget.isMultiline
                      ? AppStyles.multilineInputFieldContentPadding
                      : AppStyles.inputFieldContentPadding),
            ),
          ),
        ),
      ],
    );
  }
}
