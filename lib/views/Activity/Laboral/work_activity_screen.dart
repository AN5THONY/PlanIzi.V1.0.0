import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plan_izi_v2/models/work_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/Laboral/crea_work_screen.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/theWorking/a_work.dart';

class WorkActivityScreen extends StatefulWidget {
  const WorkActivityScreen({super.key});

  @override
  State<WorkActivityScreen> createState() => _WorkActivityScreenState();
}

class _WorkActivityScreenState extends State<WorkActivityScreen> {
  // obtener las actividades
  Future<List<Map<String, dynamic>>> _fetchWorkActivities() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Usuario no autenticado.");

    final querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("actividades")
        .where("tipo", isEqualTo: "laboral") // filtro por tipo
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
            color: AppColors.fifth,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchWorkActivities(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error al cargar actividades: ${snapshot.error}"),
            );
          }
          final workActivities = snapshot.data ?? [];
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
                          color: AppColors.fifth,
                          size: 50,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Mis actividades laborales',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Mis trabajos o proyectos',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 35),
                    if (workActivities.isEmpty)
                      const Center(
                        child: Text("No tienes actividades laborales."),
                      ),
                    if (workActivities.isNotEmpty)
                      ...workActivities.map((activity) {
                        return TrabajoItem(
                          trabajo: WorkData(
                            nombre: activity["nombreActividad"] ??
                                "Trabajo sin nombre",
                          ),
                          onDelete: () {
                            // logica para eliminar
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
                            builder: (context) => const CreaWorkScreen(),
                          ),
                        );
                      },
                      child: const Center(
                        child: Text(
                          '+ Agregar otro trabajo',
                          style: TextStyle(
                            color: AppColors.fifth,
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
