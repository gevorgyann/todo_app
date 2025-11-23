import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';

class OverdueChipWidget extends StatelessWidget {
  final Todo todo;

  const OverdueChipWidget({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    if (!todo.isOverdue) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0,
      ),
      decoration: BoxDecoration(
        color: Colors.red.shade600,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Просрочено',
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}