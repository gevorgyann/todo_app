import 'todo_event.dart';

class ToggleTodoCompletion extends TodoEvent {
  final String id;

  const ToggleTodoCompletion(this.id);

  @override
  List<Object?> get props => [id];
}