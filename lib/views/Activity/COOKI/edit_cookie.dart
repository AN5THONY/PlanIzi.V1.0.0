import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class EditCookie extends StatelessWidget {

  final TextEditingController favoriteFood = TextEditingController();
  final TextEditingController wordKeys = TextEditingController();
  final TextEditingController comends = TextEditingController();
  final List<String> times = [
    "10 min", 
    "20 min", 
    "30 min", 
    "1 hora", 
    "Más de 1 hora"];

  EditCookie({super.key});

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
         padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.add, color: Colors.blue, size: 50,),
                    SizedBox(width: 8),
                    Text("Menú", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20,),
            CustomTextfield(
              controller: favoriteFood,
              labelText: 'Nombre del plato',
              hintText: "Ceviche, papa a la huacaína, etc.",),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Categoría", style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),),
                CheckboxListTile(
                  title: const Text("Desayuno"),
                  value: false,
                  onChanged: (value) {},
                ),
                CheckboxListTile(
                  title: const Text("Almuerzo"),
                  value: false,
                  onChanged: (value) {},
                ),
                CheckboxListTile(
                  title: const Text("Cena"),
                  value: false,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 10,),
                CheckboxListTile( title: const Text('Buscar Receta'),value: true,onChanged: (value) {}),
                
              ],
            ),
            CustomTextfield(
              controller: wordKeys, 
              labelText: 'Palabras claves....'),
            const SizedBox(height: 30,),
            CustomTextfield(
              controller: comends, 
              labelText: 'Agregar receta manual',),
            const SizedBox(height: 20,),
              const Text("Tiempo de preparación"),
            DropdownButtonFormField<String>(
              items: times
                  .map((time) => DropdownMenuItem(
                        value: time,
                        child: Text(time),
                      ))
                  .toList(),
              onChanged: (value) {},
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height:20),
            Center(child: PrimaryButton(text: '                  Agregar Receta                 ', onPressed: (){}, color: AppColors.primary))
          ]
        ),
      ),
    );
  }
}