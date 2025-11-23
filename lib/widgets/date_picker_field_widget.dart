import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';

class DatePickerFieldWidget extends StatelessWidget {
  final ValueNotifier<DateTime?> selectedDateNotifier;
  final VoidCallback onDateChanged;

  const DatePickerFieldWidget({
    super.key,
    required this.selectedDateNotifier,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        ValueListenableBuilder<DateTime?>(
          valueListenable: selectedDateNotifier,
          builder: (context, selectedDate, child) {
            return TextFormField(
              readOnly: true,
              onTap: () => _selectDueDate(context),
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                labelText: 'Дата завершения',
                hintText: 'Выберите дату',
                labelStyle: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
                hintStyle: const TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.border,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.border,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: AppColors.surface,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                prefixIcon: Icon(
                  Icons.calendar_today_outlined,
                  color: selectedDate != null
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  size: 20,
                ),
                suffixIcon: selectedDate != null
                    ? GestureDetector(
                        onTap: () {
                          selectedDateNotifier.value = null;
                          onDateChanged();
                        },
                        child: const Icon(
                          Icons.clear,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      )
                    : null,
              ),
              controller: TextEditingController(
                text: selectedDate != null
                    ? DateFormat('dd.MM.yyyy').format(selectedDate)
                    : '',
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateNotifier.value ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
      helpText: 'Выберите дату завершения',
      cancelText: 'Отмена',
      confirmText: 'Выбрать',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(
            useMaterial3: true,
          ).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              surface: AppColors.surface,
              onSurface: AppColors.textPrimary,
              surfaceContainerHighest: AppColors.surfaceVariant,
              outline: AppColors.border,
              onSurfaceVariant: AppColors.textSecondary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: const TextStyle(
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            textTheme: Theme.of(context).textTheme.copyWith(
              headlineLarge: const TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w500,
              ),
              bodyLarge: const TextStyle(
                fontFamily: 'Manrope',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDateNotifier.value) {
      selectedDateNotifier.value = picked;
      onDateChanged();
    }
  }
}