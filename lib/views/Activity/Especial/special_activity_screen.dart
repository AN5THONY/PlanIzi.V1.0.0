import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/special_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/Especial/crea_special_screen.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/SpecialActivity/a_special.dart';


class SpecialActivityScreen extends StatefulWidget {
  const SpecialActivityScreen({super.key});

  @override
  State<SpecialActivityScreen> createState() => _SpecialActivityScreenState();
}

class _SpecialActivityScreenState extends State<SpecialActivityScreen> {
   final List<SpecialData> special = [
    SpecialData(nombre: 'Cumpleaños de mamá'),
    SpecialData(nombre: 'Titulación'),
    SpecialData(nombre: 'Visita en provincia'),
  ];

   void _agregarspecial() {
    setState(() {
      special.add(SpecialData(nombre: 'Nueva actividad especial'));
    });
  }

  void _eliminarspecial(int index) {
    setState(() {
      special.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
          decoration: const BoxDecoration( color: AppColors.cardBackground),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                
                const SizedBox(height: 30,),
          
                const Row(
          
                  children: [
                    Icon(Icons.add, color: Colors.teal, size: 50, ),
                    SizedBox(width: 5),
                    Text(
                      'Mis actividades especiales',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
          
          
                ),
                const SizedBox(height: 40),
          
                const Text(
                  'Mis actividades',
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
          
                const SizedBox(height: 35),
                ...special.asMap().entries.map((entry) {
                  int index = entry.key;
                  SpecialData special = entry.value;
                  return SpecialItem(
                    special: special,
                    onDelete: () => _eliminarspecial(index),
                  );
                }),
          
                const SizedBox(height: 30),
                
                const Center(child: EspacioPublicidad()),
                
                const SizedBox(height: 30),
                
                GestureDetector(
                  onTap: () {
                      Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) =>  const CreaSpecialScreen()));
              
                  },
                  child: const Center(
                    child: Text(
                      '+ Agregar otra actividad',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}