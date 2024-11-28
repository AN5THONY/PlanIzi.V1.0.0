import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/todo_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/widgets/ActivityViews/todo_item.dart';


class HomeScreen extends StatelessWidget {

  final todosList = TodoData.todoList();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
        color: AppColors.background,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical:15),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom:20),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  decoration:  BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Actividades de Hoy', style: TextStyle( fontSize: 30, color: AppColors.textPrimary, fontWeight: FontWeight.bold) ,),
                ),
                for ( TodoData todoo in todosList ) 
                TodoItem(todo: todoo,),
                

              ],
            ),
          )
        ],
      )
    );
    
  }
}