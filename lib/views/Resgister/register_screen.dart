import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart';
import 'package:plan_izi_v2/views/Recovery/recovery_screen.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/dropdown/custom_dropdown.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';


class RegisterScreen extends StatefulWidget {


  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  final List<String> ageoptions = List.generate(100, (index) => "${index + 1}");

  final List<String> genderOptions = ["Masculino", "Femenino", "Otro genero"];

  DateTime? selectedDate;

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
              const SizedBox(height: 20,),
              CustomTextfield(controller: lastNameController, labelText: 'Introduce tus apellidos'),
              const SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Fecha de Nacimiento ', style: TextStyle(fontSize:16, color: AppColors.textPrimary )),
                  const SizedBox(width: 40,),
                  ElevatedButton(
                  style: ElevatedButton.styleFrom( 
                    iconColor: AppColors.primary,
                    surfaceTintColor: Colors.black,
                    foregroundColor: AppColors.third,
                    disabledIconColor: AppColors.third,
                    elevation: 5,
                    shadowColor: const Color.fromARGB(255, 83, 83, 83),
                    
                  ),
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.timestamp(),

                    );
                    setState(() {});
                  },
                  child: Text(
                      selectedDate == null
                        ? "Seleccionar fecha"
                        : DateFormat('yyyy-MM-dd').format(selectedDate!),
                                              ),
                  )
                ],
              ),
              CustomDropdown(hintText: "Género", items: genderOptions),//+
              const SizedBox(height: 10,),
              CustomTextfield(
                controller: passwordController,
                labelText: 'Establece tu contraseña',
                hintText: 'Tu contraseña',
                isPassword: true,
                 ),
              const SizedBox(height: 20,),
              CustomTextfield(
                controller: confirmController,
                labelText: 'Confirma tu contraseña',
                hintText: 'Confirma tu contraseña',
              ),
              const SizedBox(height: 40,),
              PrimaryButton(text: '                    Contuinar                     ', 
              onPressed: (){
                //validación y proceso de datros
                if (passwordController.text == confirmController.text) {
                  // ignore: avoid_print
                  print("Nombres: ${nameController.text}");
                  // ignore: avoid_print
                  print("Apellidos: ${lastNameController.text}");
                  // ignore: avoid_print
                  print("Correo: ${emailController.text}");
                }
              },
              color: AppColors.third,),
              const SizedBox(height: 10,),
              TextButton(onPressed: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }, child: const Text('Iniciar Sesión'),),
              TextButton(onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RecoveryScreen()),
                    );
              }, child: const Text('¿Olvidaste tu contraseña?'),),
              
            ],
          ),
        ),
      ),
    );

  }
}