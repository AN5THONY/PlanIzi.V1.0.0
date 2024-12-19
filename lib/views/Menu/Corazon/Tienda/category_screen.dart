import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/bag.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Menu/Corazon/Tienda/perfil_shop_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String categoryTitle;
  final List<Bag> filteredBags;

  const CategoryScreen({
    super.key,
    required this.categoryTitle,
    required this.filteredBags,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'PlanIzi',
          style: TextStyle(
            fontSize: 50,
            color: AppColors.fourth,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Nombre de la categoría
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                categoryTitle,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ),

            // Tiendas filtradas por categoría
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: 250,
                ),
                itemCount: filteredBags.length,
                itemBuilder: (context, index) {
                  final bag = filteredBags[index];
                  return GestureDetector(
                    onTap: () {
                      // Navegar al perfil de la tienda
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PerfilShopScreen(bag: bag),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            bag.imagePath,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            bag.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            bag.categoria,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
