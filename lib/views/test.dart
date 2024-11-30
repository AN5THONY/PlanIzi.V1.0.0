import 'package:flutter/material.dart';
import 'package:plan_izi_v2/widgets/buttons/custom_speed_dial.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TestScreen'),
      ),
      body: const Center(
        child: Text('TestScreen'),
      ),
      floatingActionButton: CustomSpeedDial(
        children: [
          SpeedDialChild(
            child: const Icon(Icons.logout, color: Colors.white),
            labelWidget: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                "PENE",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            backgroundColor: const Color.fromARGB(255, 1, 165, 165),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
