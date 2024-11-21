
import 'package:flutter/material.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';



class ExampleScreen extends StatelessWidget{
  const ExampleScreen({super.key});
  
  
@override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Ejemplo de Widgets')),
      body: Padding(
        padding: const EdgeInsets.all(100), 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           PrimaryButton(text: 'Boton principal', onPressed: () => print('Botón presionado'),),
           const SizedBox(height: 20,),
           const Text('XD'),
           
          ],
        ),
        ),
    );
  }

}