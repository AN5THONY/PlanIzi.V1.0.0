import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';



class RecoveryConfirmationScreen extends StatelessWidget {

  final TextEditingController codigoController = TextEditingController();

  RecoveryConfirmationScreen({super.key});

  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Te enviamos un correo', style: TextStyle( fontSize:40, fontWeight: FontWeight.bold, color:  AppColors.primary)),
              const Text('Verifica tu correo electrónico, en tu bandeja de entrado o en el spam, te enviamos un link para cambiar la contraseña.', style: TextStyle( fontSize:15, fontWeight: FontWeight.bold, color:  AppColors.textSecondary)),
              const SizedBox(height: 20,),
        
              const SizedBox(height: 20,),
              const Text('Una vez cambiado, vuelva a iniciar sesión. Gracias :D', style: TextStyle( fontSize:15, fontWeight: FontWeight.bold, color:  AppColors.textSecondary)),
              const SizedBox(height: 40,),
      
          
              PrimaryButton(text: '   Volver al Login  ', onPressed: (){
                Navigator.push(
                  context,
                   MaterialPageRoute(builder: (context) => const LoginScreen()));
              },
              color: AppColors.fourth,),
             
            ],
          ),
        ),
      ),
    );
  }
}