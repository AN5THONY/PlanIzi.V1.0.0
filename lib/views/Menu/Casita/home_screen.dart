import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/activity_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/ActivityViews/activity_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:plan_izi_v2/views/Login/estado_usuario.dart';

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
    } else {}
  }

  // obtener las actividades desde Firestore
  Future<List<ActivityData>> _fetchActivitiesFromFirestore() async {
    try {
      // obtener el usuario autenticado
      final estadoUsuario = Provider.of<EstadoUsuario>(context, listen: false);
      final userId = estadoUsuario.user?.uid; // obtener UID del usuario

      if (userId == null) {
        throw Exception("Usuario no autenticado");
      }

      // acceder a la colecciom de actividades del usuario
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('actividades')
          .get();

      // crear una lista de actividades
      List<ActivityData> activityList = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        activityList.add(ActivityData(
          id: doc.id, // Usar el ID
          title: data['nombreActividad'] ?? 'Sin título',
          subtitle: data['comentario'] ?? 'Sin subtítulo',
          time: data['horaInicio'] ?? 'Hora no disponible',
          place: data['ubicacionA'] ?? 'Ubicación no disponible',
          details: data['detalles'] ?? 'Detalles no disponibles',
          isCompleted: data['duracion24Horas'] ?? false,
        ));
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
