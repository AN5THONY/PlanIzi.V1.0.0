import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class RadioButtonGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final ValueChanged<String> onChanged;

  const RadioButtonGroup({
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),),
        const SizedBox(height: 8,),
        ...options.map(
          (option) {
            return RadioListTile(
              value: option, 
              groupValue: selectedOption,
              onChanged: (value){
                if (value != null) {
                  onChanged(value);
                } 
              },
              activeColor: AppColors.third,
              );
          },
        )
        
      ],
    );
  }
}