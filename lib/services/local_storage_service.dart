import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class LocalStorageService {
  static const String _todosKey = 'todos';
  static LocalStorageService? _instance;
  SharedPreferences? _prefs;

  LocalStorageService._();

  static LocalStorageService get instance {
    _instance ??= LocalStorageService._();
    return _instance!;
  }

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  Future<List<Todo>> loadTodos() async {
    try {
      await init();
      final String? todosJson = _prefs?.getString(_todosKey);

      if (todosJson == null || todosJson.isEmpty) {
        return [];
      }

      final List<dynamic> decodedJson = jsonDecode(todosJson);
      final List<Todo> todos = decodedJson
          .map((json) => Todo.fromJson(json as Map<String, dynamic>))
          .toList();

      return todos;
    } catch (e) {
      return [];
    }
  }

  Future<bool> saveTodos(List<Todo> todos) async {
    try {
      await init();
      final List<Map<String, dynamic>> todosJson =
          todos.map((todo) => todo.toJson()).toList();

      final String encodedJson = jsonEncode(todosJson);
      final bool result = await _prefs?.setString(_todosKey, encodedJson) ?? false;

      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearAllTodos() async {
    try {
      await init();
      final bool result = await _prefs?.remove(_todosKey) ?? false;
      return result;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveTodo(Todo todo) async {
    try {
      final List<Todo> todos = await loadTodos();
      final int existingIndex = todos.indexWhere((t) => t.id == todo.id);

      if (existingIndex >= 0) {
        todos[existingIndex] = todo;
      } else {
        todos.add(todo);
      }

      return await saveTodos(todos);
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteTodo(String id) async {
    try {
      final List<Todo> todos = await loadTodos();
      todos.removeWhere((todo) => todo.id == id);
      return await saveTodos(todos);
    } catch (e) {
      return false;
    }
  }

  Future<Todo?> getTodoById(String id) async {
    try {
      final List<Todo> todos = await loadTodos();
      return todos.where((todo) => todo.id == id).firstOrNull;
    } catch (e) {
      return null;
    }
  }

  Future<List<Todo>> getTodosByStatus(TodoStatus status) async {
    try {
      final List<Todo> todos = await loadTodos();
      return todos.where((todo) => todo.status == status).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> updateTodoStatus(String id, TodoStatus newStatus) async {
    try {
      final List<Todo> todos = await loadTodos();
      final int index = todos.indexWhere((todo) => todo.id == id);

      if (index >= 0) {
        final Todo updatedTodo = todos[index].copyWith(
          status: newStatus,
          updatedAt: DateTime.now(),
        );
        todos[index] = updatedTodo;
        return await saveTodos(todos);
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}