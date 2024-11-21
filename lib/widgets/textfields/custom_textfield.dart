import 'package:flutter/material.dart';


class CustomTextfield extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final bool isPassword;

  const CustomTextfield({
    required this.controller,
    required this.labelText,
    this.isPassword = false,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder()
      ),

    );
  }
}