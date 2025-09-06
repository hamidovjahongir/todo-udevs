// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/features/home/data/models/todo_model.dart';
import 'package:todo/features/home/domain/usecases/todo_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase getTodosUseCase;
  final AddTodoUseCase addTodoUseCase;
  final RemoveTodoUseCase removeTodoUseCase;
  final UpdateTodoUseCase updateTodoUseCase;

  TodoBloc(
    this.getTodosUseCase,
    this.addTodoUseCase,
    this.removeTodoUseCase,
    this.updateTodoUseCase,
  ) : super(TodoInitial()) {
    on<GetTodosEvent>(_getTodos);
    on<AddTodoEvent>(_addTodo);
    on<RemoveTodoEvent>(_removeTodo);
    on<UpdateTodoEvent>(_updateTodo);
  }

  Future<void> _getTodos(GetTodosEvent event, Emitter emit) async {
    emit(TodoLoading());
    try {
      final todos = await getTodosUseCase.call();
      emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _addTodo(AddTodoEvent event, Emitter emit) async {
    emit(TodoLoading());
    try {
      await addTodoUseCase.call(event.todo);

      final todos = await getTodosUseCase.call();

      emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _removeTodo(RemoveTodoEvent event, Emitter emit) async {
    emit(TodoLoading());
    try {
      await removeTodoUseCase.call(event.id);
      final todos = await getTodosUseCase.call();
      emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }

  Future<void> _updateTodo(UpdateTodoEvent event, Emitter emit) async {
    emit(TodoLoading());
    try {
      final todo = await updateTodoUseCase.call(event.id, event.todo);
      if (todo == null) emit(TodoFailure('ochirishda xatolik'));
      final todos = await getTodosUseCase.call();
      emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure(e.toString()));
    }
  }
}
