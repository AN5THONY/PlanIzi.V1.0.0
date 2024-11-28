import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';


class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("CALENDARIO", style: TextStyle( fontSize: 24, color: AppColors.textPrimary, )),
    );
  }
}