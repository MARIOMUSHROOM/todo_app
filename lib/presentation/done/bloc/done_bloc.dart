import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_2/domain/entities/todo_entity.dart';
import 'package:todo_app_2/domain/usecases/get_todo.dart';
import "package:collection/collection.dart";

part 'done_event.dart';
part 'done_state.dart';

class DoneBloc extends Bloc<DoneEvent, DoneState> {
  DoneBloc(this._getDoneUseCase) : super(DoneInitial()) {
    on<DoneEvent>(onGetDone);
  }

  final GetTodoUseCase _getDoneUseCase;
  TodoEntity? doingEntity;
  List<TaskEntity>? taskEntities = [];
  Map<String, List<TaskEntity>>? dateGroup;
  int offset = 0;
  int limit = 10;
  Future<void> onGetDone(DoneEvent event, Emitter<DoneState> emit) async {
    try {
      if (event is Init) {
        emit(DoneLoading());
        offset = 0;
        limit = 10;
        final dataState = await _getDoneUseCase.execute(TodoRequest(
          "DONE",
          offset: 0,
          limit: 10,
        ));
        dataState.fold(
          (failure) {
            throw failure.message;
          },
          (data) {
            doingEntity = data;
          },
        );
        taskEntities = doingEntity!.tasks;
        dateGroup = await groupByDate();
        emit(DoneLoaded(doingEntity, dateGroup));
      }
      if (event is LoadMore) {
        TodoEntity? only;
        offset = offset + 1;
        limit = limit;
        final dataState = await _getDoneUseCase.execute(TodoRequest(
          "DONE",
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
        emit(DoneLoaded(doingEntity, dateGroup));
      }
      if (event is Remove) {
        taskEntities?.removeWhere((element) => element.id == event.id);
        dateGroup = await groupByDate();
        emit(DoneLoaded(doingEntity, dateGroup));
      }
    } catch (e) {
      log("e : $e");
      emit(DoneLoadFailue("$e"));
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
