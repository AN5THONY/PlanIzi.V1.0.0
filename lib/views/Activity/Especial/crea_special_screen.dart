import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class CreaSpecialScreen extends StatefulWidget {
  const CreaSpecialScreen({super.key});

  @override
  State<CreaSpecialScreen> createState() => _CreaSpecialScreenState();
}

class _CreaSpecialScreenState extends State<CreaSpecialScreen> {
  final TextEditingController activityNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController locationFromController = TextEditingController();
  final TextEditingController locationToController = TextEditingController();

  TimeOfDay? selectedStartHour;
  TimeOfDay? selectedEndHour;
  bool is24HourDuration = false;
  bool isNotificationEnabled = false;
  bool isSoundEnabled = false;
  bool isLocationEnabled = false;
  bool isUrgent = false;

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        if (isStartTime) {
          selectedStartHour = pickedTime;
        } else {
          selectedEndHour = pickedTime;
        }
      });
    }
  }

  String _formatTime24(TimeOfDay? time) {
    if (time == null) return "Selecciona...";
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  Future<void> _saveActivity() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("Usuario no autenticado.");
      }

      final Map<String, dynamic> activityData = {
        "nombreActividad": activityNameController.text,
        "duracion24Horas": is24HourDuration,
        "horaInicio": _formatTime24(selectedStartHour),
        "horaFin": _formatTime24(selectedEndHour),
        "comentario": noteController.text,
        "notificar": isNotificationEnabled,
        "timbrar": isSoundEnabled,
        "ubicacionDe": locationFromController.text,
        "ubicacionA": locationToController.text,
        "urgente": isUrgent,
        "tipo": "especial",
        "timestamp": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("actividades")
          .add(activityData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Actividad guardada exitosamente")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al guardar la actividad")),
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
            color: AppColors.fourth,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: const BoxDecoration(color: AppColors.cardBackground),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.add, color: AppColors.fourth, size: 50),
                  SizedBox(width: 5),
                  Text(
                    'Actividad Extraordinaria',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: activityNameController,
                labelText: "Nombre de la actividad",
                hintText: "Agregar actividad",
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                value: is24HourDuration,
                onChanged: (value) {
                  setState(() {
                    is24HourDuration = value;
                  });
                },
                title: const Text('Duración del evento: ¿24 horas?'),
                activeColor: AppColors.fourth,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Comienza a las:",
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectTime(context, true),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.fourth),
                          child: Text(
                            _formatTime24(selectedStartHour),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Termina a las:",
                          style: TextStyle(fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () => _selectTime(context, false),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.fourth),
                          child: Text(
                            _formatTime24(selectedEndHour),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextfield(
                controller: noteController,
                labelText: "Agrega comentario...",
                hintText: "Comentario...",
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text("Notificar"),
                value: isNotificationEnabled,
                onChanged: (value) {
                  setState(() {
                    isNotificationEnabled = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Timbrar"),
                value: isSoundEnabled,
                onChanged: (value) {
                  setState(() {
                    isSoundEnabled = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Ubicación"),
                value: isLocationEnabled,
                onChanged: (value) {
                  setState(() {
                    isLocationEnabled = value ?? false;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextfield(
                      controller: locationFromController,
                      labelText: "De...",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextfield(
                      controller: locationToController,
                      labelText: "A...",
                    ),
                  ),
                ],
              ),
              CheckboxListTile(
                title: const Text("Urgente (sonará hasta que lo desactives)"),
                value: isUrgent,
                onChanged: (value) {
                  setState(() {
                    isUrgent = value ?? false;
                  });
                },
              ),
              Center(
                child: PrimaryButton(
                  text: 'Agregar Actividad Extraordinaria',
                  onPressed: _saveActivity,
                  color: AppColors.fourth,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
