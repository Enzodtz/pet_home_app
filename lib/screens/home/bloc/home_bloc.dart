import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_home_app/exceptions/server_exception.dart';
import 'package:pet_home_app/models/pet.dart';
import 'package:pet_home_app/services/pets_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  void onScrolledEvent(event, emit) async {
    if (!state.hasReachedMax) {
      try {
        final data = await PetsService.fetchPets(state.cursor);
        if (state.status == HomeFetchingStatus.initial) {
          emit(
            state.copyWith(
              status: HomeFetchingStatus.success,
              pets: data.pets,
              cursor: data.cursor,
              hasReachedMax: false,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: HomeFetchingStatus.success,
              pets: List.of(state.pets)..addAll(data.pets),
              hasReachedMax: data.cursor == null,
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(status: HomeFetchingStatus.failure));
      }
    }
  }

  void onRefreshedEvent(event, emit) async {
    emit(const HomeState());
    add(HomeListScrolledEvent());
  }

  HomeBloc() : super(const HomeState()) {
    on<HomeListScrolledEvent>(onScrolledEvent);

    on<HomeListRefreshedEvent>(onRefreshedEvent);

    add(HomeListScrolledEvent());
  }
}
