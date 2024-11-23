import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/example_screen.dart';


//import 'package:plan_izi_v2/views/example_screen.dart';




void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PlanIzi',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
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
      home: ExampleScreen(),
    );
  }
}

