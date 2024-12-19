import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';
import 'package:intl/intl.dart';
import 'package:plan_izi_v2/views/Menu/main_menu.dart';
import 'package:intl/date_symbol_data_local.dart';

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
  DateTime? selectedDate;
  TimeOfDay? selectedStartHour;
  TimeOfDay? selectedEndHour;
  bool is24HourDuration = false;
  bool isNotificationEnabled = false;
  bool isSoundEnabled = false;
  bool isLocationEnabled = false;
  bool isUrgent = false;

  @override
  void initState() {
    super.initState();
    // Inicializar la localización en español
    initializeDateFormatting('es_ES', null);
  }

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

      // Ajustar la fecha para la zona horaria local
      if (selectedDate != null) {
        selectedDate = selectedDate?.add(const Duration(hours: 6)); // Ajusta según tu zona horaria
      }

      // Obtener el número del día (1 = lunes, 7 = domingo)
      int dayNumber = selectedDate?.weekday ?? 0; // Esto da el número del día

      final Map<String, dynamic> activityData = {
        "nombreActividad": activityNameController.text,
        "fecha": selectedDate, // Aquí ya está ajustada
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
        "dia": dayNumber,  // Guardar el número del día (1-7)
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
      // Redirigir a la pantalla de inicio
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainMenu()),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      iconColor: AppColors.primary,
                      surfaceTintColor: Colors.black,
                      foregroundColor: AppColors.third,
                      disabledIconColor: AppColors.third,
                      elevation: 5,
                      shadowColor: const Color.fromARGB(255, 83, 83, 83),
                    ),
                    onPressed: () async {
                      selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2080),
                      );
                      setState(() {});
                    },
                    child: Text(
                      selectedDate == null
                          ? "Seleccionar fecha"
                          : DateFormat('yyyy-MM-dd').format(selectedDate!),
                    ),
                  ),
                  const SizedBox(width: 40),
                  selectedDate == null
                      ? const Text(
                          '',
                          style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                        )
                      : Text(
                          'Día: ${DateFormat('EEEE', 'es_ES').format(selectedDate!)}', // Ahora en español
                          style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
                        ),
                ],
              ),
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
                  text: 'Agregar Actividad Extraordi',
                  onPressed: _saveActivity,
                  color: AppColors.fourth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
