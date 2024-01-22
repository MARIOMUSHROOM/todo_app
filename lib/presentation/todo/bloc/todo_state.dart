part of 'todo_bloc.dart';

// abstract class RemoteTodoState extends Equatable {
//   // final TodoEntity todoEntity;
//   const RemoteTodoState();
//   @override
//   List<Object?> get props => [];
// }

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoEmpty extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  TodoEntity? data;
  Map<String, List<TaskEntity>>? dateGroup;
  TodoLoaded(this.data, this.dateGroup);
  @override
  String toString() => "TodoLoaded{}";
}

class TodoLoadFailue extends TodoState {
  String message;
  TodoLoadFailue(this.message);
  @override
  List<Object?> get props => [message];
}
