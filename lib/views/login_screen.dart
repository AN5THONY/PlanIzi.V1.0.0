import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';



class LoginScreen extends StatelessWidget{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});


@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Bienvenido a PlanIzi', 
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)
              ),
              const SizedBox(height: 10),
              const Text('"Organiza tu vida, domina tu día."',
              style: TextStyle(fontSize: 16, color: AppColors.secondary),),
              const SizedBox(height: 30,),
              CustomTextfield(controller: emailController , labelText: 'Correo electrónico', hintText: 'PlanIzi@gmail.com',)
            ],
          ), 
          ),        
        ),
    );
  }


}