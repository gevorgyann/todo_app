import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';

class StatusChangeDialog extends StatelessWidget {
  final Todo todo;
  final Function(TodoStatus) onStatusChange;

  const StatusChangeDialog({
    super.key,
    required this.todo,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      title: const Text(
        'Изменить статус',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: TodoStatus.values.map((status) {
          return ListTile(
            title: Text(
              status.displayName,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
            leading: Icon(
              todo.status == status ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: AppColors.primary,
            ),
            onTap: () {
              Navigator.of(context).pop();
              onStatusChange(status);
            },
          );
        }).toList(),
      ),
    );
  }

  static void show(BuildContext context, Todo todo, Function(TodoStatus) onStatusChange) {
    showDialog(
      context: context,
      builder: (context) => StatusChangeDialog(
        todo: todo,
        onStatusChange: onStatusChange,
      ),
    );
  }
}