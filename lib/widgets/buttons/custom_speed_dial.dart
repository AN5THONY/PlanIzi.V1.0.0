import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class CustomSpeedDial extends StatelessWidget {
  final List<SpeedDialChild> children; //lista
  final IconData icon;
  final IconData activeIcon;

  const CustomSpeedDial({
    super.key,
    required this.children,
    this.icon = Icons.add_box_outlined,
    this.activeIcon = Icons.close,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: icon,
      activeIcon: activeIcon,
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: AppColors.primary,
      buttonSize: const Size(58, 58),
      curve: Curves.bounceIn,
      overlayColor: AppColors.backgroundback,
      overlayOpacity: 0.8,
      spaceBetweenChildren: 15,
      children: children,
    );
  }
}
