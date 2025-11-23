import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';
import 'todo_slidable_content_widget.dart';
import 'todo_content_widget.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final Function(String) onToggle;
  final Function(String) onDelete;
  final Function(Todo) onEdit;
  final Function(String, TodoStatus) onStatusChange;

  const TodoItemWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable<Todo>(
      data: todo,
      feedback: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Opacity(
            opacity: 0.9,
            child: TodoContentWidget(
              todo: todo,
              onStatusChange: onStatusChange,
            ),
          ),
        ),
      ),
      childWhenDragging: Opacity(
        opacity: 0.3,
        child: TodoSlidableContentWidget(
        todo: todo,
        onEdit: onEdit,
        onDelete: onDelete,
        onStatusChange: onStatusChange,
      ),
      ),
      child: TodoSlidableContentWidget(
        todo: todo,
        onEdit: onEdit,
        onDelete: onDelete,
        onStatusChange: onStatusChange,
      ),
    );
  }


}