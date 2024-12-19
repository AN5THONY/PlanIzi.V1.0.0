import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget CarouselCategories({required Function(String) onCategoryTap}) {
  List<Map<String, String>> categories = [
    {
      "image": "https://cdn-icons-png.flaticon.com/512/3703/3703377.png",
      "title": "FastFood"
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/4409/4409116.png",
      "title": "Salud"
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/920/920582.png",
      "title": "Licores"
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/4257/4257812.png",
      "title": "Tecnología"
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/1198/1198317.png",
      "title": "Mueble"
    },
    {
      "image": "https://cdn-icons-png.flaticon.com/512/1198/1198307.png",
      "title": "Moda"
    },
  ];

  // Agrupar categorías en lotes de 3
  List<List<Map<String, String>>> groupedCategories = [];
  for (int i = 0; i < categories.length; i += 3) {
    groupedCategories.add(categories.sublist(
        i, i + 3 > categories.length ? categories.length : i + 3));
  }

  return CarouselSlider(
    options: CarouselOptions(
      height: 180,
      autoPlay: false,
      enlargeCenterPage: false,
      viewportFraction: 0.99,
      enableInfiniteScroll: false,
      pageSnapping: false,
      scrollPhysics: const BouncingScrollPhysics(),
    ),
    items: groupedCategories.map((group) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: group.map((category) {
          return GestureDetector(
            onTap: () => onCategoryTap(category['title']!), // Llamar al callback con el título de la categoría
            child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      category['image']!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    category['title']!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      );
    }).toList(),
  );
}
