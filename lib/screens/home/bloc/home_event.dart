part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeListScrolledEvent extends HomeEvent {}

class HomeListRefreshedEvent extends HomeEvent {}
