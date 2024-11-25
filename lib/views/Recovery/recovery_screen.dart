import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';


class RecoveryScreen extends StatelessWidget {

  final TextEditingController emailController = TextEditingController();

  RecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Recupera tu          ', style: TextStyle( fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.textPrimary),),
              const Text('             PlanIzi ', style: TextStyle( fontSize:40, fontWeight: FontWeight.bold, color:  AppColors.primary)),
              const Text('¿Olvidaste la contraseña?                                           ', style: TextStyle( fontSize:15, fontWeight: FontWeight.bold, color:  AppColors.textSecondary)),
              const SizedBox(height: 20,),
              CustomTextfield(controller: emailController, labelText: 'Correo electrónico'),
              const SizedBox(height: 20,),
              const Text('Te enviaremos un correo electrónico, para confirmar tu usuario.', style: TextStyle( fontSize:15, fontWeight: FontWeight.bold, color:  AppColors.textSecondary)),
              const SizedBox(height: 60,),
              PrimaryButton(text: '                     Confirmar                    ', onPressed: (){
                // implementar la función para enviar correo electrónico
                // ignore: avoid_print
                print('Correo: ${emailController.text}');

              },
              color: AppColors.fourth,),
              const SizedBox(height: 20,),
              TextButton(onPressed: (){
                 Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
              }, child: const Text('Iniciar Sesión'))
            ],
          ),
        ),
      ),
    );
  }
}