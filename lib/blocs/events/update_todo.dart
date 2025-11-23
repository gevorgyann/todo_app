import 'todo_event.dart';
import '../../models/todo.dart';

class UpdateTodo extends TodoEvent {
  final String id;
  final String? title;
  final String? description;
  final TodoStatus? status;
  final DateTime? dueDate;

  const UpdateTodo({
    required this.id,
    this.title,
    this.description,
    this.status,
    this.dueDate,
  });

  @override
  List<Object?> get props => [id, title, description, status, dueDate];
}