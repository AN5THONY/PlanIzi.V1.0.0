import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/StudientActivity/a_studient.dart';
import 'package:plan_izi_v2/models/studient_data.dart';
import 'package:plan_izi_v2/views/Activity/Estudiantil/crea_studient_screen.dart';

class StudientActivityScreen extends StatefulWidget {
  const StudientActivityScreen({super.key});

  @override
  State<StudientActivityScreen> createState() => _StudientActivityScreenState();
}

class _StudientActivityScreenState extends State<StudientActivityScreen> {
  Future<List<Map<String, dynamic>>> _fetchStudientActivities() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Usuario no autenticado.");

    final querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("actividades")
        .where("tipo", isEqualTo: "estudiantil") // filtrar por tipo
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
            color: AppColors.sixth,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchStudientActivities(),
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
          if (activities.isEmpty) {
            return const Center(
              child: Text("No tienes actividades estudiantiles."),
            );
          }

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
                          color: AppColors.sixth,
                          size: 50,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Mis actividades Estudiantiles',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Mis estudios',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 35),

                    // mostrar actividades obtenidas de la base de datos
                    ...activities.map((activity) {
                      return StudientItem(
                        studient: StudientData(nombre: activity["nombreCurso"]),
                        onDelete: () {
                          // logica para eliminat la actividad
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
                                builder: (context) =>
                                    const CreaStudientScreen()));
                      },
                      child: const Center(
                        child: Text(
                          '+ Agregar otra actividad estudiantil',
                          style: TextStyle(
                            color: AppColors.sixth,
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
