import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Login/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlanIzi',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.cardBackground,
        appBarTheme: const AppBarTheme (
          backgroundColor: AppColors.primary,
          titleTextStyle: TextStyle( 
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.accent,
        ),
      ),
      home: const Wrapper(),
    );
  }
}

