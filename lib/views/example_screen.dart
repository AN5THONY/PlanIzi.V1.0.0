
import 'package:flutter/material.dart';
import 'package:plan_izi_v2/widgets/dropdown/custom_dropdown.dart';





class ExampleScreen extends StatelessWidget{

  final List<String> ageOption = List.generate(100, (index) => "${index + 1}",); 


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
           CustomDropdown(
           hintText: "Edad", 
           items: ageOption,
           onChanged: (value) {
            //Logica 
            // ignore: avoid_print
            print("Edad Seleccionada: $value");
           }
          ),
          
           
          ],
        ),
        ),
    );
  }

}