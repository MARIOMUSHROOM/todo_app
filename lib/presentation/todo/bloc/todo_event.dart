part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class InitTodo extends TodoEvent {}

class LoadMoreTodo extends TodoEvent {}

class RemoveTodo extends TodoEvent {
  String id;
  RemoveTodo(this.id);
  @override
  String toString() => "RemoveTodo{id : $id}";
}
