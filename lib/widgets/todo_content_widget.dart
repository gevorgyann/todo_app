import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';
import 'status_indicator_widget.dart';
import 'priority_indicator_widget.dart';
import 'due_date_chip_widget.dart';
import 'overdue_chip_widget.dart';
import 'status_change_dialog.dart';

class TodoContentWidget extends StatelessWidget {
  final Todo todo;
  final Function(String, TodoStatus) onStatusChange;

  const TodoContentWidget({
    super.key,
    required this.todo,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => StatusChangeDialog.show(
          context,
          todo,
          (status) => onStatusChange(todo.id, status),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatusIndicatorWidget(status: todo.status),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            todo.title,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: todo.status == TodoStatus.completed
                                  ? AppColors.textSecondary
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (todo.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        todo.description,
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (todo.dueDate != null) ...[
                      const SizedBox(height: 8),
                      DueDateChipWidget(todo: todo),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      '${todo.createdAt.hour}:${todo.createdAt.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  PriorityIndicatorWidget(todo: todo),
                  const SizedBox(height: 4),
                  OverdueChipWidget(todo: todo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}