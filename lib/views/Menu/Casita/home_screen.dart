import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/activity_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/ActivityViews/activity_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:plan_izi_v2/views/Login/estado_usuario.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart'; // Importa LoginScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<ActivityData>> activitiesFuture;

  @override
  void initState() {
    super.initState();

    final estadoUsuario = Provider.of<EstadoUsuario>(context, listen: false);

    if (estadoUsuario.isLoggedIn) {
      activitiesFuture = _fetchActivitiesFromFirestore();
    } else {
      // Redirigir al login si el usuario no está autenticado
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  // obtener las actividades desde Firestore
Future<List<ActivityData>> _fetchActivitiesFromFirestore() async {
  try {
    final estadoUsuario = Provider.of<EstadoUsuario>(context, listen: false);
    final userId = estadoUsuario.user?.uid;

    if (userId == null) {
      throw Exception("Usuario no autenticado");
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('actividades')
        .get();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day); // fecha actual sin hora
    final dayOfWeek = now.weekday; // día de la semana actual

    List<ActivityData> activityList = [];
    for (var doc in querySnapshot.docs) {
      final data = doc.data();

      // filtro por tipo y condiciones
      final tipo = data['tipo'] ?? '';

      bool isValid = false;
      String time = 'Hora no disponible'; // Inicializamos time

      if (tipo == "especial" || tipo == "ordinario") {
        final fecha = data['fecha'];
        if (fecha is Timestamp) {
          final fechaDate = fecha.toDate();
          final fechaSinHora = DateTime(fechaDate.year, fechaDate.month, fechaDate.day);
          if (fechaSinHora == today) {
            isValid = true;
          }
        }
      } else if (tipo == "cotidiano" || tipo == "laboral" || tipo == "estudiantil") {
        final diasSeleccionados = data['diasSeleccionados'];
        if (diasSeleccionados != null && diasSeleccionados is List) {
          for (var dia in diasSeleccionados) {
            if (dia is Map && dia.containsKey('dia')) {
              if (dia['dia'] == dayOfWeek) {
                // Aquí se asigna correctamente la hora de inicio
                if (dia.containsKey('horaInicio') && dia['horaInicio'].isNotEmpty) {
                  time = dia['horaInicio']; // Asignamos la hora de inicio
                  isValid = true; // Actividad válida
                }
                break;
              }
            } else if (dia == dayOfWeek) {
              // Si el día es un número simple, asigna la hora general
              if (data.containsKey('horaInicio') && data['horaInicio'].isNotEmpty) {
                time = data['horaInicio']; // Asignamos la hora general
                isValid = true;
              }
              break;
            }
          }
        }
      }

      // Si pasa el filtro, se agrega a la lista
      if (isValid) {
        activityList.add(ActivityData(
          id: doc.id,
          title: data['nombreActividad'] ?? 'Sin título',
          subtitle: data['comentario'] ?? 'Sin subtítulo',
          time: time, // Usamos la hora filtrada
          place: data['ubicacionA'] ?? 'Ubicación desconocida',
          details: data['comentario'] ?? 'Sin detalles',
          isCompleted: data['duracion24Horas'] ?? false,
        ));
      }
    }

    return activityList;
  } catch (e) {
    throw Exception("Error al obtener actividades: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: AppColors.background,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<List<ActivityData>>(
                  future: activitiesFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                            "Error al cargar actividades: ${snapshot.error}"),
                      );
                    }

                    final activities = snapshot.data ?? [];
                    if (activities.isEmpty) {
                      return const Center(
                        child: Text("No tienes actividades."),
                      );
                    }

                    return ListView.builder(
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final activity = activities[index];
                        return ActivityView(
                          activity: activity,
                          onDelete: () {
                            // lógica para eliminar una actividad
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
