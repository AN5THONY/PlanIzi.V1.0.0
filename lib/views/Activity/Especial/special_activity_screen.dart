import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/SpecialActivity/a_special.dart';
import 'package:plan_izi_v2/models/special_data.dart';
import 'package:plan_izi_v2/views/Activity/Especial/crea_special_screen.dart';

class SpecialActivityScreen extends StatefulWidget {
  const SpecialActivityScreen({super.key});

  @override
  State<SpecialActivityScreen> createState() => _SpecialActivityScreenState();
}

class _SpecialActivityScreenState extends State<SpecialActivityScreen> {
  // obtener las actividades especiales desde db
  Future<List<Map<String, dynamic>>> _fetchSpecialActivities() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("Usuario no autenticado.");

    final querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("actividades")
        .where("tipo", isEqualTo: "especial") //  filtro actividad
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
            color: AppColors.fourth,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchSpecialActivities(),
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
                          color: AppColors.fourth,
                          size: 50,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Mis actividades Especiales',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Mis actividades especiales',
                      style:
                          TextStyle(fontSize: 16, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 35),
                    // Mostrar si no hay actividades
                    if (activities.isEmpty)
                      const Center(
                        child: Text("No tienes actividades especiales."),
                      ),
                    // Mostrar actividades si existen
                    if (activities.isNotEmpty)
                      ...activities.map((activity) {
                        return SpecialItem(
                          special: SpecialData(
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
                              builder: (context) => const CreaSpecialScreen()),
                        );
                      },
                      child: const Center(
                        child: Text(
                          '+ Agregar otra actividad especial',
                          style: TextStyle(
                            color: AppColors.fourth,
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
