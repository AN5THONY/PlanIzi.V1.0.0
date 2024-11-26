import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/radio_button.dart';
import 'package:plan_izi_v2/widgets/dropdown/custom_dropdown.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';



class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {

  String selectedTimeOption = "Trabajo";
  String selectedCountry = "Perú";
  String selectedRegion = "Lima";
  String selectedYS = "No tengo";

  final List<String> timeOptions = ["Trabajo", "Estudio" ];
  final List<String> countries = ["Perú"];
  final List<String> region = ["Lima", "Cusco", "Arequipa"];
  final List<String> ynoptions = ["No tengo", "Sí tengo"];

  final TextEditingController workController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController favoriteFoodController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              const Text('Queremos saber + de ti :D...', style: TextStyle( fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.textPrimary,)),
              const SizedBox(height: 20),
              RadioButtonGroup(
                title: 'En qué va tu tiempo',
                options: timeOptions,
                selectedOption: selectedTimeOption,
                onChanged: (value){
                setState(() {
                  selectedTimeOption = value;
                });
              }),
              const SizedBox(height: 16,),
              CustomTextfield(controller: workController, labelText: 'Trabajo en ... ', hintText: "Docente, Ing.Informático, Abogado ...",),
              const SizedBox(height: 20,),
              CustomTextfield(controller: hobbyController, labelText: 'Mi Hobby es... ', hintText: "Jugar fútbol, leer, pintar, viajar..."),
              const SizedBox(height: 20,),
              CustomTextfield(controller: favoriteFoodController, labelText: 'Mi comida favorita es... ',hintText: "Arroz con pollo, Turrón, Inka Cola..."),
              const SizedBox(height: 20,),
              RadioButtonGroup(
                title: "¿Tienes mascota?", 
                options: ynoptions, 
                selectedOption: selectedYS, 
                onChanged: (value){
                setState(() {
                  selectedYS = value;
                });
              }),
              const SizedBox(height: 16,),
              CustomDropdown(hintText: "País", items: countries),
              CustomDropdown(hintText: "Región o Estado", items: region),
              const SizedBox(height: 20,),
              CustomTextfield(controller: addressController, labelText: 'Dirección', hintText: "Av., Calle, Piso, Asoc...."),
              
            ],
          ),
        ),
      ),
    );
  }
}