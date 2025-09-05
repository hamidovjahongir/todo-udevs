import 'package:todo/features/home/data/models/todo_model.dart';
import 'package:todo/features/home/domain/repository/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository repository;
  AddTodoUseCase(this.repository);

  Future<void> call(TodoModel todo) async {
    return await repository.addTodo(todo);
  }
}

class GetTodosUseCase {
  final TodoRepository repository;
  GetTodosUseCase(this.repository);

  Future<List<TodoModel>> call() async {
    return await repository.getTodos();
  }
}

class GetTodoUseCase {
  final TodoRepository repository;
  GetTodoUseCase(this.repository);

  Future<TodoModel?> call(int id) async {
    return await repository.getTodo(id);
  }
}

class UpdateTodoUseCase {
  final TodoRepository repository;
  UpdateTodoUseCase(this.repository);

  Future<TodoModel?> call(int id, TodoModel todo) async {
    return await repository.updateTodo(id, todo);
  }
}

class RemoveTodoUseCase {
  final TodoRepository repository;
  RemoveTodoUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.removeTodo(id);
  }
}
