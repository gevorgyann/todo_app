import 'todo_event.dart';

class AddTodo extends TodoEvent {
  final String title;
  final String description;
  final DateTime? dueDate;

  const AddTodo({
    required this.title,
    this.description = '',
    this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate];
}