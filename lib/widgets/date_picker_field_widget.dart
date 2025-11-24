import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/app_colors.dart';

class DatePickerFieldWidget extends StatefulWidget {
  final ValueNotifier<DateTime?> selectedDateNotifier;
  final VoidCallback onDateChanged;

  const DatePickerFieldWidget({
    super.key,
    required this.selectedDateNotifier,
    required this.onDateChanged,
  });

  @override
  State<DatePickerFieldWidget> createState() => _DatePickerFieldWidgetState();
}

class _DatePickerFieldWidgetState extends State<DatePickerFieldWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        ValueListenableBuilder<DateTime?>(
          valueListenable: widget.selectedDateNotifier,
          builder: (context, selectedDate, child) {
            return TextFormField(
              focusNode: _focusNode,
              readOnly: true,
              onTap: () => _selectDueDate(context),
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
              decoration:  InputDecoration(
                labelText: isFocused ? 'Дата завершения' : 'Выберите',
                labelStyle: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isFocused ? AppColors.textPrimary : AppColors.textHint,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.border, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.border, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primary, width: 2),
              ),
              filled: true,
              fillColor: AppColors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                suffixIcon: GestureDetector(
                  onTap: () => _selectDueDate(context),
                  child: Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.statusToDo,
                    size: 24,
                  ),
                ),
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
      initialDate: widget.selectedDateNotifier.value ?? now,
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
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != widget.selectedDateNotifier.value) {
      widget.selectedDateNotifier.value = picked;
      widget.onDateChanged();
    }
  }
}
