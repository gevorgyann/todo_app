import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';

class PriorityIndicatorWidget extends StatelessWidget {
  final Todo todo;

  const PriorityIndicatorWidget({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    Color priorityColor = AppColors.priorityHigh;

    if (todo.isOverdue) {
      priorityColor = AppColors.error;
    } else if (todo.dueDate != null) {
      final daysDifference = todo.dueDate!.difference(DateTime.now()).inDays;
      if (daysDifference <= 1) {
        priorityColor = AppColors.priorityMedium;
      } else if (daysDifference <= 3) {
        priorityColor = AppColors.warning;
      } else {
        priorityColor = AppColors.priorityLow;
      }
    }

    return Container();
  }
}

