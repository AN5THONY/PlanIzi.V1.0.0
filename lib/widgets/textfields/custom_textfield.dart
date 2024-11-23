import 'package:flutter/material.dart';



class CustomTextfield extends StatelessWidget {

  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? icon;
  final String? Function(String?)? validor;


  const CustomTextfield({
    required this.controller,
    required this.labelText,
    this.hintText = "",
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.icon,
    this.validor,
    super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon): null,      
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10.0),
          )
      ),

    );
  }
}