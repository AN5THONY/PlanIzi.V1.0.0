import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class ActivityView extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String details;
  final Color backgroundColor;
  final VoidCallback onPostpone;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  const ActivityView({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.details,
    required this.backgroundColor,
    required this.onPostpone,
    required this.onComplete,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Título
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          // Subtítulo
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          // Hora y detalles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,   
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    details,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Column(
                children: [
                  Text(
                    "Sugerencias",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.youtube_searched_for, color: Colors.red),
                      SizedBox(width: 8),
                      Icon(Icons.search, color: Colors.blue),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Botones
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: onPostpone,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text(
                  "Posponer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: onComplete,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text(
                  "Terminado",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: onDelete,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text(
                  "Eliminar actividad",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
        
      ),
    );

  }
}
