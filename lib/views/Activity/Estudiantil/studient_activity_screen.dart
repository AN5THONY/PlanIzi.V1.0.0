import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/studient_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/Estudiantil/crea_studient_screen.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/StudientActivity/a_studient.dart';


class StudientActivityScreen extends StatefulWidget {
  const StudientActivityScreen({super.key});

  @override
  State<StudientActivityScreen> createState() => _StudientActivityScreenState();
}

class _StudientActivityScreenState extends State<StudientActivityScreen> {
   final List<StudientData> studient = [
    StudientData(nombre: 'Universidad'),
    StudientData(nombre: 'IPNA'),
    StudientData(nombre: 'Python'),
  ];



  void _eliminarstudient(int index) {
    setState(() {
      studient.removeAt(index);
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
            color: AppColors.sixth,
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
                    Icon(Icons.add, color: AppColors.sixth, size: 50, ),
                    SizedBox(width: 5),
                    Text(
                      'Mis actividades Estudiantiles',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
          
          
                ),
                const SizedBox(height: 40),
          
                const Text(
                  'Mis estudios',
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
          
                const SizedBox(height: 35),
                ...studient.asMap().entries.map((entry) {
                  int index = entry.key;
                  StudientData studient = entry.value;
                  return StudientItem(
                    studient: studient,
                    onDelete: () => _eliminarstudient(index),
                  );
                }),
          
                const SizedBox(height: 30),
                
                const Center(child: EspacioPublicidad()),
                
                const SizedBox(height: 30),
                
                GestureDetector(
                  onTap: (){
                       Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) =>   CreaStudientScreen()));
              
                  },
                  child: const Center(
                    child: Text(
                      '+ Agregar otra actividad estudiantil',
                      style: TextStyle(
                        color: AppColors.sixth,
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