import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/special_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class SpecialItem extends StatelessWidget {
  final SpecialData special;
  final VoidCallback onDelete;

  const SpecialItem({super.key, required this.special, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              special.nombre,
              style: const TextStyle(fontSize: 16, color: AppColors.backgroundback),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: AppColors.background),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
