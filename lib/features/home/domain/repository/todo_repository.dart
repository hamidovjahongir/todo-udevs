import 'package:todo/features/home/data/models/todo_model.dart';

abstract class TodoRepository {
 Future<void> addTodo(TodoModel model);
 Future<TodoModel?> getTodo(int id);
 Future<List<TodoModel>> getTodos();
 Future<TodoModel?> updateTodo(int id,TodoModel model);
 Future<void> removeTodo(int id);
}