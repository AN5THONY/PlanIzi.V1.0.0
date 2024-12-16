import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class EditCookie extends StatefulWidget {


  const EditCookie({super.key});

  @override
  State<EditCookie> createState() => _EditCookieState();
}

class _EditCookieState extends State<EditCookie> {

  TimeOfDay _selectedTime = TimeOfDay.now();

    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!);
        }
        );
      if (picked != null && picked != _selectedTime) {
        setState(() {
          _selectedTime = picked;
        });
      } 
    }
    

  String _formatTime24(TimeOfDay time) {
    final String hour = time.hour.toString().padLeft(2, '0');
    final String minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  final TextEditingController favoriteFood = TextEditingController();

  final TextEditingController wordKeys = TextEditingController();

  final TextEditingController comends = TextEditingController();


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
            color: AppColors.primary,
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
                    Icon(Icons.add, color: AppColors.primary, size: 50,),
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
                const Text('Gastaras tus carga premium', style: TextStyle(fontSize:15, color: AppColors.textSecondary)),
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
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hora de preparación: ${_formatTime24(_selectedTime)}",
                  style: const TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                  child: const Text(
                    "Seleccionar hora",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height:20),
            Center(child: PrimaryButton(text: 'Agregar Receta', onPressed: (){}, color: AppColors.primary))
          ]
        ),
      ),
    );
  }
}