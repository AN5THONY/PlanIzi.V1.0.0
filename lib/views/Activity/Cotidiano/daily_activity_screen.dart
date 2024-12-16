import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/daily_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/Cotidiano/crea_coti_screen.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/dailyActivity/a_daily.dart';


class DailyActivityScreen extends StatefulWidget {
  const DailyActivityScreen({super.key});

  @override
  State<DailyActivityScreen> createState() => _DailyActivityScreenState();
}

class _DailyActivityScreenState extends State<DailyActivityScreen> {
   final List<DailyData> activity = [
    DailyData(nombre: 'Despertar  de L  a V'),
    DailyData(nombre: 'Ir al GyM'),
    DailyData(nombre: 'Pasear A Cookie'),
  ];


  void _eliminaractivity(int index) {
    setState(() {
      activity.removeAt(index);
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
            color: AppColors.accent,
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
                    Icon(Icons.add, color: AppColors.accent, size: 50, ),
                    SizedBox(width: 5),
                    Text(
                      'Mis actividades Cotidianas',
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
          
          
                ),
                const SizedBox(height: 40),
          
                const Text(
                  'Mis actividades',
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
          
                const SizedBox(height: 35),
                ...activity.asMap().entries.map((entry) {
                  int index = entry.key;
                  DailyData activity = entry.value;
                  return DailyItem(
                    activity: activity,
                    onDelete: () => _eliminaractivity(index),
                  );
                }),
          
                const SizedBox(height: 30),
                
                const Center(child: EspacioPublicidad()),
                
                const SizedBox(height: 30),
                
                GestureDetector(
                  onTap: (){ 
                     Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) =>  const CreaCotiScreen()));
              
                  },
                  child: const Center(
                    child: Text(
                      '+ Agregar otro trabajo',
                      style: TextStyle(
                        color: AppColors.accent,
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