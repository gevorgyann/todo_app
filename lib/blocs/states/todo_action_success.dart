import 'todo_state.dart';

class TodoActionSuccess extends TodoState {
  final String message;

  const TodoActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}