import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';
import 'delete_confirmation_dialog.dart';
import 'todo_content_widget.dart';

class TodoSlidableContentWidget extends StatelessWidget {
  final Todo todo;
  final Function(Todo) onEdit;
  final Function(String) onDelete;
  final Function(String, TodoStatus) onStatusChange;

  const TodoSlidableContentWidget({
    super.key,
    required this.todo,
    required this.onEdit,
    required this.onDelete,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(todo.id),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => onEdit(todo),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Изменить',
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
          ),
          SlidableAction(
            onPressed: (_) => DeleteConfirmationDialog.show(
              context,
              todo,
              () => onDelete(todo.id),
            ),
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
            borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 1.0),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: TodoContentWidget(
          todo: todo,
          onStatusChange: onStatusChange,
        ),
      ),
    );
  }
}