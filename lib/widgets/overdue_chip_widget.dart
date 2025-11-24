import 'package:flutter/material.dart';
import '../models/todo.dart';

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

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 90, 90, 1),
          borderRadius: BorderRadius.circular(4),
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
      ),
    );
  }
}