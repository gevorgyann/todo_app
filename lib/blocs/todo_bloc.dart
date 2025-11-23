import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/todo_repository.dart';
import '../models/todo.dart';
import 'events/todo_event.dart';
import 'events/load_todos.dart';
import 'events/add_todo.dart';
import 'events/update_todo.dart';
import 'events/delete_todo.dart';
import 'events/toggle_todo_completion.dart';
import 'events/move_todo_to_status.dart';
import 'events/search_todos.dart';
import 'events/clear_all_todos.dart';
import 'events/set_selected_status.dart';
import 'states/todo_state.dart';
import 'states/todo_initial.dart';
import 'states/todo_loading.dart';
import 'states/todo_loaded.dart';
import 'states/todo_error.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc({required TodoRepository repository})
      : _repository = repository,
        super(const TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<ToggleTodoCompletion>(_onToggleTodoCompletion);
    on<MoveTodoToStatus>(_onMoveTodoToStatus);
    on<SearchTodos>(_onSearchTodos);
    on<ClearAllTodos>(_onClearAllTodos);
    on<SetSelectedStatus>(_onSetSelectedStatus);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(const TodoLoading());
    try {
      final todos = await _repository.getAllTodos();
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError('Ошибка загрузки задач: ${e.toString()}'));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    if (event.title.trim().isEmpty) {
      emit(const TodoError('Название задачи не может быть пустым'));
      return;
    }

    try {
      final success = await _repository.addTodo(
        title: event.title,
        description: event.description,
        dueDate: event.dueDate,
      );

      if (success) {
        final todos = await _repository.getAllTodos();
        emit(TodoLoaded(todos: todos));
      } else {
        emit(const TodoError('Не удалось создать задачу'));
      }
    } catch (e) {
      emit(TodoError('Ошибка создания задачи: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    if (event.title != null && event.title!.trim().isEmpty) {
      emit(const TodoError('Название задачи не может быть пустым'));
      return;
    }

    try {
      final success = await _repository.updateTodo(
        id: event.id,
        title: event.title,
        description: event.description,
        status: event.status,
        dueDate: event.dueDate,
      );

      if (success) {
        final todos = await _repository.getAllTodos();
        if (state is TodoLoaded) {
          final currentState = state as TodoLoaded;
          emit(currentState.copyWith(todos: todos));
        } else {
          emit(TodoLoaded(todos: todos));
        }
      } else {
        emit(const TodoError('Не удалось обновить задачу'));
      }
    } catch (e) {
      emit(TodoError('Ошибка обновления задачи: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    try {
      final success = await _repository.deleteTodo(event.id);

      if (success) {
        final todos = await _repository.getAllTodos();
        if (state is TodoLoaded) {
          final currentState = state as TodoLoaded;
          emit(currentState.copyWith(todos: todos));
        } else {
          emit(TodoLoaded(todos: todos));
        }
      } else {
        emit(const TodoError('Не удалось удалить задачу'));
      }
    } catch (e) {
      emit(TodoError('Ошибка удаления задачи: ${e.toString()}'));
    }
  }

  Future<void> _onToggleTodoCompletion(
      ToggleTodoCompletion event, Emitter<TodoState> emit) async {
    try {
      final success = await _repository.toggleTodoCompletion(event.id);
      if (success) {
        final todos = await _repository.getAllTodos();
        if (state is TodoLoaded) {
          final currentState = state as TodoLoaded;
          emit(currentState.copyWith(todos: todos));
        } else {
          emit(TodoLoaded(todos: todos));
        }
      } else {
        emit(const TodoError('Не удалось изменить статус задачи'));
      }
    } catch (e) {
      emit(TodoError('Ошибка изменения статуса: ${e.toString()}'));
    }
  }

  Future<void> _onMoveTodoToStatus(
      MoveTodoToStatus event, Emitter<TodoState> emit) async {
    try {
      final success = await _repository.moveTodoToStatus(event.id, event.newStatus);

      if (success) {
        final todos = await _repository.getAllTodos();
        if (state is TodoLoaded) {
          final currentState = state as TodoLoaded;
          emit(currentState.copyWith(todos: todos));
        } else {
          emit(TodoLoaded(todos: todos));
        }
      } else {
        emit(const TodoError('Не удалось переместить задачу'));
      }
    } catch (e) {
      emit(TodoError('Ошибка перемещения задачи: ${e.toString()}'));
    }
  }

  Future<void> _onSearchTodos(SearchTodos event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      emit(currentState.copyWith(searchQuery: event.query));
    }
  }

  Future<void> _onClearAllTodos(ClearAllTodos event, Emitter<TodoState> emit) async {
    try {
      final success = await _repository.clearAllTodos();

      if (success) {
        emit(const TodoLoaded(todos: []));
      } else {
        emit(const TodoError('Не удалось очистить все задачи'));
      }
    } catch (e) {
      emit(TodoError('Ошибка очистки задач: ${e.toString()}'));
    }
  }

  Future<void> _onSetSelectedStatus(
      SetSelectedStatus event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      final currentState = state as TodoLoaded;
      emit(currentState.copyWith(selectedStatus: event.status));
    }
  }
}