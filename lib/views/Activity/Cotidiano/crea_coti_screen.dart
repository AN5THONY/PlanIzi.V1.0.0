import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreaCotiScreen extends StatefulWidget {
  const CreaCotiScreen({super.key});

  @override
  State<CreaCotiScreen> createState() => _CreaCotiScreenState();
}

class _CreaCotiScreenState extends State<CreaCotiScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  final TextEditingController activityNameController = TextEditingController();
  final TextEditingController locationFromController = TextEditingController();
  final TextEditingController locationToController = TextEditingController();
  final TextEditingController suggestionsController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  bool isHome = false;
  bool isOutside = false;
  bool isNotify = false;
  bool isAlarm = false;
  bool isSuggestions = false;
  List<int> selectedDays = [];  // Cambiado de String a int

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _saveActivity() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      // Verificar si el usuario está autenticado
      if (user == null) {
        throw Exception("Usuario no autenticado.");
      }

      // Crear el objeto de datos de la actividad
      final activityData = {
        "nombreActividad": activityNameController.text,
        "lugarHogar": isHome,
        "lugarAfuera": isOutside,
        "ubicacionDe": locationFromController.text,
        "ubicacionA": locationToController.text,
        "diasSeleccionados": selectedDays, // lista de enteros
        "notificar": isNotify,
        "alarma": isAlarm,
        "sugerencias": isSuggestions,
        "sugerenciasTexto": suggestionsController.text,
        "horaInicio": _selectedTime.format(context),
        "comentario": commentController.text,
        "tipo": "cotidiano",
        "timestamp": FieldValue.serverTimestamp(),
      };

      // Guardar los datos en Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("actividades")
          .add(activityData);

      // Mostrar un mensaje de éxito
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Actividad cotidiana guardada exitosamente")),
        );
      }
    } catch (e) {
      // Mostrar un mensaje de error si algo falla
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Error al guardar la actividad cotidiana")),
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
            color: AppColors.accent,
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
                Icon(Icons.add, color: AppColors.accent, size: 50),
                SizedBox(width: 5),
                Text(
                  'Mis actividades Cotidianas',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomTextfield(
              controller: activityNameController,
              labelText: "Nombre de la actividad",
              hintText: "Cocinar, ir al Gym, Limpiar etc.",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            const Text("Tiene lugar en...", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text("Hogar"),
              value: isHome,
              onChanged: (bool? value) {
                setState(() {
                  isHome = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Afuera"),
              value: isOutside,
              onChanged: (bool? value) {
                setState(() {
                  isOutside = value ?? false;
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    controller: locationFromController,
                    labelText: "De...",
                    hintText: "",
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextfield(
                    controller: locationToController,
                    labelText: "A...",
                    hintText: "",
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Frecuencia...", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"]
                  .map(
                    (day) {
                      int dayNumber = ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"].indexOf(day);
                      return ChoiceChip(
                        label: Text(day),
                        selected: selectedDays.contains(dayNumber),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              selectedDays.add(dayNumber);
                            } else {
                              selectedDays.remove(dayNumber);
                            }
                          });
                        },
                      );
                    },
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text("Necesito que ...", style: TextStyle(fontSize: 16)),
            CheckboxListTile(
              title: const Text("Notifique"),
              value: isNotify,
              onChanged: (bool? value) {
                setState(() {
                  isNotify = value ?? false;
                });
              },
            ),
            CheckboxListTile(
              title: const Text("Alarme"),
              value: isAlarm,
              onChanged: (bool? value) {
                setState(() {
                  isAlarm = value ?? false;
                });
              },
            ),
            const Text('Gastaras tus carga premium',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary)),
            CheckboxListTile(
              title: const Text("Sugerencias"),
              value: isSuggestions,
              onChanged: (bool? value) {
                setState(() {
                  isSuggestions = value ?? false;
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTextfield(
              controller: suggestionsController,
              labelText: "Sugerencias...",
              hintText: "Palabras claves...",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            const Text("Selecciona la hora", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Hora seleccionada: ${_selectedTime.format(context)}",
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent),
                  child: const Text(
                    "Seleccionar hora",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextfield(
              controller: commentController,
              labelText: "Agrega comentario...",
              hintText: "Comentario...",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              text: "Agregar Actividad Cotidiana",
              onPressed: _saveActivity,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}
