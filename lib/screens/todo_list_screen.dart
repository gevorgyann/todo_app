import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo.dart';
import '../blocs/todo_bloc.dart';
import '../blocs/events/load_todos.dart';
import '../blocs/events/add_todo.dart';
import '../blocs/events/update_todo.dart';
import '../blocs/events/delete_todo.dart';
import '../blocs/events/toggle_todo_completion.dart';
import '../blocs/events/move_todo_to_status.dart';
import '../blocs/states/todo_state.dart';
import '../blocs/states/todo_loading.dart';
import '../blocs/states/todo_error.dart';
import '../blocs/states/todo_loaded.dart';
import '../widgets/status_section_widget.dart';
import '../widgets/add_edit_todo_bottom_sheet.dart';
import '../widgets/loading_state_widget.dart';
import '../widgets/error_state_widget.dart';
import '../utils/app_colors.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoBloc>().add(const LoadTodos());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.background,
        title: Text(
          'Todo',
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                icon: const Icon(Icons.add, color: Colors.white, size: 24),
                onPressed: _showAddTodoBottomSheet,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.error),
            );
          }
        },
        builder: (context, state) {
          if (state is TodoLoading) {
            return const LoadingStateWidget();
          }

          if (state is TodoError) {
            return ErrorStateWidget(
              errorMessage: state.message,
              onRetry: () => context.read<TodoBloc>().add(const LoadTodos()),
            );
          }

          if (state is TodoLoaded) {
            final todosGrouped = state.todosGroupedByStatus;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: TodoStatus.values.map((status) {
                  final statusTodos = todosGrouped[status] ?? [];
                  return StatusSectionWidget(
                    status: status,
                    todos: statusTodos,
                    onToggle: (id) => context.read<TodoBloc>().add(ToggleTodoCompletion(id)),
                    onDelete: (id) => context.read<TodoBloc>().add(DeleteTodo(id)),
                    onEdit: (todo) => _showEditTodoBottomSheet(todo),
                    onStatusChange: (id, newStatus) =>
                        context.read<TodoBloc>().add(MoveTodoToStatus(id, newStatus)),
                    todoCount: state.getTodoCountByStatus(status),
                  );
                }).toList(),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _showAddTodoBottomSheet() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddEditTodoBottomSheet(),
    );

    if (result != null && mounted) {
      context.read<TodoBloc>().add(
        AddTodo(
          title: result['title'] as String,
          description: result['description'] as String? ?? '',
          dueDate: result['dueDate'] as DateTime?,
        ),
      );
    }
  }

  Future<void> _showEditTodoBottomSheet(Todo todo) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddEditTodoBottomSheet(todo: todo),
    );

    if (result != null && mounted) {
      context.read<TodoBloc>().add(
        UpdateTodo(
          id: todo.id,
          title: result['title'] as String,
          description: result['description'] as String? ?? '',
          dueDate: result['dueDate'] as DateTime?,
        ),
      );
    }
  }
}
