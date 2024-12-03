import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/premium_option_model.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/PremiumWidgets/premium_cola.dart';
import 'package:plan_izi_v2/widgets/PremiumWidgets/premium_option.dart';


class PluPrimium extends StatelessWidget {

  final List<PremiumOptionModel> options = [
    PremiumOptionModel(
      months: 1,
      price: 10.99,
      description: '1 mes',
      discount: '',
      isHighlighted: false,
    ),
      PremiumOptionModel(
      months: 6,
      price: 83.40,
      description: '3 meses gratis',
      discount: '20% desc.',
      isHighlighted: true,
    ),
    PremiumOptionModel(
      months: 12,
      price: 116.76,
      description: '4 meses gratis',
      discount: '30% desc.',
      isHighlighted: true,
    ),
  ];
  PluPrimium({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const PremiumCola(),
            ...options.map((option) => PremiumOption(option: option)),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/4/4f/Escudo_UNFV.png', 
                    height: 40,
                  ),
                  const SizedBox(width: 40),
                  Image.network(
                    'https://web.unfv.edu.pe/facultades/fiei/images/logo_fiei_2021.png',
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}