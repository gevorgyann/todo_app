import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ActionButtonsWidget extends StatelessWidget {
  final ValueNotifier<bool> canSaveNotifier;
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ActionButtonsWidget({
    super.key,
    required this.canSaveNotifier,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: canSaveNotifier,
      builder: (context, canSave, child) {
        return Row(
          children: [
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.buttonDisabled,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: onCancel,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Отменить',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: canSave
                      ? AppColors.primary
                      : AppColors.primaryWithOpacity40,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: canSave ? onSave : null,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Применить',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}