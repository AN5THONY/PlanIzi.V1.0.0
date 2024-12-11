import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/cookie_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/COOKI/edit_cookie.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/cookieActivity/a_cookie.dart';

class CreaCookieScreen extends StatefulWidget {

  const CreaCookieScreen({super.key});

  @override
  State<CreaCookieScreen> createState() => _CreaCookieScreenState();
}

class _CreaCookieScreenState extends State<CreaCookieScreen> {
  List<bool> selectedDays = List.generate(7, (index) => false);
  List<bool> selectedDaysCo = List.generate(7, (index) => false);
  final days = ["DOM", "LUN", "MAR", "MIÉ", "JUE", "VIE", "SÁB"];
  final List<CookieData> cookie = [
    CookieData(nombre: 'Aji de pollo'),
    CookieData(nombre: 'Carapulcra'),
    CookieData(nombre: 'Matasquita'),
  ];
   final recipes = [
    "Ají de Gallina",
    "Arroz con Pollo",
    "Mote Sagrado",
    "Purée de papa con pollo a la olla",
  ];
  bool isRandom = true;

  void _eliminarcookie(int index) {
    setState(() {
      cookie.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
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
            const Text('A cocinar'),
            const SizedBox(height: 10),
            const Text("Cocino los..."),
            Wrap(
              spacing: 8.0,
              children: List.generate(days.length, (index) {
                return ChoiceChip(
                  label: Text(days[index]),
                  selected: selectedDays[index],
                  onSelected: (selected) {
                    setState(() {
                      selectedDays[index] = selected;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Los platos a cocinar serán..."),
                Row(
                  children: [
                    Radio(
                      value: true,
                      groupValue: isRandom,
                      onChanged: (value) {
                        setState(() {
                          isRandom = value!;
                        });
                      },
                    ),
                    const Text("Aleatorio"),
                    Radio(
                      value: false,
                      groupValue: isRandom,
                      onChanged: (value) {
                        setState(() {
                          isRandom = value!;
                        });
                      },
                    ),
                    const Text("Seleccionar"),
                    
                  ],
                ),
                const SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Recetario..."),
                    Wrap(
                      spacing: 8.0,
                      children: List.generate(days.length, (index) {
                        return ChoiceChip(
                          label: Text(days[index]),
                          selected: selectedDaysCo[index],
                          onSelected: (selected) {
                            setState(() {
                              selectedDaysCo[index] = selected;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 35),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Cocino solo...", style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold),),
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
              ],
            ),
            const SizedBox(height: 35),
                const Text(
                  'Mi Recetas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
          
                const SizedBox(height: 20),
                ...cookie.asMap().entries.map((entry) {
                  int index = entry.key;
                  CookieData cookie = entry.value;
                  return CookieItem(
                    cookie: cookie,
                    onDelete: () => _eliminarcookie(index),
                  );
                }),
              const SizedBox(height: 20,),
             GestureDetector(
                  onTap: (){
                   Navigator.push(context,
                      MaterialPageRoute(
                            builder: (context) => EditCookie()),
                      );
                  },
                  child: const Center(
                    child: Text(
                      '+ Agregar otra Receta',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            const SizedBox(height: 20,),
            Center(
              child: PrimaryButton(
                text: '             Guardar Cambios         ',
                onPressed: (){
                  
                }, 
                color: AppColors.primary)
            )
          ],
        ),
      ),
    );
  }
}