import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Recovery/recovery_screen.dart';
import 'package:plan_izi_v2/views/Resgister/register_screen.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';
import 'package:plan_izi_v2/views/Menu/main_menu.dart';
import 'package:provider/provider.dart';
import 'package:plan_izi_v2/views/Login/estado_usuario.dart';
import 'package:plan_izi_v2/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // LOGIN
signIn() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    // Sincronizar los datos del usuario con Firestore
    await UserService().syncUserWithFirestore();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Inicio de sesión exitoso")),
      );
    }
  } on FirebaseAuthException {
    String errorMessage =
        'Hubo un problema al intentar iniciar sesión. Intenta nuevamente.';

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Consumer<EstadoUsuario>(
      builder: (context, estadoUsuario, child) {
        if (estadoUsuario.isLoggedIn) {
          if (mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainMenu()),
              );
            });
          }
        }
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
                    text:
                        '                    Iniciar Sesión                     ',
                    onPressed: (() => signIn()),
                    color: AppColors.primary,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RecoveryScreen()),
                      );
                    },
                    child: const Text(
                        "¿No puedes acceder? Recupera tu contraseña aquí"),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                          "¿Eres nuevo? Crea tu cuenta en Planizi y únete a nosotros")),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
