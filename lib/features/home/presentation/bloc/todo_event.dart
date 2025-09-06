part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

/// Barcha todolarni olish
final class GetTodosEvent extends TodoEvent {}

/// Todo qo‘shish
final class AddTodoEvent extends TodoEvent {
  final TodoModel todo;
  AddTodoEvent(this.todo);
}

/// Todo yangilash
final class UpdateTodoEvent extends TodoEvent {
  final int id;
  final TodoModel todo;
  UpdateTodoEvent(this.id, this.todo);
}

/// Todo o‘chirish
final class RemoveTodoEvent extends TodoEvent {
  final int id;
  RemoveTodoEvent(this.id);
}
