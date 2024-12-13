import 'package:flutter/material.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class CreaStudientScreen extends StatelessWidget {
  const CreaStudientScreen({super.key});

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
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
              const Text(
              "+ Agregar actividades cotidianas",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 20),

            // Nombre de la actividad
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
              "Necesito que me...",
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
            const SizedBox(height: 20),

            // Sugerencias y Comentarios
            CustomTextfield(
              controller: TextEditingController(),
              labelText: "Sugerencias...",
              hintText: "Palabras claves...",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            CustomTextfield(
              controller: TextEditingController(),
              labelText: "Agrega comentario...",
              hintText: "Comentario...",
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),

            // Botón
            PrimaryButton(
              text: "Agregar curso",
              onPressed: () {
                // Acción al presionar
              },
              color: Colors.teal,
            ),
          ],
        ),
      ),
    );
  }
}