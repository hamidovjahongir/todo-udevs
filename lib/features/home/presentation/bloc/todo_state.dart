part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

/// Loading holati
final class TodoLoading extends TodoState {}

/// Barcha todolar muvaffaqiyatli olindi
final class TodoLoadSuccess extends TodoState {
  final List<TodoModel> todos;
  TodoLoadSuccess(this.todos);
}

/// Bitta todo olindi
final class TodoGetSuccess extends TodoState {
  final TodoModel todo;
  TodoGetSuccess(this.todo);
}

/// Todo qo‘shildi
final class TodoAdded extends TodoState {

}

/// Todo yangilandi
final class TodoUpdated extends TodoState {
  final TodoModel todo;
  TodoUpdated(this.todo);
}

/// Todo o‘chirildi
final class TodoDeleted extends TodoState {
  TodoDeleted();
}

/// Xato holati
final class TodoFailure extends TodoState {
  final String message;
  TodoFailure(this.message);
}
