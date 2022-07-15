part of 'create_pet_bloc.dart';

abstract class CreatePetState extends Equatable {
  const CreatePetState();

  @override
  List<Object> get props => [];
}

class CreatePetFormState extends CreatePetState {}

class CreatePetLoadingState extends CreatePetState {}

class CreatePetSuccessState extends CreatePetState {
  final User user;

  const CreatePetSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class CreatePetErrorState extends CreatePetState {
  final Exception exception;

  const CreatePetErrorState(this.exception);

  @override
  List<Object> get props => [exception];
}
