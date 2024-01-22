import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_2/domain/entities/todo_entity.dart';
import 'package:todo_app_2/domain/usecases/get_todo.dart';
import "package:collection/collection.dart";

part 'doing_event.dart';
part 'doing_state.dart';

class DoingBloc extends Bloc<DoingEvent, DoingState> {
  DoingBloc(this._getDoingUseCase) : super(DoingInitial()) {
    on<DoingEvent>(onGetDoing);
  }

  final GetTodoUseCase _getDoingUseCase;
  TodoEntity? doingEntity;
  List<TaskEntity>? taskEntities = [];
  Map<String, List<TaskEntity>>? dateGroup;
  int offset = 0;
  int limit = 10;
  Future<void> onGetDoing(DoingEvent event, Emitter<DoingState> emit) async {
    try {
      if (event is Init) {
        emit(DoingLoading());
        offset = 0;
        limit = 10;
        final dataState = await _getDoingUseCase.execute(TodoRequest(
          "DOING",
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
        emit(DoingLoaded(doingEntity, dateGroup));
      }
      if (event is LoadMore) {
        TodoEntity? only;
        offset = offset + 1;
        limit = limit;
        final dataState = await _getDoingUseCase.execute(TodoRequest(
          "DOING",
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
        emit(DoingLoaded(doingEntity, dateGroup));
      }
      if (event is Remove) {
        taskEntities?.removeWhere((element) => element.id == event.id);
        dateGroup = await groupByDate();
        emit(DoingLoaded(doingEntity, dateGroup));
      }
    } catch (e) {
      log("e : $e");
      emit(DoingLoadFailue("$e"));
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
