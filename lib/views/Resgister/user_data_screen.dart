import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Queremos saber             ',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                const Text('+ de ti :D...',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.fourth)),
                const SizedBox(height: 20),
                // Botones de Radio
                RadioButtonGroup(
                  title: 'En qué va tu tiempo',
                  options: timeOptions,
                  selectedOption: selectedTimeOption,
                  onChanged: (value) {
                    setState(() {
                      selectedTimeOption = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Campos de texto personalizados
                CustomTextfield(
                  controller: workController,
                  labelText: 'Trabajo en ... ',
                  hintText: "Docente, Ing.Informático, Abogado ...",
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  controller: hobbyController,
                  labelText: 'Mi Hobby es...',
                  hintText: "Jugar fútbol, leer, pintar, viajar...",
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  controller: favoriteFoodController,
                  labelText: 'Mi comida favorita es...',
                  hintText: "Arroz con pollo, Turrón, Inka Cola...",
                ),
                const SizedBox(height: 20),
                // Botones de Radio para mascota
                RadioButtonGroup(
                  title: "¿Tienes mascota?",
                  options: ynoptions,
                  selectedOption: selectedYS,
                  onChanged: (value) {
                    setState(() {
                      selectedYS = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                // Dropdowns personalizados
                CustomDropdown(
                  hintText: "País",
                  items: countries,
                ),
                const SizedBox(height: 10),
                CustomDropdown(
                  hintText: "Región o Estado",
                  items: region,
                ),
                const SizedBox(height: 20),
                CustomTextfield(
                  controller: addressController,
                  labelText: 'Dirección',
                  hintText: "Av., Calle, Piso, Asoc....",
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // Lógica para seleccionar en el mapa
                  },
                  icon: const Icon(Icons.map),
                  label: const Text("Seleccionar en el mapa"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  text: "                       Comenzar!                     ",
                  onPressed: () {
                    // Lógica para completar el registro
                    final work = workController.text;
                    final hobby = hobbyController.text;
                    final food = favoriteFoodController.text;
                    final address = addressController.text;

                    if (work.isEmpty || hobby.isEmpty || food.isEmpty || address.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Por favor, completa todos los campos")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("¡Registro completado con éxito!")),
                      );
                    }
                  },
                  color: AppColors.third,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}