import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class CreaCotiScreen extends StatefulWidget {
  const CreaCotiScreen({super.key});

  @override
  State<CreaCotiScreen> createState() => _CreaCotiScreenState();
}

class _CreaCotiScreenState extends State<CreaCotiScreen> {

  TimeOfDay _selectedTime = TimeOfDay.now();

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
                    Icon(Icons.add, color: AppColors.accent, size: 50, ),
                    SizedBox(width: 5),
                    Text(
                      'Mis actividades Cotidianas',
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
          
          
                ),
             const SizedBox(height: 40),
             CustomTextfield(
              controller: TextEditingController(),
              labelText: "Nombre de la actividad",
              hintText: "Cocinar, ir al Gym, Limpiar etc.",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            // Lugar
            const Text(
              "Tiene lugar en...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              title: const Text("Hogar"),
              value: true,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text("Afuera"),
              value: false,
              onChanged: (bool? value) {},
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextfield(
                    controller: TextEditingController(),
                    labelText: "De...",
                    hintText: "",
                    keyboardType: TextInputType.datetime,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextfield(
                    controller: TextEditingController(),
                    labelText: "A...",
                    hintText: "",
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Frecuencia
            const Text(
              "Frecuencia...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ["DOM", "LUN", "MAR", "MIÉ", "JUE", "VIE", "SÁB"]
                  .map(
                    (day) => ChoiceChip(
                      label: Text(day),
                      selected: false,
                      onSelected: (bool selected) {},
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Necesidades
            const Text(
              "Necesito que ...",
              style: TextStyle(fontSize: 16),
            ),
            CheckboxListTile(
              title: const Text("Notifique"),
              value: true,
              onChanged: (bool? value) {},
            ),
            CheckboxListTile(
              title: const Text("Alarme"),
              value: false,
              onChanged: (bool? value) {},
            ),
            const Text('Gastaras tus carga premium', style: TextStyle(fontSize:15, color: AppColors.textSecondary)),
            CheckboxListTile(
              title: const Text("Sugerencias"),
              value: false,
              onChanged: (bool? value) {},
            ),
            const SizedBox(height: 20),
 
            // Sugerencias y Comentarios
            CustomTextfield(
              controller: TextEditingController(),
              labelText: "Sugerencias...",
              hintText: "Palabras claves...",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            
             const Text(
              "Selecciona la hora",
              style: TextStyle(fontSize: 16),
            ),
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
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
                  child: const Text(
                    "Seleccionar hora",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            CustomTextfield(
              controller: TextEditingController(),
              labelText: "Agrega comentario...",
              hintText: "Comentario...",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 30),

            // Botón
            PrimaryButton(
              text: "Agregar Actividad Cotidiana",
              onPressed: () {
                // Acción al presionar
              },
              color:AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}