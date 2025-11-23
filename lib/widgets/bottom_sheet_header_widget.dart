import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BottomSheetHeaderWidget extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onClose;

  const BottomSheetHeaderWidget({
    super.key,
    required this.isEditing,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          isEditing ? 'Редактирование задачи' : 'Создание задачи',
          style: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onClose,
          child: const Icon(
            Icons.close,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ),
      ],
    );
  }
}