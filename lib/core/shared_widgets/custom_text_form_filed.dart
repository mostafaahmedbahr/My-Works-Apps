
import 'package:flutter/material.dart';

import '../utils/app_colors/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? icon;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final void Function()? onPressed;
  final void Function(String)? onChanged;
  final String? hintText;
  final String? labelText;
  final int? maxLines;
  final double? radius;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintColor;
  final bool? expands;
  final FocusNode? focusNode;

  final Function(String)? onFieldSubmitted;
  const CustomTextFormField({
    super.key,
    this.controller,
    this.obscureText,
    this.icon,
    this.prefixIcon,
    this.prefix,
    this.suffixIcon,
    this.onPressed,
    this.onChanged,
    this.hintText,
    this.labelText,
    this.maxLines,
    this.keyboardType,
    this.validator,
    this.readOnly,
    this.focusNode,
    this.onFieldSubmitted,
    this.expands,
    this.fillColor = AppColors.whiteColor,
    this.borderColor = AppColors.greyColor4,
    this.hintColor = const Color.fromRGBO(150, 150, 150, 1),
    this.radius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      enabled: expands,
      onTap: onPressed,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      controller: controller,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType ?? TextInputType.text,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: AppColors.mainColor),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        prefixIcon: prefixIcon,
        prefix: prefix,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide(color: borderColor ?? AppColors.whiteColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide(color: borderColor ?? AppColors.whiteColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 8),
          borderSide: BorderSide(color: borderColor ?? AppColors.whiteColor),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: hintColor ?? AppColors.blackColor,
        ),
      ),
    );
  }
}
