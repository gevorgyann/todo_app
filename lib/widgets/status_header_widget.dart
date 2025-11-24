import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';

class StatusHeaderWidget extends StatelessWidget {
  final TodoStatus status;
  final int count;

  const StatusHeaderWidget({
    super.key,
    required this.status,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: const Color(0x14000809),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
          BoxShadow(
            color: const Color(0x05000809),
            blurRadius: 6,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            status.displayName,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Text(
            '$count',
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ],
      ),
    );
  }
}