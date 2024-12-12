import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/buttons/radio_button.dart';
import 'package:plan_izi_v2/widgets/dropdown/custom_dropdown.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';


// ignore: must_be_immutable
class OrdiActivityScreen extends StatelessWidget {
  final TextEditingController activityNameController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController locationFromController = TextEditingController();
  final TextEditingController locationToController = TextEditingController();
  final TextEditingController suggestionController = TextEditingController();

  String selectedActivityType;
  String? selectedStarHour;
  String? selectedEndHour;

   OrdiActivityScreen({
     this.selectedActivityType = "Actividades anuales" ,
     this.selectedStarHour,
     this.selectedEndHour,
    super.key});

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
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: const BoxDecoration(color: AppColors.cardBackground,),  
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("+ Agregar actividad", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
              
              const SizedBox(height: 10,),
              
              RadioButtonGroup(
                title: '¿Qué tipo de actividad tienes?', 
                options: const [
                  "Actividad diaria",
                  "actividades mensuales",
                  "Actividades semanales",
                  "Actividades anuales",
                ], 
                selectedOption: selectedActivityType,
                onChanged: (value){
                  selectedActivityType = value;
                }),
                const SizedBox(height: 16),

                CustomTextfield(
                controller: activityNameController,
                labelText: "Nombre de la actividad",
                hintText: "Agregar actividad",
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                    value: true,
                    onChanged: (value) {},
                    title: const Text('Tiempo de termino'),
                    activeColor: AppColors.fourth,
                  ),
                const SizedBox(height: 16),
                 Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        hintText: "Comienza...",
                        items: List.generate(24, (i) => "$i:00"),
                        selectedItem: selectedStarHour,
                        onChanged: (value) {
                          selectedStarHour = value;
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomDropdown(
                        hintText: "Termina...",
                        items: List.generate(24, (i) => "$i:00"),
                        selectedItem: selectedEndHour,
                        onChanged: (value) {
                        selectedEndHour = value;
                        },
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 16),

                CustomTextfield(
                controller: noteController,
                labelText: "Descripción para la actividad",
                hintText: "Agrega alguna nota...",
                keyboardType: TextInputType.multiline,
                ),

                 CheckboxListTile(
                title: const Text("Ubicación"),
                value: true, 
                onChanged: (value) {
                  // Manejar el cambio
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
                 const SizedBox(height: 10,),
                 const Text('Gastaras tus carga premium', style: TextStyle(fontSize:15, color: AppColors.textSecondary)),
                 CheckboxListTile(
                    title: const Text("Sugerencias"),
                    value: true, 
                    onChanged: (value) {
                      // Manejar el cambio
                    },
                 ),
                 CheckboxListTile(
                    title: const Text("Notificar"),
                    value: true, 
                    onChanged: (value) {
                      // Manejar el cambio
                    },
                 ),
                 CheckboxListTile(
                    title: const Text("Timbrar"),
                    value: true, 
                    onChanged: (value) {
                      // Manejar el cambio
                    },
                 ),
                 const Text('Gastaras tus carga premium', style: TextStyle(fontSize:15, color: AppColors.textSecondary)),

                 CheckboxListTile(
                    title: const Text("Urgente (sonará tres veces)"),
                    value: true, 
                    onChanged: (value) {
                      // Manejar el cambio
                    },
                 ),
                 PrimaryButton(
                  text: '           Crear Actividad                 ', 
                  onPressed: (){}, 
                  color: AppColors.fourth)

            ],
          ),
        ),
      ),

    );
  }
}