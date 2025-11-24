import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  final Todo todo;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    super.key,
    required this.todo,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text(
        'Удаление задачи',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      content: const Text(
        'Вы уверены, что хотите удалить эту задачу?',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w400,
          color: AppColors.textSecondary,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Отмена',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromRGBO(255, 90, 90, 1),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm();
          },
          child: const Text(
            'Удалить',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  static void show(BuildContext context, Todo todo, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        todo: todo,
        onConfirm: onConfirm,
      ),
    );
  }
}