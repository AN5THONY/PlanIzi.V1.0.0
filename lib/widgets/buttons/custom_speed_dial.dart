import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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
      backgroundColor: const Color.fromARGB(255, 1, 165, 165),
      buttonSize: const Size(58, 58),
      curve: Curves.bounceIn,
      overlayColor: const Color.fromARGB(255, 255, 255, 255),
      overlayOpacity: 0.2,
      spaceBetweenChildren: 10,
      children: children,
    );
  }
}
