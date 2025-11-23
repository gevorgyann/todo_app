import '../models/todo.dart';
import 'local_storage_service.dart';

class TodoRepository {
  final LocalStorageService _localStorageService = LocalStorageService.instance;

  Future<List<Todo>> getAllTodos() async {
    return await _localStorageService.loadTodos();
  }

  Future<List<Todo>> getTodosByStatus(TodoStatus status) async {
    return await _localStorageService.getTodosByStatus(status);
  }

  Future<Todo?> getTodoById(String id) async {
    return await _localStorageService.getTodoById(id);
  }

  Future<bool> addTodo({
    required String title,
    String description = '',
    TodoStatus status = TodoStatus.toDo,
    DateTime? dueDate,
  }) async {
    final now = DateTime.now();
    final todo = Todo(
      id: now.millisecondsSinceEpoch.toString(),
      title: title.trim(),
      description: description.trim(),
      status: status,
      createdAt: now,
      updatedAt: now,
      dueDate: dueDate,
    );

    return await _localStorageService.saveTodo(todo);
  }

  Future<bool> updateTodo({
    required String id,
    String? title,
    String? description,
    TodoStatus? status,
    DateTime? dueDate,
  }) async {
    final existingTodo = await _localStorageService.getTodoById(id);
    if (existingTodo == null) return false;

    final updatedTodo = existingTodo.copyWith(
      title: title?.trim() ?? existingTodo.title,
      description: description?.trim() ?? existingTodo.description,
      status: status ?? existingTodo.status,
      dueDate: dueDate,
      updatedAt: DateTime.now(),
    );

    return await _localStorageService.saveTodo(updatedTodo);
  }

  Future<bool> deleteTodo(String id) async {
    return await _localStorageService.deleteTodo(id);
  }

  Future<bool> updateTodoStatus(String id, TodoStatus newStatus) async {
    return await _localStorageService.updateTodoStatus(id, newStatus);
  }

  Future<bool> toggleTodoCompletion(String id) async {
    final todo = await _localStorageService.getTodoById(id);
    if (todo == null) return false;

    final newStatus = todo.status == TodoStatus.completed
        ? TodoStatus.toDo
        : TodoStatus.completed;

    return await updateTodoStatus(id, newStatus);
  }

  Future<bool> clearAllTodos() async {
    return await _localStorageService.clearAllTodos();
  }

  Future<List<Todo>> searchTodos(String query) async {
    if (query.trim().isEmpty) return await getAllTodos();

    final todos = await getAllTodos();
    final lowercaseQuery = query.toLowerCase().trim();

    return todos.where((todo) {
      return todo.title.toLowerCase().contains(lowercaseQuery) ||
             todo.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }

  Future<Map<TodoStatus, List<Todo>>> getTodosGroupedByStatus() async {
    final todos = await getAllTodos();
    final Map<TodoStatus, List<Todo>> grouped = {};

    for (final status in TodoStatus.values) {
      grouped[status] = todos.where((todo) => todo.status == status).toList();
    }

    return grouped;
  }

  Future<int> getTodoCount() async {
    final todos = await getAllTodos();
    return todos.length;
  }

  Future<int> getTodoCountByStatus(TodoStatus status) async {
    final todos = await getTodosByStatus(status);
    return todos.length;
  }

  Future<List<Todo>> getOverdueTodos() async {
    final todos = await getAllTodos();
    return todos.where((todo) => todo.isOverdue).toList();
  }

  Future<bool> moveTodoToStatus(String id, TodoStatus newStatus) async {
    return await updateTodoStatus(id, newStatus);
  }
}