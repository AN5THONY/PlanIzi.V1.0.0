import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plan_izi_v2/models/daily_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/Cotidiano/crea_coti_screen.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/dailyActivity/a_daily.dart';

class DailyActivityScreen extends StatefulWidget {
  const DailyActivityScreen({super.key});

  @override
  State<DailyActivityScreen> createState() => _DailyActivityScreenState();
}

class _DailyActivityScreenState extends State<DailyActivityScreen> {
  // Método para obtener las actividades desde Firestore
  Future<List<Map<String, dynamic>>> _fetchDailyActivities() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Usuario no autenticado.");

    final querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("actividades")
        .where("tipo", isEqualTo: "cotidiano") // tipo de actividad
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'PlanIzi',
          style: TextStyle(
            fontSize: 50,
            color: AppColors.accent,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchDailyActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error al cargar actividades: ${snapshot.error}"),
            );
          }

          final activities = snapshot.data ?? [];
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              decoration: const BoxDecoration(color: AppColors.cardBackground),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColors.accent,
                          size: 50,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Mis actividades Cotidianas',
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Mis actividades',
                      style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 35),
                    // Mostrar si no hay actividades
                    if (activities.isEmpty)
                      const Center(
                        child: Text("No tienes actividades cotidianas."),
                      ),
                    // Mostrar actividades si existen
                    if (activities.isNotEmpty)
                      ...activities.map((activity) {
                        return DailyItem(
                          activity: DailyData(
                              nombre: activity["nombreActividad"] ??
                                  "Actividad sin nombre"),
                          onDelete: () {
                            // Lógica para eliminar la actividad
                          },
                        );
                      }),
                    const SizedBox(height: 30),
                    const Center(child: EspacioPublicidad()),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreaCotiScreen()),
                        );
                      },
                      child: const Center(
                        child: Text(
                          '+ Agregar otra actividad cotidiana',
                          style: TextStyle(
                            color: AppColors.accent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
