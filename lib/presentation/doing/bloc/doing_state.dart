part of 'doing_bloc.dart';

abstract class DoingState {}

class DoingInitial extends DoingState {}

class DoingEmpty extends DoingState {}

class DoingLoading extends DoingState {}

class DoingLoaded extends DoingState {
  TodoEntity? data;
  Map<String, List<TaskEntity>>? dateGroup;
  DoingLoaded(this.data, this.dateGroup);
  @override
  String toString() => "DoingLoaded{}";
}

class DoingLoadFailue extends DoingState {
  String message;
  DoingLoadFailue(this.message);
  @override
  List<Object?> get props => [message];
}
