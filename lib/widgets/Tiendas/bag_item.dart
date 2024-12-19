import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/bag.dart';

class BagItem extends StatelessWidget {
  final Bag bag;
  final VoidCallback onTap;

  const BagItem({
    super.key,
    required this.bag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen de la tienda
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  bag.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Nombre de la tienda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                bag.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 4),
            // Categoría de la tienda
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                bag.categoria,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
