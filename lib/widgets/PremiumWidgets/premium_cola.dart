import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class PremiumCola extends StatelessWidget {
  const PremiumCola({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(Icons.calendar_today, size: 80, color: AppColors.primary),
        SizedBox(height: 20),
        Text(
          'Publicidad',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Publica en nuestro aplicativo, en puntos estrategicos donde nuestro usuario puedan interactuar con ellos.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
