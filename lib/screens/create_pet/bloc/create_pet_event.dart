part of 'create_pet_bloc.dart';

abstract class CreatePetEvent extends Equatable {
  const CreatePetEvent();
}

class CreatePetSubmitEvent extends CreatePetEvent {
  final String name;
  final String contact;
  final String geolocation;
  final List images;

  const CreatePetSubmitEvent({
    required this.name,
    required this.contact,
    required this.geolocation,
    required this.images,
  });

  @override
  List<Object?> get props => [name, contact, geolocation, images];
}
