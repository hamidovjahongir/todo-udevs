import 'package:get_it/get_it.dart';
import 'package:todo/features/home/data/repository/todo_repository_impl.dart';
import 'package:todo/features/home/domain/repository/todo_repository.dart';
import 'package:todo/features/home/domain/usecases/todo_usecase.dart';
import 'package:todo/features/home/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

void setUp() {
  sl.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl());

  sl.registerLazySingleton(() => GetTodoUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton(() => GetTodosUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton(() => AddTodoUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton(() => RemoveTodoUseCase(sl<TodoRepository>()));
  sl.registerLazySingleton(() => UpdateTodoUseCase(sl<TodoRepository>()));

  sl.registerFactory(
    () => TodoBloc(
      sl<GetTodosUseCase>(),
      sl<AddTodoUseCase>(),
      sl<RemoveTodoUseCase>(),
      sl<UpdateTodoUseCase>(),
    ),
  );
}
