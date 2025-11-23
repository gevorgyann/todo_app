import 'todo_event.dart';
import '../../models/todo.dart';

class SetSelectedStatus extends TodoEvent {
  final TodoStatus status;

  const SetSelectedStatus(this.status);

  @override
  List<Object?> get props => [status];
}