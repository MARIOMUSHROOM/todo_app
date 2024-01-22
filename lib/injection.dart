import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:todo_app_2/data/data_source/todo_data_source.dart';
import 'package:todo_app_2/data/repositories/todo_repository_impl.dart';
import 'package:todo_app_2/domain/repositories/todo_repository.dart';
import 'package:todo_app_2/domain/usecases/get_todo.dart';
import 'package:todo_app_2/presentation/doing/bloc/doing_bloc.dart';
import 'package:todo_app_2/presentation/done/bloc/done_bloc.dart';
import 'package:todo_app_2/presentation/todo/bloc/todo_bloc.dart';

final sl = GetIt.instance;
setupLocator() {
  // bloc
  sl.registerFactory(() => TodoBloc(sl()));
  sl.registerFactory(() => DoingBloc(sl()));
  sl.registerFactory(() => DoneBloc(sl()));

  // usecase
  sl.registerLazySingleton(() => GetTodoUseCase(sl()));

  // repository
  sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(todoDataSource: sl()));

  // params
  sl.registerLazySingleton<TodoRequest>(() => TodoRequest(sl()));

  // data source
  sl.registerLazySingleton<TodoDataSource>(
      () => TodoDataSourceImpl(client: sl()));

  // external
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<http.Client>(() => http.Client());
}
