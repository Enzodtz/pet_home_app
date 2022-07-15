import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_home_app/exceptions/form_exceptions.dart';
import 'package:pet_home_app/exceptions/server_exception.dart';
import 'package:pet_home_app/models/user_model.dart';
import 'package:pet_home_app/services/auth_service.dart';

part 'create_pet_event.dart';
part 'create_pet_state.dart';

class CreatePetBloc extends Bloc<CreatePetEvent, CreatePetState> {
  void _onCreatePetSubmitEvent(event, emit) async {
    emit(CreatePetLoadingState());
    try {
      final user = await AuthService.login(
        email: event.email,
        password: event.password,
      );
      emit(CreatePetSuccessState(
        user,
      ));
    } on FormGeneralException catch (e) {
      emit(CreatePetErrorState(e));
    } on FormFieldsException catch (e) {
      emit(CreatePetErrorState(e));
    } on ServerException catch (e) {
      emit(CreatePetErrorState(e));
    } catch (e) {
      emit(CreatePetErrorState(
        FormGeneralException(message: 'Couldn\'t Contact The Server'),
      ));
    }
  }

  CreatePetBloc() : super(CreatePetFormState()) {
    on<CreatePetSubmitEvent>(_onCreatePetSubmitEvent);
  }
}
