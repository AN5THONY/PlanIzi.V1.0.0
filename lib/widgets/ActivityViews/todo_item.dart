import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/todo_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class TodoItem extends StatelessWidget {

  final TodoData todo;

  const TodoItem({super.key, 
    required this.todo
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        onTap: () {
          print('Clicking Todo');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: AppColors.cardBackground,
        leading: Icon(todo.isDone? Icons.check_box : Icons.check_box_outline_blank, color: AppColors.primary,), 
        title: Text( todo.todoText! , style: TextStyle( fontSize: 16, color: AppColors.textPrimary, decoration: todo.isDone? TextDecoration.lineThrough : null,)),
        trailing: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: AppColors.error,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton( color: AppColors.cardBackground,onPressed: () {
            
          }, icon: const Icon(Icons.delete), iconSize: 18,), 
        ),
      ),
    );
  }
}