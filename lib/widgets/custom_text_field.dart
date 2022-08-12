import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final labelText,
      hintText,
      textInputAction,
      maxLength,
      controller,
      keyboardType,
      validator,
      obscureText,
      prefixIcon,
      suffixIcon;
  const CustomTextField({
    Key? key,
    this.labelText,
    this.hintText,
    this.controller,
    this.textInputAction,
    this.keyboardType,
    this.maxLength,
    this.obscureText,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboardType,
      controller: controller,
      maxLength: maxLength,
      textInputAction: textInputAction,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}