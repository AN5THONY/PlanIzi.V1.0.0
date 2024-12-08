import 'package:flutter/material.dart';
import 'package:plan_izi_v2/handlers/autenticacion.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Menu/main_menu.dart';
import 'package:plan_izi_v2/views/Recovery/recovery_screen.dart';
import 'package:plan_izi_v2/views/Resgister/register_screen.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bienvenido a        ',
                  style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary)),
              const Text('PlanIzi                   ',
                  style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
              const SizedBox(height: 30),
              const Text(
                '"Organiza tu vida,               ',
                style: TextStyle(fontSize: 16, color: AppColors.primary),
              ),
              const Text(
                '                  domina tu día."',
                style: TextStyle(fontSize: 16, color: AppColors.secondary),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextfield(
                controller: emailController,
                labelText: 'Correo electrónico',
                hintText: 'PlanIzi@gmail.com',
                keyboardType: TextInputType.emailAddress,
                icon: Icons.email,
                validor: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu correo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              CustomTextfield(
                controller: passwordController,
                labelText: 'Contraseña',
                hintText: 'Tu Contraseña',
                isPassword: true,
                icon: Icons.lock,
                validor: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu contraseña.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: '                    Iniciar Sesión                     ',
                onPressed: () async {
                  //Lógica de autenticación
                  // ignore: avoid_print
                  print('Correo: ${emailController.text}');
                  // ignore: avoid_print
                  print('Contraseña: ${passwordController.text}');

                  // Autenticacion de usuario
                  AuthService authService = AuthService();
                  bool isAuthenticated = await authService.authenticateUser(
                    emailController.text,
                    passwordController.text,
                  );

                  if (isAuthenticated) {
                    // Si el usuario es autenticado, redirigir a la pantalla principal
                    if (context.mounted) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainMenu()),
                      );
                    }
                  } else {
                    // Si no es autenticado, mostrar un mensaje de error
                    if (context.mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Error de autenticación'),
                          content: const Text(
                              'Correo electrónico o contraseña incorrectos.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
                color: AppColors.primary,
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RecoveryScreen()),
                  );
                },
                child: const Text("¿Olvidaste la contraseña?"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child:
                      const Text("¿No tienes cuenta? Registrate en PlanIzi")),
            ],
          ),
        ),
      ),
    );
  }
}