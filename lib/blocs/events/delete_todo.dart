import 'todo_event.dart';

class DeleteTodo extends TodoEvent {
  final String id;

  const DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}