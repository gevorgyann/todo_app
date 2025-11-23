import 'package:equatable/equatable.dart';
import '../models/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {
  const LoadTodos();
}

class AddTodo extends TodoEvent {
  final String title;
  final String description;
  final DateTime? dueDate;

  const AddTodo({
    required this.title,
    this.description = '',
    this.dueDate,
  });

  @override
  List<Object?> get props => [title, description, dueDate];
}

class UpdateTodo extends TodoEvent {
  final String id;
  final String? title;
  final String? description;
  final TodoStatus? status;
  final DateTime? dueDate;

  const UpdateTodo({
    required this.id,
    this.title,
    this.description,
    this.status,
    this.dueDate,
  });

  @override
  List<Object?> get props => [id, title, description, status, dueDate];
}

class DeleteTodo extends TodoEvent {
  final String id;

  const DeleteTodo(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTodoCompletion extends TodoEvent {
  final String id;

  const ToggleTodoCompletion(this.id);

  @override
  List<Object?> get props => [id];
}

class MoveTodoToStatus extends TodoEvent {
  final String id;
  final TodoStatus newStatus;

  const MoveTodoToStatus(this.id, this.newStatus);

  @override
  List<Object?> get props => [id, newStatus];
}

class SearchTodos extends TodoEvent {
  final String query;

  const SearchTodos(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearAllTodos extends TodoEvent {
  const ClearAllTodos();
}

class SetSelectedStatus extends TodoEvent {
  final TodoStatus status;

  const SetSelectedStatus(this.status);

  @override
  List<Object?> get props => [status];
}