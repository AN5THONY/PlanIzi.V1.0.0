import 'package:flutter/material.dart';
import 'package:plan_izi_v2/models/todo_data.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';

class TodoItem extends StatelessWidget {
  final TodoData todo;
  final VoidCallback onTodoChanged; // Función para manejar el cambio de estado.
  final VoidCallback onTodoDeleted;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onTodoChanged,
    required this.onTodoDeleted,
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
        // Completar o desmarcar tarea
        onTap: onTodoChanged,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: AppColors.cardBackground,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: AppColors.primary,
        ),
        // Título rayado dinámicamente si está completado
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textPrimary,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Botón Completar/No completado
            TextButton(
              onPressed: onTodoChanged,
              style: TextButton.styleFrom(
                backgroundColor: todo.isDone ? Colors.orange : Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                todo.isDone ? "No completado" : "Completar",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            // Botón de eliminar
            Container(
              padding: const EdgeInsets.all(0),
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: AppColors.error,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                color: AppColors.cardBackground,
                onPressed: onTodoDeleted,
                icon: const Icon(Icons.delete),
                iconSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
