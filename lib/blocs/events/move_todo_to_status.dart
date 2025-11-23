import 'todo_event.dart';
import '../../models/todo.dart';

class MoveTodoToStatus extends TodoEvent {
  final String id;
  final TodoStatus newStatus;

  const MoveTodoToStatus(this.id, this.newStatus);

  @override
  List<Object?> get props => [id, newStatus];
}