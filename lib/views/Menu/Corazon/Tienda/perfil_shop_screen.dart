import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/bag.dart';

class PerfilShopScreen extends StatelessWidget {
  final Bag bag;

  const PerfilShopScreen({Key? key, required this.bag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(bag.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                bag.imagePath,
                height: 200,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Nombre: ${bag.name}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Categoría: ${bag.categoria}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
