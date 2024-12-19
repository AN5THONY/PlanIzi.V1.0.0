

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';


// ignore: non_constant_identifier_names
Widget CarouselMain() {

  
 
  List<String> heroImages = [
    "https://static.mercadonegro.pe/wp-content/uploads/2022/07/22162714/Iconico-IncaKola-2021-1-scaled.jpg",
    "https://www.heyhunters.com/wp-content/uploads/2022/07/web-HH-IK-IG-behance2-01.jpg",
  ];

  return  Stack(
    children: [
      CarouselSlider.builder(
                  itemCount: heroImages.length,
                  options: CarouselOptions(
                    height: 250.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
      
                        image: DecorationImage(
                          image: NetworkImage(heroImages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("OFERTAS DEL DÍA", style: GoogleFonts.playfairDisplay(fontSize:  22,backgroundColor: AppColors.cardBackground, fontWeight: FontWeight.bold),),
                          )
                        ],
                      ),
                      
                    );
                  },
                ),
    ],
  );
}