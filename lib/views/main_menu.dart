import 'package:flutter/material.dart';
import '../widgets/tabbars/appbar_tabbars.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      title: "TabBarView",
      theme: ThemeData(
        useMaterial3: true
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(200, 199, 199, 1),
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
            
            title: const Padding(
              padding:  EdgeInsets.only(bottom: 15),
              
              child: Text("PlanIzi",
                style: TextStyle(
                  color: Color.fromRGBO(30, 174, 146, 1),
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                  
                  ),
                ),
            ),
              bottom: const TabBar(

                indicatorColor: Colors.red,
                labelColor: Colors.red,
                unselectedLabelColor: Color.fromRGBO(30, 174, 146, 1),

                tabs: [
                  TabBars(icono: Icons.home,),
                  TabBars(icono: Icons.calendar_month,),
                  TabBars(icono: Icons.favorite,),
                  TabBars(icono: Icons.menu,),
                ],
              ),
            ),
          ),
        ),
      );
  }
}