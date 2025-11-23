import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

enum TodoStatus {
  toDo('К выполнению'),
  inProgress('В работе'),
  inReview('На проверке'),
  completed('Выполнено');

  const TodoStatus(this.displayName);
  final String displayName;
}

@freezed
abstract class  Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    required String description,
    required TodoStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? dueDate,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  const Todo._();

  bool get isCompleted => status == TodoStatus.completed;

  bool get isOverdue => dueDate != null &&
      dueDate!.isBefore(DateTime.now()) &&
      !isCompleted;

  String get formattedDueDate {
    if (dueDate == null) return '';
    final formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(dueDate!);
  }
}