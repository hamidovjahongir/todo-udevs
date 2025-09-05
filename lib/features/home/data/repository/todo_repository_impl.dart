import 'package:todo/features/home/data/datasources/local_datasource.dart';
import 'package:todo/features/home/data/models/todo_model.dart';
import 'package:todo/features/home/domain/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  @override
  Future<void> addTodo(TodoModel model) async {
    await LocalDatasource.insert(model);
  }

  @override
  Future<TodoModel?> getTodo(int id) async {
    return await LocalDatasource.getOne(id);
  }

  @override
  Future<List<TodoModel>> getTodos() {
    return LocalDatasource.getAll();
  }

  @override
  Future<void> removeTodo(int id) async {
    await LocalDatasource.delete(id);
  }

  @override
  Future<TodoModel?> updateTodo(int id, TodoModel model) async {
    return LocalDatasource.update(id, model);
  }
}
