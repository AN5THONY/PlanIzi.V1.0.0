import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart';
import 'package:plan_izi_v2/views/Resgister/register_screen.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class RecoveryScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  RecoveryScreen({super.key});

  //RECUPERAR
  reset() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Recupera tu          ',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary),
              ),
              const Text('             PlanIzi ',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary)),
              const Text(
                  '¿Olvidaste la contraseña?                                           ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary)),
              const SizedBox(
                height: 20,
              ),
              CustomTextfield(
                  controller: emailController, labelText: 'Correo electrónico'),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  'Te enviaremos un correo electrónico, para confirmar tu usuario.',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary)),
              const SizedBox(
                height: 60,
              ),
              PrimaryButton(
                text: '                     Confirmar                    ',
                onPressed: () {
                  reset();
                },
                color: AppColors.fourth,
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text('Iniciar Sesión')),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Regístrate en PlanIzi'))
            ],
          ),
        ),
      ),
    );
  }
}
