import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';


class EmailConfirmationScreen extends StatelessWidget {

  final TextEditingController codigoController = TextEditingController();

  EmailConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Confirmación de correo', style: TextStyle( fontSize:40, fontWeight: FontWeight.bold, color:  AppColors.primary)),
              const Text('Confirma tu cuenta con el código que te enviamos al correo.', style: TextStyle( fontSize:15, fontWeight: FontWeight.bold, color:  AppColors.textSecondary)),
              const SizedBox(height: 20,),
              CustomTextfield(controller: codigoController, labelText: 'Codigo', hintText: '123-456',),
              const SizedBox(height: 20,),
              const Text('Te enviaremos un correo electrónico, para confirmar tu usuario.', style: TextStyle( fontSize:15, fontWeight: FontWeight.bold, color:  AppColors.textSecondary)),
              const SizedBox(height: 40,),
              TextButton(onPressed: (){
                  
              }, child: const Text('No me llego el correo.                                                     '),),
              const SizedBox(height: 20,),
              PrimaryButton(text: '                     Confirmar                    ', onPressed: (){
                // implementar la función para enviar correo electrónico
                // ignore: avoid_print
                print('Correo: ${codigoController.text}');

              },
              color: AppColors.third,),
             
            ],
          ),
        ),
      ),
    );
  }
}