part of 'geolocation_bloc.dart';

@immutable
abstract class GeolocationState {}

class GeolocationInitialState extends GeolocationState {}

class GeolocationFailureState extends GeolocationState {
  final Exception exception;

  GeolocationFailureState(this.exception);
}

class GeolocationSuccessState extends GeolocationState {
  final Position position;

  GeolocationSuccessState(this.position);
}
