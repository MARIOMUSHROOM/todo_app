part of 'done_bloc.dart';

abstract class DoneState {}

class DoneInitial extends DoneState {}

class DoneEmpty extends DoneState {}

class DoneLoading extends DoneState {}

class DoneLoaded extends DoneState {
  TodoEntity? data;
  Map<String, List<TaskEntity>>? dateGroup;
  DoneLoaded(this.data, this.dateGroup);
  @override
  String toString() => "DoneLoaded{}";
}

class DoneLoadFailue extends DoneState {
  String message;
  DoneLoadFailue(this.message);
  @override
  List<Object?> get props => [message];
}
