part of 'doing_bloc.dart';

sealed class DoingEvent extends Equatable {
  const DoingEvent();

  @override
  List<Object> get props => [];
}

class Init extends DoingEvent {}

class LoadMore extends DoingEvent {}

class Remove extends DoingEvent {
  String id;
  Remove(this.id);
  @override
  String toString() => "Remove{id : $id}";
}
