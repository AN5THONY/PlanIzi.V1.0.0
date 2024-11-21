
import 'package:flutter/material.dart';
//import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';



class ExampleScreen extends StatelessWidget{

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ExampleScreen({super.key});



@override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Ejemplo de Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(100), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           CustomTextfield(controller: emailController, labelText: 'Correo electrónico'),
           const SizedBox(height: 20,),
           const Text('XD'),
           
          ],
        ),
        ),
    );
  }

}