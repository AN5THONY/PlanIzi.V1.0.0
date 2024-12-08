import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Activity/cookie_activity_screen.dart';
import 'package:plan_izi_v2/views/Activity/daily_activity_screen.dart';
import 'package:plan_izi_v2/views/Activity/ordi_activity_screen.dart';
import 'package:plan_izi_v2/views/Activity/special_activity_screen.dart';
import 'package:plan_izi_v2/views/Activity/studient_activity_screen.dart';
import 'package:plan_izi_v2/views/Activity/work_activity_screen.dart';


List<SpeedDialChild> getButtonData(BuildContext context) {
  return [
    SpeedDialChild(
      child: const Icon(Icons.add_home, color: Colors.white),
      labelWidget: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "Actividades Cotidianas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.accent,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DailyActivityScreen(),
          ),
          
        );
      },
    ),
    SpeedDialChild(
      child: const Icon(Icons.cookie, color: Colors.white),
      labelWidget: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "A COCINAR!!",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.primary,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CookieActivityScreen(),
          ),
          
        );
      },
    ),
     SpeedDialChild(
      child: const Icon(Icons.add_alarm, color: Colors.white),
      labelWidget: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "Actividad Ordinarios",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.third,
      onTap: () {
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrdiActivityScreen(),
          ),
          
        );
        
      },
    ),
    SpeedDialChild(
      child: const Icon(Icons.add_alert_outlined, color: Colors.white),
      labelWidget: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "Actividades Especiales",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.fourth,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SpecialActivityScreen(),
          ),
          
        );
      },
    ),

    SpeedDialChild(
      child: const Icon(Icons.add_home_work, color: Colors.white),
      labelWidget: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "Actividades Laborales",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.fifth,
      onTap: () {
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const WorkActivityScreen(),
          ),

        );
      },
    ),
    SpeedDialChild(
      child: const Icon(Icons.add_task, color: Colors.white),
      labelWidget: const Padding(
        padding: EdgeInsets.only(right: 10),
        child: Text(
          "Actividades Estudiantiles",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: AppColors.fifth,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StudientActivityScreen(),
          ),
          
        );
      },
    ),
    
  ];
}
