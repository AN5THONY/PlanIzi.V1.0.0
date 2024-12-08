import 'package:flutter/material.dart';
import 'package:plan_izi_v2/handlers/sqlite_handler.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart';
import 'package:plan_izi_v2/views/Recovery/recovery_screen.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/dropdown/custom_dropdown.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController fechaNacimientoController =
      TextEditingController();

  final List<String> ageOptions = List.generate(100, (index) => "${index + 1}");
  final List<String> genderOptions = ["Masculino", "Femenino", "Otro género"];

  //DateTime? _selectedDate;

/*

  // Método para abrir el selector de fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        fechaNacimientoController.text = DateFormat('yyyy-MM-dd').format(_selectedDate!);
      });
    } else {
      print("Fecha no seleccionada o cancelada");
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Se parte de         ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(
                'PlanIzi',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: nameController,
                labelText: "Introduce tus nombres",
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: lastNameController,
                labelText: 'Introduce tus apellidos',
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                hintText: "Edad",
                items: ageOptions,
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                hintText: "Género",
                items: genderOptions,
              ),
              const SizedBox(height: 10),

              /*
              // Aquí es donde hemos movido la fecha de nacimiento
              GestureDetector(
                onTap: () => _selectDate(context),  // Maneja el toque aquí
                child: CustomTextfield(
                  controller: fechaNacimientoController,
                  labelText: 'Introduce tu fecha de nacimiento',
                  hintText: 'Fecha de nacimiento',
                ),
              ),

              */
              const SizedBox(height: 20),
              CustomTextfield(
                controller: emailController,
                labelText: 'Introduce tu correo electrónico',
                hintText: 'Correo electrónico',
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: passwordController,
                labelText: 'Establece tu contraseña',
                hintText: 'Tu contraseña',
                isPassword: true,
              ),
              const SizedBox(height: 20),
              CustomTextfield(
                controller: confirmController,
                labelText: 'Confirma tu contraseña',
                hintText: 'Confirma tu contraseña',
                isPassword: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  final sqliteHandler = SqliteHandler();
                  await sqliteHandler.deleteDatabaseFile();
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Base de datos eliminada.')),
                    );
                  }
                },
                child: const Text('Eliminar Base de Datos'),
              ),
              const SizedBox(height: 40),
              PrimaryButton(
                text: '                    Continuar                     ',
                onPressed: () async {
                  if (passwordController.text != confirmController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Las contraseñas no coinciden'),
                      ),
                    );
                    return;
                  }

                  if (nameController.text.isEmpty ||
                      lastNameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      //fechaNacimientoController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor completa todos los campos'),
                      ),
                    );
                    return;
                  }

                  try {
                    SqliteHandler sqliteHandler = SqliteHandler();

                    await sqliteHandler.registerUser(
                      nombres: nameController.text,
                      apellidos: lastNameController.text,
                      correoElectronico: emailController.text,
                      contrasena: passwordController.text,
                      genero: genderOptions[0], // Selección por defecto
                      //fechaNacimiento: fechaNacimientoController.text, // Fecha seleccionada
                    );
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Usuario registrado exitosamente'),
                        ),
                      );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al registrar: $e')),
                      );
                    }
                  }
                },
                color: AppColors.third,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: const Text('Iniciar Sesión'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecoveryScreen(),
                    ),
                  );
                },
                child: const Text('¿Olvidaste tu contraseña?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}