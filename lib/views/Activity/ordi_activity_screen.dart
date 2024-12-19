import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Firestore para base de datos
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/buttons/radio_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:plan_izi_v2/views/Menu/Casita/home_screen.dart';

class OrdiActivityScreen extends StatefulWidget {
  const OrdiActivityScreen({super.key});

  @override
  State<OrdiActivityScreen> createState() => _OrdiActivityScreenState();
}

class _OrdiActivityScreenState extends State<OrdiActivityScreen> {
  final TextEditingController activityNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController locationFromController = TextEditingController();
  final TextEditingController locationToController = TextEditingController();

  String selectedActivityType = "Actividades anuales";
  TimeOfDay? selectedStartHour;
  TimeOfDay? selectedEndHour;
  DateTime? selectedDate;

  bool is24Hours = false;
  bool isNotify = false;
  bool isRing = false;
  bool isLocation = false;
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

  Future<void> _addActivityToDatabase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("Usuario no autenticado.");
      }

      // Crear un mapa con los datos de la actividad
      final Map<String, dynamic> activityData = {
        'tipoActividad': selectedActivityType,
        'nombreActividad': activityNameController.text,
        "fecha": selectedDate, //guia para mostrar
        'is24Hours': is24Hours,
        'horaInicio': _formatTime24(selectedStartHour),
        'horaFin': _formatTime24(selectedEndHour),
        'comentario': noteController.text,
        'notificar': isNotify,
        'timbar': isRing,
        'ubicacion': isLocation,
        'ubicacionDe': locationFromController.text,
        'ubicacionA': locationToController.text,
        'urgente': isUrgent,
        "tipo": "ordinario",
        "timestamp": FieldValue.serverTimestamp(),
      };

      // guardar los datos
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("actividades")
          .add(activityData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Actividad agregada correctamente")),
        );
        // Limpiar el formulario
      }
      // Redirigir a la pantalla de inicio
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const HomeScreen()), // Asegúrate de que HomeScreen esté importado correctamente
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al agregar actividad: $e")),
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
            color: AppColors.third,
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
                  Icon(Icons.add, color: AppColors.third, size: 50),
                  SizedBox(width: 5),
                  Text(
                    'Agregar actividad',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              RadioButtonGroup(
                title: '¿Qué tipo de actividad tienes?',
                options: const [
                  "Actividad diaria",
                  "actividades mensuales",
                ],
                selectedOption: selectedActivityType,
                onChanged: (value) {
                  setState(() {
                    selectedActivityType = value;
                  });
                },
                SelectColor: AppColors.third,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Seleccione la fecha: ',
                    style:
                        TextStyle(fontSize: 16, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 40),
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
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100),
                      );
                      setState(() {});
                    },
                    child: Text(
                      selectedDate == null
                          ? "Seleccionar"
                          : DateFormat('yyyy-MM-dd').format(selectedDate!),
                    ),
                  )
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
                value: is24Hours,
                onChanged: (value) {
                  setState(() {
                    is24Hours = value;
                  });
                },
                title: const Text('Duración del evento: ¿24 horas?'),
                activeColor: AppColors.third,
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
                              backgroundColor: AppColors.third),
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
                              backgroundColor: AppColors.third),
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
              const SizedBox(height: 30),
              CheckboxListTile(
                title: const Text("Notificar"),
                value: isNotify,
                onChanged: (value) {
                  setState(() {
                    isNotify = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Timbrar"),
                value: isRing,
                onChanged: (value) {
                  setState(() {
                    isRing = value!;
                  });
                },
              ),
              const Text(
                'Gastaras tu carga premium',
                style: TextStyle(fontSize: 15, color: AppColors.textSecondary),
              ),
              CheckboxListTile(
                title: const Text("Ubicación"),
                value: isLocation,
                onChanged: (value) {
                  setState(() {
                    isLocation = value!;
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
                    isUrgent = value!;
                  });
                },
              ),
              PrimaryButton(
                text: 'Agregar Actividad Ordinaria',
                onPressed: _addActivityToDatabase,
                color: AppColors.third,
              )
            ],
          ),
        ),
      ),
    );
  }
}
