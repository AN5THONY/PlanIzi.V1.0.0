import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plan_izi_v2/models/bag.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class BagItem extends StatelessWidget {
  final Bag bag;
  const BagItem({
    required this.bag,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
                    color: AppColors.cardBackground,
                    child: Stack(
                      children: [
                    
                        const Positioned(
                          right: 1,
                          top: 1,
                          child: Padding(
                            padding: EdgeInsets.only(top: 6, right: 9),
                            child: Icon(Icons.shopping_cart, size: 30,),
                          )),
                        Positioned(
                          top: 35,
                          right: 0,
                          left: 0,
                          child: Column(
                            children: [
                              Image.network(bag.imagePath,
                                fit: BoxFit.contain,
                                width: 111,
                                height: 111,
                              ),
                              const SizedBox(height: 11,),
                              Text('Tienda xXx ', style: GoogleFonts.playfairDisplay(fontSize: 18, fontWeight: FontWeight.bold,),),
                              Container( height: 2, width: 100, decoration: const BoxDecoration(color: AppColors.backgroundback),),
                              const SizedBox(height: 18,),
                              Text('Description xxx', style: GoogleFonts.workSans(fontSize: 14, fontWeight: FontWeight.bold,)),
                             
                            ],
                        )),

                      ],
                    ),
                  );
  }
}