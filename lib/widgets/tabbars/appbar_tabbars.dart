import 'package:flutter/material.dart';
// ------------------------------------------
class TabBars extends StatelessWidget {
  // Variables
  final IconData icono;

  const TabBars({
    required this.icono,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        icono, 
        size: 45,
        ),
      );
  }
}
