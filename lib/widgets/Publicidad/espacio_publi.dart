import 'package:flutter/material.dart';

class EspacioPublicidad extends StatelessWidget {
  const EspacioPublicidad({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Column(
        children: [
          Text(
            'Publicidad',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            'No colaborador',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
