import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart';
import 'package:plan_izi_v2/views/Menu/main_menu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:plan_izi_v2/views/Login/estado_usuario.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EstadoUsuario(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PlanIzi',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.cardBackground,
          appBarTheme: const AppBarTheme(
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
        home: const AuthHandler(),
      ),
    );
  }
}

class AuthHandler extends StatelessWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final estadoUsuario = Provider.of<EstadoUsuario>(context);

    // escoge la pantallaa
    if (estadoUsuario.isLoggedIn) {
      return const MainMenu();
    } else {
      return const LoginScreen();
    }
  }
}
