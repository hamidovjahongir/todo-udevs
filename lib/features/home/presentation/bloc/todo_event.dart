part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class GetTodosEvent extends TodoEvent {}

final class AddTodoEvent extends TodoEvent {
  final TodoModel todo;
  AddTodoEvent(this.todo);
}

final class UpdateTodoEvent extends TodoEvent {
  final int id;
  final TodoModel todo;
  UpdateTodoEvent(this.id, this.todo);
}

final class RemoveTodoEvent extends TodoEvent {
  final int id;
  RemoveTodoEvent(this.id);
}
