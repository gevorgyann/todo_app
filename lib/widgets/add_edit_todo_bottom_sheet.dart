import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../utils/app_colors.dart';
import 'bottom_sheet_header_widget.dart';
import 'title_field_widget.dart';
import 'date_picker_field_widget.dart';
import 'action_buttons_widget.dart';

class AddEditTodoBottomSheet extends StatefulWidget {
  final Todo? todo;

  const AddEditTodoBottomSheet({super.key, this.todo});

  @override
  State<AddEditTodoBottomSheet> createState() => _AddEditTodoBottomSheetState();
}

class _AddEditTodoBottomSheetState extends State<AddEditTodoBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  late final ValueNotifier<DateTime?> _selectedDueDateNotifier;
  late final ValueNotifier<bool> _canSaveNotifier;

  @override
  void initState() {
    super.initState();
    _selectedDueDateNotifier = ValueNotifier<DateTime?>(widget.todo?.dueDate);
    _canSaveNotifier = ValueNotifier<bool>(false);

    if (widget.todo != null) {
      _titleController.text = widget.todo!.title;
    }

    _titleController.addListener(_updateCanSave);
    _selectedDueDateNotifier.addListener(_updateCanSave);
    _updateCanSave();
  }

  void _updateCanSave() {
    final hasTitle = _titleController.text.trim().isNotEmpty;
    final hasDate = _selectedDueDateNotifier.value != null;
    _canSaveNotifier.value = hasTitle && hasDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _selectedDueDateNotifier.dispose();
    _canSaveNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.todo != null;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BottomSheetHeaderWidget(
                  isEditing: isEditing,
                  onClose: () => Navigator.of(context).pop(),
                ),
                const SizedBox(height: 20),
                TitleFieldWidget(controller: _titleController, onChanged: _updateCanSave),
                const SizedBox(height: 16),
                DatePickerFieldWidget(
                  selectedDateNotifier: _selectedDueDateNotifier,
                  onDateChanged: _updateCanSave,
                ),
                const SizedBox(height: 24),
                ActionButtonsWidget(
                  canSaveNotifier: _canSaveNotifier,
                  onCancel: () => Navigator.of(context).pop(),
                  onSave: _saveTodo,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveTodo() {
    if (_formKey.currentState!.validate() && _selectedDueDateNotifier.value != null) {
      final result = {
        'title': _titleController.text.trim(),
        'description': '',
        'dueDate': _selectedDueDateNotifier.value,
      };

      Navigator.of(context).pop(result);
    }
  }
}
