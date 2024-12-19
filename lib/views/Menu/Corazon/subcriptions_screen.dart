import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/bag.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Menu/Corazon/Tienda/category_screen.dart';
import 'package:plan_izi_v2/views/Menu/Corazon/Tienda/perfil_shop_screen.dart';
import 'package:plan_izi_v2/widgets/Carousel/carousel_cate.dart';
import 'package:plan_izi_v2/widgets/Carousel/carousel_main.dart';
import 'package:plan_izi_v2/widgets/Tiendas/bag_item.dart';

class SubcriptionsScreen extends StatefulWidget {
  const SubcriptionsScreen({super.key});

  @override
  State<SubcriptionsScreen> createState() => _SubcriptionsScreenState();
}

class _SubcriptionsScreenState extends State<SubcriptionsScreen> {
  List<Bag> bags = listOfBags();

  void onBagTap(Bag bag) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PerfilShopScreen(bag: bag,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Carrusel principal
          CarouselMain(),

          const SizedBox(height: 10),

          // Sección Categorías
          const Text(
            'Categorías',
            style: TextStyle(
              fontSize: 25,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
         SizedBox(
            height: 200, // Altura fija para el carrusel de categorías
            child: CarouselCategories(
              onCategoryTap: (selectedCategory) {
                // Obtener las tiendas filtradas por categoría
                final filteredBags = bags
                    .where((bag) => bag.categoria == selectedCategory)
                    .toList();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                      categoryTitle: selectedCategory,
                      filteredBags: filteredBags,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),

          // Sección Tiendas
          const Text(
            'Tiendas',
            style: TextStyle(
              fontSize: 25,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),

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
                mainAxisSpacing: 24,
              ),
              itemBuilder: (context, index) {
                return BagItem(
                  bag: bags[index],
                  onTap: () => onBagTap(bags[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
