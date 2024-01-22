part of 'done_bloc.dart';

sealed class DoneEvent extends Equatable {
  const DoneEvent();

  @override
  List<Object> get props => [];
}

class Init extends DoneEvent {}

class LoadMore extends DoneEvent {}

class Remove extends DoneEvent {
  String id;
  Remove(this.id);
  @override
  String toString() => "Remove{id : $id}";
}
