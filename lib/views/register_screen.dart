import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/dropdown.dart/custom_dropdown.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';


class RegisterScreen extends StatelessWidget {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  final List<String> ageoptions = List.generate(100, (index) => "${index + 1}");
  final List<String> genderOptions = ["Masculino", "Femenino", "Otro genero"];


  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(  
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height : 50),
              const Text("Se parte de         ", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.textPrimary),),
              const Text('PlanIzi', style: TextStyle(fontSize:50, fontWeight: FontWeight.bold, color: AppColors.primary)),
              const SizedBox(height: 20,),
              CustomTextfield(controller: nameController, labelText: "Introduce tus nombres"),
              const SizedBox(height: 10,),
              CustomTextfield(controller: lastNameController, labelText: 'Introduce tus apellidos'),
              const SizedBox(height: 10,),
              Row (
                  children: [
                    CustomDropdown(hintText: '', items: ageoptions, )
                  ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}