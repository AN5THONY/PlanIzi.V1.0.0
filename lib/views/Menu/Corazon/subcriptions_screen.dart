import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_izi_v2/models/bag.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/Tiendas/bag_item.dart';



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
    return SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),

            Center(child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(color: AppColors.cardBackground),
              child: CarouselMain())),


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20.0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bags.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 280,
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 24),
                itemBuilder: (context, index){
                  return BagItem(bag: bags[index]);
                }
              ),
            )
        
          ],
      ),
      
    );
  }


// ignore: non_constant_identifier_names
Widget CarouselMain() {
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
}