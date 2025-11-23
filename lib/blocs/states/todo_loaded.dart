import 'todo_state.dart';
import '../../models/todo.dart';

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final TodoStatus selectedStatus;
  final String searchQuery;

  const TodoLoaded({
    required this.todos,
    this.selectedStatus = TodoStatus.toDo,
    this.searchQuery = '',
  });

  List<Todo> get filteredTodos {
    if (searchQuery.isEmpty) {
      return todos;
    }

    final lowercaseQuery = searchQuery.toLowerCase();
    return todos.where((todo) {
      return todo.title.toLowerCase().contains(lowercaseQuery) ||
             todo.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  Map<TodoStatus, List<Todo>> get todosGroupedByStatus {
    final Map<TodoStatus, List<Todo>> grouped = {};
    final todosToGroup = searchQuery.isEmpty ? todos : filteredTodos;

    for (final status in TodoStatus.values) {
      grouped[status] = todosToGroup.where((todo) => todo.status == status).toList();
    }
    return grouped;
  }

  List<Todo> get todosByCurrentStatus =>
      filteredTodos.where((todo) => todo.status == selectedStatus).toList();

  int getTodoCountByStatus(TodoStatus status) {
    return filteredTodos.where((todo) => todo.status == status).length;
  }

  List<Todo> get overdueTodos => filteredTodos.where((todo) => todo.isOverdue).toList();

  bool get hasOverdueTodos => overdueTodos.isNotEmpty;

  int get totalTodoCount => filteredTodos.length;

  double getProgressByStatus(TodoStatus status) {
    final statusTodos = filteredTodos.where((todo) => todo.status == status).length;
    return totalTodoCount > 0 ? statusTodos / totalTodoCount : 0.0;
  }

  TodoLoaded copyWith({
    List<Todo>? todos,
    TodoStatus? selectedStatus,
    String? searchQuery,
  }) {
    return TodoLoaded(
      todos: todos ?? this.todos,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [todos, selectedStatus, searchQuery];
}