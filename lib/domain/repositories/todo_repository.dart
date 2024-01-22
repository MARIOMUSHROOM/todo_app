import 'package:dartz/dartz.dart';
import 'package:todo_app_2/core/error/failure.dart';
import 'package:todo_app_2/domain/entities/todo_entity.dart';
import 'package:todo_app_2/domain/usecases/get_todo.dart';

abstract class TodoRepository {
  Future<Either<Failure, TodoEntity>> getTodo(TodoRequest params);
  Future<Either<Failure, TodoEntity>> getLoadMore(TodoRequest params);
}
