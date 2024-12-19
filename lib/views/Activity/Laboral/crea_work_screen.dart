import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';
import 'package:plan_izi_v2/widgets/buttons/radio_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CreaWorkScreen extends StatefulWidget {
  const CreaWorkScreen({super.key});

  @override
  State<CreaWorkScreen> createState() => _CreaWorkScreenState();
}

class _CreaWorkScreenState extends State<CreaWorkScreen> {
  final TextEditingController nombreLaboral = TextEditingController();
  String selectedTransporte = "transporte";
  String jornada = 'Por Turnos';
  int duracionSemanal = 40;
  bool notificarChecked = false;
  bool timbrarChecked = false;
  bool urgenteChecked = false;
  final TextEditingController locationFromController = TextEditingController();
  final TextEditingController locationToController = TextEditingController();
  bool transportePublicoChecked = false;
  bool virtualChecked = false;
  final TextEditingController lugarController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();

  final List<TimeOfDay?> startTimes = List.filled(7, null);
  final List<TimeOfDay?> endTimes = List.filled(7, null);

  // dias
  final List<String> days = [
    "Lunes",    // 1
    "Martes",   // 2
    "Miércoles",// 3
    "Jueves",   // 4
    "Viernes",  // 5
    "Sábado",   // 6
    "Domingo",  // 7
  ];

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

  // almacenar los datos en Firestore
  Future<void> addWorkToDatabase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("Usuario no autenticado.");
      }

      final Map<String, dynamic> workData = {
        "nombreActividad": nombreLaboral.text,
        "transporte": selectedTransporte,
        "lugarLink": lugarController.text,
        "ubicacion": {
          "desde": locationFromController.text,
          "hasta": locationToController.text,
        },
        "diasSeleccionados": List.generate(7, (index) {
          return {
            "dia": index + 1,  // giuardar el día como un numero
            "horaInicio": startTimes[index]?.format(context) ?? "",
            "horaFin": endTimes[index]?.format(context) ?? "",
          };
        }),
        "notificar": notificarChecked,
        "timbrar": timbrarChecked,
        "urgente": urgenteChecked,
        "tipo": "laboral",
        "timestamp": FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("actividades")
          .add(workData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Actividad laboral agregada exitosamente")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al agregar actividad laboral: $e")),
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
            color: AppColors.fifth,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          decoration: const BoxDecoration(
            color: AppColors.cardBackground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.add, color: AppColors.fifth, size: 50),
                  SizedBox(width: 5),
                  Text(
                    'Actividad Laboral',
                    style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              CustomTextfield(
                controller: nombreLaboral,
                labelText: "Nombre de la actividad",
                hintText: "",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              const Text("Distribuya sus horas"),
              ...List.generate(7, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      days[index],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text("Comienza"),
                              ElevatedButton(
                                onPressed: () =>
                                    _selectTime(context, index, true),
                                child: Text(
                                  startTimes[index]?.format(context) ?? "--:--",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              const Text("Termina"),
                              ElevatedButton(
                                onPressed: () =>
                                    _selectTime(context, index, false),
                                child: Text(
                                  endTimes[index]?.format(context) ?? "--:--",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              const SizedBox(height: 20),
              RadioButtonGroup(
                title: 'Vas en ...',
                options: const [
                  "Auto",
                  "Transporte Publico",
                ],
                selectedOption: selectedTransporte,
                onChanged: (value) {
                  setState(() {
                    selectedTransporte = value;
                  });
                },
                SelectColor: AppColors.third,
              ),
              const Text("Virtual"),
              const SizedBox(height: 5),
              CustomTextfield(
                  controller: lugarController, labelText: 'Link ...'),
              const SizedBox(height: 20),
              const Text("Tu lugar de labor es..."),
              const SizedBox(height: 5),
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
              const SizedBox(height: 20),
              const Text('Necesito que ...'),
              CheckboxListTile(
                title: const Text("Notificar"),
                value: notificarChecked,
                onChanged: (value) {
                  setState(() {
                    notificarChecked = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text("Timbrar"),
                value: timbrarChecked,
                onChanged: (value) {
                  setState(() {
                    timbrarChecked = value ?? false;
                  });
                },
              ),
              const Text('Gastaras tu carga premium',
                  style:
                      TextStyle(fontSize: 15, color: AppColors.textSecondary)),
              CheckboxListTile(
                title: const Text("Urgente (sonará hasta que lo desactives)"),
                value: urgenteChecked,
                onChanged: (value) {
                  setState(() {
                    urgenteChecked = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: PrimaryButton(
                  text: 'Agregar horario',
                  onPressed: addWorkToDatabase, // llamar a guardar
                  color: AppColors.fifth,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
