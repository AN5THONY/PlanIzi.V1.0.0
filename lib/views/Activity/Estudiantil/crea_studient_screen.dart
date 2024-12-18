import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class CreaStudientScreen extends StatefulWidget {
  const CreaStudientScreen({super.key});

  @override
  State<CreaStudientScreen> createState() => _CreaStudientScreenState();
}

class _CreaStudientScreenState extends State<CreaStudientScreen> {
  final TextEditingController lugarController = TextEditingController();

  // Variables para manejar horarios
  final List<String> days = ["DOM", "LUN", "MAR", "MIÉ", "JUE", "VIE", "SÁB"];
  List<TimeOfDay?> startTimes = List.filled(7, null);
  List<TimeOfDay?> endTimes = List.filled(7, null);

  // Método para mostrar selector de hora
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
              controller: TextEditingController(),
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
              value: true,
              onChanged: (bool? value) {},
            ),
            CustomTextfield(controller: lugarController, labelText: 'Link ...'),
            CheckboxListTile(
              title: const Text("Presencial"),
              value: false,
              onChanged: (bool? value) {},
            ),

            // Horarios para cada día
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

            PrimaryButton(
              text: "Agregar curso",
              onPressed: () {
                // Acción al presionar
              },
              color: AppColors.sixth,
            ),
          ],
        ),
      ),
    );
  }
}
