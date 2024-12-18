import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class CreaStudientScreen extends StatefulWidget {
  const CreaStudientScreen({super.key});

  @override
  State<CreaStudientScreen> createState() => _CreaStudientScreenState();
}

class _CreaStudientScreenState extends State<CreaStudientScreen> {
  final TextEditingController nombreCursoController = TextEditingController();
  final TextEditingController lugarController = TextEditingController();

  // estados
  bool isVirtual = false;
  bool isPresencial = false;
  bool isNotificar = false;
  bool isTimbrar = false;
  bool isUrgente = false;

  // horarios
  final List<String> days = ["DOM", "LUN", "MAR", "MIÉ", "JUE", "VIE", "SÁB"];
  List<TimeOfDay?> startTimes = List.filled(7, null);
  List<TimeOfDay?> endTimes = List.filled(7, null);

  // hora
  Future<void> _selectTime(
      BuildContext context, int index, bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startTimes[index] = picked;
        } else {
          endTimes[index] = picked;
        }
      });
    }
  }

  // guardar los datos en bd
  Future<void> addCourseToDatabase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("Usuario no autenticado.");
      }

      final Map<String, dynamic> courseData = {
        "nombreActividad": nombreCursoController.text,
        "esVirtual": isVirtual,
        "esPresencial": isPresencial,
        "lugar": lugarController.text,
        "notificar": isNotificar,
        "timbrar": isTimbrar,
        "urgente": isUrgente,
        "horarios": List.generate(days.length, (index) {
          return {
            "dia": days[index],
            "inicio": startTimes[index]?.format(context) ?? "",
            "fin": endTimes[index]?.format(context) ?? "",
          };
        }),
        "tipo": "estudiantil",
        "timestamp": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("actividades")
          .add(courseData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Curso agregado exitosamente")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al agregar curso: $e")),
        );
      }
    }
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.add, color: AppColors.sixth, size: 50),
                SizedBox(width: 5),
                Text(
                  'Actividad Estudiantil',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomTextfield(
              controller: nombreCursoController,
              labelText: "Nombre del curso",
              hintText: "Inglés, Matemática, Fútbol, etc.",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            // Lugar
            const Text(
              "El curso es ...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text("Virtual"),
              value: isVirtual,
              onChanged: (bool? value) {
                setState(() {
                  isVirtual = value ?? false;
                });
              },
            ),
            CustomTextfield(controller: lugarController, labelText: 'Link ...'),
            CheckboxListTile(
              title: const Text("Presencial"),
              value: isPresencial,
              onChanged: (bool? value) {
                setState(() {
                  isPresencial = value ?? false;
                });
              },
            ),

            // horario de dias
            const SizedBox(height: 20),
            const Text(
              "Los días ...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Column(
              children: List.generate(days.length, (index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(days[index],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () =>
                                  _selectTime(context, index, true),
                              child: Text(startTimes[index]?.format(context) ??
                                  "Comienza"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () =>
                                  _selectTime(context, index, false),
                              child: Text(endTimes[index]?.format(context) ??
                                  "Termina"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }),
            ),

            const SizedBox(height: 20),
            const Text('Necesito que ...'),
            CheckboxListTile(
              title: const Text("Notificar"),
              value: isNotificar,
              onChanged: (value) {
                setState(() {
                  isNotificar = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Timbrar"),
              value: isTimbrar,
              onChanged: (value) {
                setState(() {
                  isTimbrar = value ?? false;
                });
              },
            ),
            const Text('Gastaras tu carga premium',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary)),
            CheckboxListTile(
              title: const Text("Urgente (sonará hasta que lo desactives)"),
              value: isUrgente,
              onChanged: (value) {
                setState(() {
                  isUrgente = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),

            PrimaryButton(
              text: "Agregar curso",
              onPressed: addCourseToDatabase,
              color: AppColors.sixth,
            ),
          ],
        ),
      ),
    );
  }
}
