
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/bag.dart';


class SubcriptionsScreen extends StatefulWidget {
  const SubcriptionsScreen({super.key});

  @override
  State<SubcriptionsScreen> createState() => _SubcriptionsScreenState();
}

class _SubcriptionsScreenState extends State<SubcriptionsScreen> {
  List<Bag> bags = listOfBags();
  List<String> heroImages = [
    "https://static.mercadonegro.pe/wp-content/uploads/2022/07/22162714/Iconico-IncaKola-2021-1-scaled.jpg",
    "https://www.heyhunters.com/wp-content/uploads/2022/07/web-HH-IK-IG-behance2-01.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider.builder(
              itemCount: heroImages.length,
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              itemBuilder: (context, index, realIndex) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(heroImages[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
