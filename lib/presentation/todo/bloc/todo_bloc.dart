import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_2/domain/entities/todo_entity.dart';
import 'package:todo_app_2/domain/usecases/get_todo.dart';
import "package:collection/collection.dart";

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(this._getTodoUseCase) : super(TodoInitial()) {
    on<TodoEvent>(onGetTodo);
  }

  final GetTodoUseCase _getTodoUseCase;
  TodoEntity? todoEntity;
  List<TaskEntity>? taskEntities = [];
  Map<String, List<TaskEntity>>? dateGroup;
  int offset = 0;
  int limit = 10;
  Future<void> onGetTodo(TodoEvent event, Emitter<TodoState> emit) async {
    try {
      if (event is InitTodo) {
        emit(TodoLoading());
        offset = 0;
        limit = 10;
        final dataState = await _getTodoUseCase.execute(TodoRequest(
          "TODO",
          offset: 0,
          limit: 10,
        ));
        dataState.fold(
          (failure) {
            throw failure.message;
          },
          (data) {
            todoEntity = data;
          },
        );
        taskEntities = todoEntity!.tasks;
        dateGroup = await groupByDate();
        emit(TodoLoaded(todoEntity, dateGroup));
      }
      if (event is LoadMoreTodo) {
        TodoEntity? only;
        offset = offset + 1;
        limit = limit;
        final dataState = await _getTodoUseCase.execute(TodoRequest(
          "TODO",
          offset: offset,
          limit: limit,
        ));
        dataState.fold(
          (failure) {
            throw failure.message;
          },
          (data) {
            only = data;
          },
        );
        taskEntities?.addAll(only!.tasks ?? []);
        dateGroup = await groupByDate();
        emit(TodoLoaded(todoEntity, dateGroup));
      }
      if (event is RemoveTodo) {
        taskEntities?.removeWhere((element) => element.id == event.id);
        dateGroup = await groupByDate();
        emit(TodoLoaded(todoEntity, dateGroup));
      }
    } catch (e) {
      log("e : $e");
      emit(TodoLoadFailue("$e"));
    }
  }

  Future<Map<String, List<TaskEntity>>?> groupByDate() async {
    Map<String, List<TaskEntity>>? dateGroup;
    if (taskEntities?.isNotEmpty ?? false) {
      var groupByDate = groupBy(
          taskEntities!, (obj) => obj.createdAt.toString().substring(0, 10));
      dateGroup = groupByDate;
      log("message $dateGroup");
      return dateGroup;
    }
    return null;
  }
}
