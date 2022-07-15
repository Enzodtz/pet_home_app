import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:pet_home_app/services/geolocation_service.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc() : super(GeolocationInitialState()) {
    on<GeolocationGetCurrentEvent>((event, emit) async {
      try {
        await GeolocationService.handlePermission();

        final position = await GeolocationService.getCurrentPosition();

        emit(GeolocationSuccessState(position));
      } on LocationServiceDisabledException catch (e) {
        emit(GeolocationFailureState(e));
      } on PermissionDeniedException catch (e) {
        emit(GeolocationFailureState(e));
      }
    });

    add(GeolocationGetCurrentEvent());
  }
}
