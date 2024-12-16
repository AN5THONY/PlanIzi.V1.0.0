import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/cookie_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/COOKI/crea_cookie_screen.dart';
import 'package:plan_izi_v2/widgets/Publicidad/espacio_publi.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/cookieActivity/a_cookie.dart';



class CookieActivityScreen extends StatefulWidget {
  const CookieActivityScreen({super.key});

  @override
  State<CookieActivityScreen> createState() => _CookieActivityState();
}

class _CookieActivityState extends State<CookieActivityScreen> {
   final List<CookieData> cookie = [
    CookieData(nombre: 'Aji de pollo'),
    CookieData(nombre: 'Carapulcra'),
    CookieData(nombre: 'Matasquita'),
  ];

  void _agregarcookie() {
    setState(() {
      cookie.add(CookieData(nombre: 'Nueva comida '));
    });
  }

  void _eliminarcookie(int index) {
    setState(() {
      cookie.removeAt(index);
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
            color: AppColors.primary,
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
                    Icon(Icons.add, color: AppColors.primary, size: 50, ),
                    SizedBox(width: 20),
                    Text(
                      'A COCINARRR!!!',
                      style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                  ],
          
          
                ),
                const SizedBox(height: 40),
          
                const Text(
                  'Mi Recetas',
                  style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
                ),
          
                const SizedBox(height: 35),
                ...cookie.asMap().entries.map((entry) {
                  int index = entry.key;
                  CookieData cookie = entry.value;
                  return CookieItem(
                    cookie: cookie,
                    onDelete: () => _eliminarcookie(index),
                  );
                }),
                GestureDetector(
                  onTap: (){
                   _agregarcookie();
                  },
                  child: const Center(
                    child: Text(
                      '+ Agregar otra Receta',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
          
                const SizedBox(height: 30),
                
                const Center(child: EspacioPublicidad()),
                
                const SizedBox(height: 30),
                
                Center(
                  child: PrimaryButton(
                    text: '        Ver recetas       ',
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(
                            builder: (context) => const CreaCookieScreen()),
                      );

                    }, 
                    color: AppColors.primary)
                )
              
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}