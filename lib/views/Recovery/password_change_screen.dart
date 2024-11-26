import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';


class PassswordChangeScreen extends StatelessWidget {

  final TextEditingController codigoController = TextEditingController();

  PassswordChangeScreen({super.key});
  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Tu                              ', style: TextStyle( fontSize:40, fontWeight: FontWeight.bold, color:  AppColors.textPrimary)),
              const Text('PlanIzi                      ', style: TextStyle( fontSize:40, fontWeight: FontWeight.bold, color:  AppColors.primary)),
              const Text('y tú <3.                     ', style: TextStyle( fontSize:40, fontWeight: FontWeight.bold, color:  AppColors.textPrimary)),
              const SizedBox(height: 20,),
              const Text('Cambia tu contraseña y asegura no perderlo                  ', style: TextStyle( fontSize:15, fontWeight: FontWeight.bold, color:  AppColors.textSecondary)),
              const SizedBox(height: 40,),
              CustomTextfield(controller: codigoController, labelText: 'Establece tu nueva contraseña', hintText: '123-456',),
              const SizedBox(height: 40,),
              CustomTextfield(controller: codigoController, labelText: 'Confirma tu contraseña', hintText: '123-456',),
              const SizedBox(height: 60 ,),
              PrimaryButton(text: '                Cambiar contraseña                  ', onPressed: (){
                // implementar la función para enviar correo electrónico
                // ignore: avoid_print
                print('Correo: ${codigoController.text}');

              },
              color: AppColors.fourth,),
             
            ],
          ),
        ),
      ),
    );
  }
}