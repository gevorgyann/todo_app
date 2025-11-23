import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../widgets/status_header_widget.dart';
import '../widgets/todo_item.dart';
import '../utils/app_colors.dart';

class StatusSectionWidget extends StatelessWidget {
  final TodoStatus status;
  final List<Todo> todos;
  final int todoCount;
  final Function(String) onToggle;
  final Function(String) onDelete;
  final Function(Todo) onEdit;
  final Function(String, TodoStatus) onStatusChange;

  const StatusSectionWidget({
    super.key,
    required this.status,
    required this.todos,
    required this.todoCount,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: DragTarget<Todo>(
        onWillAcceptWithDetails: (details) => details.data.status != status,
        onAcceptWithDetails: (details) => onStatusChange(details.data.id, status),
        builder: (context, candidateData, rejectedData) {
          final bool isAccepting = candidateData.isNotEmpty;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(isAccepting ? 8.0 : 0.0),
            decoration: BoxDecoration(
              color: isAccepting
                  ? _getStatusColor(status).withValues(alpha: 0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: isAccepting
                  ? Border.all(
                      color: _getStatusColor(status).withValues(alpha: 0.5),
                      width: 2,
                    )
                  : null,
            ),
            child: Column(
              children: [
                StatusHeaderWidget(
                  status: status,
                  count: todoCount,
                ),
                if (isAccepting && todos.isEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getStatusColor(status).withValues(alpha: 0.3),
                        width: 1,
                        strokeAlign: BorderSide.strokeAlignInside,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: _getStatusColor(status),
                            size: 20,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Перетащите сюда',
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: _getStatusColor(status),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
                if (todos.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  ...todos.map(
                    (todo) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: TodoItemWidget(
                        todo: todo,
                        onToggle: onToggle,
                        onDelete: onDelete,
                        onEdit: onEdit,
                        onStatusChange: onStatusChange,
                      ),
                    ),
                  ),
                ],
                if (isAccepting && todos.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    height: 40,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: _getStatusColor(status).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _getStatusColor(status).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Перетащите сюда для изменения статуса',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _getStatusColor(status),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(TodoStatus status) {
    switch (status) {
      case TodoStatus.toDo:
        return AppColors.statusToDo;
      case TodoStatus.inProgress:
        return AppColors.statusInProgress;
      case TodoStatus.inReview:
        return AppColors.statusInReview;
      case TodoStatus.completed:
        return AppColors.statusCompleted;
    }
  }
}