import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final int maxLength;
  final String? Function(String?) validator;
  final Color labelColor;
  final Color hintColor;
  final Color textColor;
  final Color iconColor;
  final Color fillColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final VoidCallback onSuffixIconPressed;

  CustomTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    this.obscureText = false,
    this.maxLength = 50,
    required this.labelColor,
    required this.hintColor,
    required this.textColor,
    required this.iconColor,
    required this.fillColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.onSuffixIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: textColor,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: labelColor,
          fontSize: 14.0,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor,
          fontSize: 14.0,
        ),
        filled: true,
        fillColor: fillColor.withOpacity(0.8),
        prefixIcon: Icon(
          prefixIcon,
          color: iconColor,
          size: 20.0,
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.clear, color: iconColor),
          onPressed: onSuffixIconPressed,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: focusedBorderColor, width: 2.0),
        ),
      ),
      cursorColor: borderColor,
      cursorWidth: 2.0,
      obscureText: obscureText,
      maxLength: maxLength,
      validator: validator,
    );
  }
}
