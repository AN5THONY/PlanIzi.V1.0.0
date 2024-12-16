import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/work_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/Laboral/crea_work_screen.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/theWorking/a_work.dart';

class WorkActivityScreen extends StatefulWidget {
  const WorkActivityScreen({super.key});

  @override
  State<WorkActivityScreen> createState() => _WorkActivityScreenState();
}

class _WorkActivityScreenState extends State<WorkActivityScreen> {
   final List<WorkData> trabajos = [
    WorkData(nombre: 'Trabajo'),
    WorkData(nombre: 'Trabajo 2'),
  ];

  void _eliminarTrabajo(int index) {
    setState(() {
      trabajos.removeAt(index);
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
            color: AppColors.fifth,
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
                    Icon(Icons.add, color: AppColors.fifth, size: 50, ),
                    SizedBox(width: 5),
                    Text(
                      'Mis actividades laborales',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
          
          
                ),
                const SizedBox(height: 40),
          
                const Text(
                  'Mi trabajos o proyectos',
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
          
                const SizedBox(height: 35),
                ...trabajos.asMap().entries.map((entry) {
                  int index = entry.key;
                  WorkData trabajo = entry.value;
                  return TrabajoItem(
                    trabajo: trabajo,
                    onDelete: () => _eliminarTrabajo(index),
                  );
                }),
          
                const SizedBox(height: 30),
                
                const Center(child: EspacioPublicidad()),
                
                const SizedBox(height: 30),
                
                GestureDetector(
                  onTap: (){
                          Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) =>  const CreaWorkScreen()));
                  },
                  child: const Center(
                    child: Text(
                      '+ Agregar otro trabajo',
                      style: TextStyle(
                        color: AppColors.fifth,
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


/* APUNTES PARA EL DIA
const Text("Apuntes del día..."),
            ElevatedButton(
              onPressed: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                setState(() {});
              },
              child: Text(
                  selectedDate == null ? "Seleccionar fecha" : "$selectedDate"),
            ),
            const SizedBox(height: 30),
            CustomTextfield(
              controller: lugarController,
              labelText: 'Comentario....'), */