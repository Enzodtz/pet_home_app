part of 'home_bloc.dart';

enum HomeFetchingStatus { initial, success, failure }

class HomeState extends Equatable {
  final HomeFetchingStatus status;
  final List<Pet> pets;
  final bool hasReachedMax;
  final String? cursor;

  const HomeState({
    this.status = HomeFetchingStatus.initial,
    this.pets = const <Pet>[],
    this.hasReachedMax = false,
    this.cursor,
  });

  HomeState copyWith({
    HomeFetchingStatus? status,
    List<Pet>? pets,
    bool? hasReachedMax,
    String? cursor,
  }) {
    return HomeState(
      status: status ?? this.status,
      pets: pets ?? this.pets,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      cursor: cursor ?? this.cursor,
    );
  }

  @override
  List<Object> get props => [status, pets, hasReachedMax];
}
