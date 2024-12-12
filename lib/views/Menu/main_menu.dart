import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_izi_v2/views/Activity/botom_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Menu/Barras/options_screen.dart';
import 'package:plan_izi_v2/views/Menu/Calendario/calendar_screen.dart';
import 'package:plan_izi_v2/views/Menu/Casita/home_screen.dart';
import 'package:plan_izi_v2/views/Menu/Corazon/subcriptions_screen.dart';
import 'package:plan_izi_v2/widgets/buttons/custom_speed_dial.dart';
import '../../widgets/tabbars/appbar_tabbars.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {


  final user=FirebaseAuth.instance.currentUser;


  signout()async{
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      title: "TabBarView",
      theme: ThemeData(useMaterial3: true),
      home: DefaultTabController(
        //BARRA
        length: 4,
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.cardBackground,
            title: const Padding(
              padding:  EdgeInsets.only(bottom: 15),
              child: Text("PlanIzi", style: TextStyle(color: AppColors.primary, fontSize: 40, fontWeight: FontWeight.bold)),
            ),
            bottom: const TabBar(
              indicatorColor: AppColors.fourth,
              labelColor: AppColors.fourth,
              unselectedLabelColor: AppColors.primary,
              tabs: [
                  TabBars(icono: Icons.home,),
                  TabBars(icono: Icons.calendar_month,),
                  TabBars(icono: Icons.favorite,),
                  TabBars(icono: Icons.menu,),
              ],
            ),
          ),

          //CUERPO 
          body:  const TabBarView(
            children: [
              HomeScreen(),
              CalendarScreen(),
              SubcriptionsScreen(),
              OptionsScreen()
            ]),
          floatingActionButton: CustomSpeedDial(
            children: getButtonData(context))
          
        ),
      ),
      
    );

  
  }  
}