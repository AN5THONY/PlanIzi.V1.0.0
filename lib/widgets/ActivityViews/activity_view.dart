import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/activity_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class ActivityView extends StatefulWidget {
  final ActivityData activity;
  final VoidCallback onDelete;

  const ActivityView({
    super.key,
    required this.activity,
    required this.onDelete,
  });

  @override
  _ActivityViewState createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  bool isCompleted = false; // Controla si la actividad está completada
  bool isVisible = true; // Controla si la actividad se muestra
  Color headerColor = AppColors.cardBackground; // Color inicial del encabezado
  Color originalHeaderColor = AppColors.cardBackground; // Guarda el color original

  @override
  void initState() {
    super.initState();
    // Asigna un color inicial según el tipo de actividad (editable)
    headerColor = _getColorForActivity( 'Trabajo' /*widget.activity.time*/);
    originalHeaderColor = headerColor; // Guarda el color original
  }

  // Ejemplo para asignar un color según el tipo de actividad
  Color _getColorForActivity(String activityType) {
    switch (activityType) {
      case 'Ejercicio':
        return AppColors.sixth;
      case 'Estudio':
        return AppColors.third;
      case 'Trabajo':
        return AppColors.fourth;
      case 'Recreación':
        return AppColors.primary;
      default:
        return AppColors.cardBackground; // Color por defecto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible, // Desaparece el widget si `isVisible` es falso
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con color dinámico
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: headerColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Título
                  Text(widget.activity.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none, // Rayar el texto si está completado
                    ),
                  ),
                  const Icon(Icons.push_pin_sharp, color: AppColors.textSecondary),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Descripción
            Text(
              widget.activity.subtitle,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Hora
                Text(
                  "Hora de inicio: ${widget.activity.time}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),
                //Destino
                Text(
                  widget.activity.details,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                // Hora de terminoOpcional
                /*Text(
                  "Hora de termino: ${widget.activity.time}",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textSecondary,
                  ),
                ),*/
                // Lugar
                
                const Icon(Icons.pin_drop_sharp, color: AppColors.textSecondary),
                Text(
                  widget.activity.place, 
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ]
            ),
            const SizedBox(height: 12),

            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón Eliminar
                TextButton(
                  onPressed: () {
                    setState(() {
                      isVisible = false; // Desaparece el widget
                    });
                    widget.onDelete(); // Acción adicional si es necesario
                  },
                  child: const Text(
                    "Eliminar",
                    style: TextStyle(color: AppColors.error, fontSize: 16),
                  ),
                ),
                // Botón Terminado/Deshacer
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (!isCompleted) {
                        // Si no está completada
                        isCompleted = true;
                        headerColor = Colors.greenAccent; // Cambia el color del header
                      } else {
                        // Deshacer la acción
                        isCompleted = false;
                        headerColor = originalHeaderColor; // Restaura el color original
                      }
                    });
                  },
                  child: Text(
                    isCompleted ? "Deshacer" : "Terminado",
                    style: const TextStyle(color: Colors.blue, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
