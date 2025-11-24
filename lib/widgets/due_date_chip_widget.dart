import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final isToday = todo.dueDate!.month == DateTime.now().month &&
        todo.dueDate!.day == DateTime.now().day;

    Color chipColor;
    if (isOverdue) {
      chipColor = AppColors.error;
    } else if (isToday) {
      chipColor = AppColors.warning;
    } else {
      chipColor = AppColors.primary;
    }

    final formattedDate = DateFormat('d MMMM', 'ru_RU').format(todo.dueDate!);

    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 0, top: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today,
              size: 12,
              color: AppColors.statusToDo,
            ),
            const SizedBox(width: 6),
            Text(
              formattedDate,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.statusToDo,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
