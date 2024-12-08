import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/buttons/primary_button.dart';
import 'package:plan_izi_v2/widgets/textfields/custom_textfield.dart';


class CreaWorkScreen extends StatefulWidget {
  const CreaWorkScreen({super.key});

  @override
  State<CreaWorkScreen> createState() => _CreaWorkScreenState();
}

class _CreaWorkScreenState extends State<CreaWorkScreen> {
  String jornada = 'Por Turnos';
  int duracionSemanal = 40;
  bool autoChecked = true;
  bool transportePublicoChecked = false;
  bool virtualChecked = false;
  final TextEditingController lugarController = TextEditingController();
  final TextEditingController comentarioController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'PlanIzi',
          style: TextStyle(
            fontSize: 50,
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
          decoration: const BoxDecoration( color: AppColors.cardBackground, ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Agregar actividades laborales", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 20),
              const Text("Tu jornada laboral es:"),
               Row(
                children: [
                  Radio(
                    value: 'Por Turnos',
                    groupValue: jornada,
                    onChanged: (value) {
                      setState(() {
                        jornada = value.toString();
                      });
                    },
                  ),
                  const Text("Por Turnos"),
                  Radio(
                    value: 'Establecido',
                    groupValue: jornada,
                    onChanged: (value) {
                      setState(() {
                        jornada = value.toString();
                      });
                    },
                  ),
                  const Text("Por Jornadas"),
                ],
              ),
              const SizedBox(height: 10),
              const Text("Duración semanal"),
              DropdownButton<int>(
                value: duracionSemanal,
                items: [37, 38, 39, 40, 41, 42]
                    .map((hour) => DropdownMenuItem(
                          value: hour,
                          child: Text('$hour horas'),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    duracionSemanal = value!;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text("Distribuyan sus horas"),
            ...List.generate(7, (index) {
              return Row(
                children: [
                  const SizedBox(height: 5,),
                  Expanded(child: Text("Día ${index + 1}")),
                  Expanded(child: SizedBox.fromSize()),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Horas",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 20),
            CustomTextfield(
              controller: lugarController,
              labelText: 'Tu lugar de labor es....'),
            const SizedBox(height: 20),
            const Text("Vas..."),
            Row(
              children: [
                Checkbox(
                  value: autoChecked,
                  onChanged: (value) {
                    setState(() {
                      autoChecked = value!;
                    });
                  },
                ),
                const Text("Auto"),
                Checkbox(
                  value: transportePublicoChecked,
                  onChanged: (value) {
                    setState(() {
                      transportePublicoChecked = value!;
                    });
                  },
                ),
                const Text("Transporte público"),
                Checkbox(
                  value: virtualChecked,
                  onChanged: (value) {
                    setState(() {
                      virtualChecked = value!;
                    });
                  },
                ),
                const Text("Virtual"),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Apuntes del día..."),
            ElevatedButton(
              onPressed: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                setState(() {});
              },
              child: Text(
                  selectedDate == null ? "Seleccionar fecha" : "$selectedDate"),
            ),
            const SizedBox(height: 30),
            CustomTextfield(
              controller: lugarController,
              labelText: 'Comentario....'),
            const SizedBox(height: 20),
            PrimaryButton(text: '                Agregar horario                 ', onPressed: (){}, color: AppColors.primary),   
            
            ],
          ),
        ),
      ),
    );
  }
}