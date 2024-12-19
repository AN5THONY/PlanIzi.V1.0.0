import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/activity_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:plan_izi_v2/views/Login/estado_usuario.dart';

class ActivityView extends StatefulWidget {
  final ActivityData activity;
  final VoidCallback onDelete;

  const ActivityView({
    super.key,
    required this.activity,
    required this.onDelete,
  });

  @override
  ActivityViewState createState() => ActivityViewState();
}

class ActivityViewState extends State<ActivityView> {
  bool isCompleted = false; 
  bool isVisible = true; 
  Color headerColor = AppColors.cardBackground;
  Color originalHeaderColor =
      AppColors.cardBackground; 

  @override
  void initState() {
    super.initState();
    isCompleted = widget.activity.isCompleted;

    headerColor = _getColorForActivity('Recreación' /*widget.activity.time*/);
    originalHeaderColor = headerColor;
  }


  Future<void> _updateActivityCompletion(bool completionStatus) async {
    try {
      final userId =
          Provider.of<EstadoUsuario>(context, listen: false).user?.uid;
      if (userId == null) throw Exception("Usuario no autenticado");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('actividades')
          .doc(widget.activity.id)
          .update({'isCompleted': completionStatus});
    } catch (e) {
      //
    }
  }

  Color _getColorForActivity(String activityType) {
    switch (activityType) {
      case 'Ejercicio':
        return AppColors.sixth;
      case 'Estudio':
        return AppColors.third;
      case 'Trabajo':
        return AppColors.fourth;
      case 'Recreación':
        return const Color.fromARGB(255, 101, 168, 168);
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
                  Text(
                    widget.activity.title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 0, 0, 0),
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration
                              .none,
                              decorationThickness: isCompleted ? 4.5 : 0.0, // Rayar el texto si está completado
                    ),
                  ),
                  const Icon(Icons.push_pin_sharp,
                      color: Color.fromARGB(255, 0, 0, 0)),
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
              ],
            ),
            
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Icon(Icons.pin_drop_sharp, color: AppColors.textSecondary),
              Text(
                widget.activity.place,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ]),
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
                  onPressed: () async {
                    setState(() {
                      if (!isCompleted) {
                        // Si no está completada
                        isCompleted = true;
                        //headerColor = const Color.fromARGB(
                            //255, 245, 141, 141); // Cambia el color del header
                      } else {
                        // Deshacer la acción
                        isCompleted = false;
                        headerColor =
                            originalHeaderColor; // Restaura el color original
                      }
                    });
                    await _updateActivityCompletion(
                        isCompleted); // Actualiza en la BD
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
