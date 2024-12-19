import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/activity_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/ActivityViews/activity_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:plan_izi_v2/views/Login/estado_usuario.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart';

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

    // Inicializamos activitiesFuture con un valor predeterminado para evitar el LateInitializationError
    activitiesFuture = Future.value([]);

    if (estadoUsuario.isLoggedIn) {
      // Inicializamos el activitiesFuture después de que el widget haya sido construido
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          activitiesFuture = _fetchActivitiesFromFirestore();
        });
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

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
      final today = DateTime(now.year, now.month, now.day); // fecha actual
      final dayOfWeek = now.weekday; // día

      List<ActivityData> activityList = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();

        // filtro por tipo y condiciones
        final tipo = data['tipo'] ?? '';

        bool isValid = false;
        String time = 'Hora no disponible';

        if (tipo == "especial" || tipo == "ordinario") {
          final fecha = data['fecha'];
          if (fecha is Timestamp) {
            final fechaDate = fecha.toDate();
            final fechaSinHora =
                DateTime(fechaDate.year, fechaDate.month, fechaDate.day);
            if (fechaSinHora == today) {
              isValid = true;
            }
          }
        } else if (tipo == "cotidiano" ||
            tipo == "laboral" ||
            tipo == "estudiantil") {
          final diasSeleccionados = data['diasSeleccionados'];
          if (diasSeleccionados != null && diasSeleccionados is List) {
            for (var dia in diasSeleccionados) {
              if (dia is Map && dia.containsKey('dia')) {
                if (dia['dia'] == dayOfWeek) {
                  if (dia.containsKey('horaInicio') &&
                      dia['horaInicio'].isNotEmpty) {
                    time = dia['horaInicio']; // hora de inicio
                    isValid = true;
                  }
                  break;
                }
              } else if (dia == dayOfWeek) {
                if (data.containsKey('horaInicio') &&
                    data['horaInicio'].isNotEmpty) {
                  time = data['horaInicio']; // hora general
                  isValid = true;
                }
                break;
              }
            }
          }
        }

        // agrega a la lista
        if (isValid) {
          activityList.add(ActivityData(
            id: doc.id,
            title: data['nombreActividad'] ?? 'Sin título',
            subtitle: data['comentario'] ?? 'Sin subtítulo',
            time: time, // hora filtrada
            place: data['ubicacionA'] ?? 'Ubicación desconocida',
            details: data['comentario'] ?? 'Sin detalles',
            isCompleted:
                data.containsKey('isCompleted') ? data['isCompleted'] : false,
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 80),
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: const Text(
                  'Tus actividades de hoy',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
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
