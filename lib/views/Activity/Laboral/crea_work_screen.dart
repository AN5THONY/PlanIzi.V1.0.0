import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class CreaWorkScreen extends StatefulWidget {
  const CreaWorkScreen({super.key});

  @override
  State<CreaWorkScreen> createState() => _CreaWorkScreenState();
}

class _CreaWorkScreenState extends State<CreaWorkScreen> {
  String jornada = 'Por Turnos';
  int duracionSemanal = 40;
  bool autoChecked = true;
  final TextEditingController locationFromController = TextEditingController();
  final TextEditingController locationToController = TextEditingController();
  bool transportePublicoChecked = false;
  bool virtualChecked = false;
  final TextEditingController lugarController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();


  final List<TimeOfDay?> startTimes = List.filled(7, null);
  final List<TimeOfDay?> endTimes = List.filled(7, null);

  
  final List<String> days = [
    "Lunes",
    "Martes",
    "Miércoles",
    "Jueves",
    "Viernes",
    "Sábado",
    "Domingo",
  ];

  Future<void> _selectTime(BuildContext context, int index, bool isStart) async {
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
              const SizedBox(height: 20),
              const Text("Distribuyan sus horas"),

             
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
                                onPressed: () => _selectTime(context, index, true),
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
                                onPressed: () => _selectTime(context, index, false),
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
              const Text("Vas..."),
              Row(
                children: [
                  Checkbox(
                    value: autoChecked,
                    onChanged: (value) {
                      setState(() {
                        autoChecked = value!;
                      });
                    },
                  ),
                  const Text("Auto"),
                  Checkbox(
                    value: transportePublicoChecked,
                    onChanged: (value) {
                      setState(() {
                        transportePublicoChecked = value!;
                      });
                    },
                  ),
                  const Text("Transporte público"),
                  Checkbox(
                    value: virtualChecked,
                    onChanged: (value) {
                      setState(() {
                        virtualChecked = value!;
                      });
                    },
                  ),
                  const Text("Virtual"),
                  
                ],
              ),
              CustomTextfield(controller: lugarController, labelText: 'Link ...'),
              const SizedBox(height: 20),
              const Text("Tu lugar de labor es..."),
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
                value: true,
                onChanged: (value) {},
              ),
              CheckboxListTile(
                title: const Text("Timbrar"),
                value: true,
                onChanged: (value) {},
              ),
              const Text('Gastaras tu carga premium',
                  style: TextStyle(fontSize: 15, color: AppColors.textSecondary)),
              CheckboxListTile(
                title: const Text("Urgente (sonará hasta que lo desactives)"),
                value: true,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),
              Center(
                child: PrimaryButton(
                  text: 'Agregar horario',
                  onPressed: () {},
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
