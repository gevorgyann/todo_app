import 'todo_event.dart';

class SearchTodos extends TodoEvent {
  final String query;

  const SearchTodos(this.query);

  @override
  List<Object?> get props => [query];
}