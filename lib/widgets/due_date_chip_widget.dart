import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';

class DueDateChipWidget extends StatelessWidget {
  final Todo todo;

  const DueDateChipWidget({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    if (todo.dueDate == null) {
      return const SizedBox.shrink();
    }

    final isOverdue = todo.isOverdue;
    final isToday = todo.dueDate != null &&
        todo.dueDate!.year == DateTime.now().year &&
        todo.dueDate!.month == DateTime.now().month &&
        todo.dueDate!.day == DateTime.now().day;

    Color chipColor;
    if (isOverdue) {
      chipColor = AppColors.error;
    } else if (isToday) {
      chipColor = AppColors.warning;
    } else {
      chipColor = AppColors.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: chipColor),
      ),
      child: Text(
        todo.formattedDueDate,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: chipColor,
        ),
      ),
    );
  }
}