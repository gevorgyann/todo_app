import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';

class StatusIndicatorWidget extends StatelessWidget {
  final TodoStatus status;

  const StatusIndicatorWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color indicatorColor;
    IconData icon;

    switch (status) {
      case TodoStatus.toDo:
        indicatorColor = AppColors.statusToDo;
        icon = Icons.radio_button_unchecked;
        break;
      case TodoStatus.inProgress:
        indicatorColor = AppColors.statusInProgress;
        icon = Icons.schedule;
        break;
      case TodoStatus.inReview:
        indicatorColor = AppColors.statusInReview;
        icon = Icons.visibility;
        break;
      case TodoStatus.completed:
        indicatorColor = AppColors.statusCompleted;
        icon = Icons.check_circle;
        break;
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: indicatorColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: indicatorColor, width: 1),
      ),
      child: Icon(
        icon,
        size: 16,
        color: indicatorColor,
      ),
    );
  }
}