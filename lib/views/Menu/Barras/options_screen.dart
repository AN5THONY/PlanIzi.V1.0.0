import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';


class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("OPCIONES DEL USUARIO", style: TextStyle( fontSize: 24, color: AppColors.textPrimary, )),
    );
  }
}