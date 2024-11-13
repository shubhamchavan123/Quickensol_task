import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?) validator;
  final Color labelColor;
  final Color hintColor;
  final Color textColor;
  final Color iconColor;
  final Color fillColor;
  final Color borderColor;
  final Color focusedBorderColor;

  CustomPasswordField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.validator,
    required this.labelColor,
    required this.hintColor,
    required this.textColor,
    required this.iconColor,
    required this.fillColor,
    required this.borderColor,
    required this.focusedBorderColor,
  });

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: TextStyle(
        color: widget.textColor,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: widget.labelColor,
          fontSize: 14.0,
        ),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: widget.hintColor,
          fontSize: 14.0,
        ),
        filled: true,
        fillColor: widget.fillColor.withOpacity(0.8),
        prefixIcon: Icon(
          widget.prefixIcon,
          color: widget.iconColor,
          size: 20.0,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: widget.iconColor,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.borderColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.borderColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: widget.focusedBorderColor, width: 2.0),
        ),
      ),
      cursorColor: widget.borderColor,
      cursorWidth: 2.0,
      obscureText: _obscureText,
      validator: widget.validator,
    );
  }
}
