import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';


class  PrimaryButton extends StatelessWidget{
  
  final String text; 
  final VoidCallback onPressed;
  
  const PrimaryButton ({
    super.key,
    required this.text,
    required this.onPressed,
    });

  @override

  Widget build(BuildContext context) {
     return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal:40.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        )
      ),
      child: Text( text, style: const TextStyle(fontSize: 18, color: Colors.white),)
      );
  }

}