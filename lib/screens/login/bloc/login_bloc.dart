import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pet_home_app/exceptions/form_exceptions.dart';
import 'package:pet_home_app/exceptions/server_exception.dart';
import 'package:pet_home_app/models/user_model.dart';
import 'package:pet_home_app/services/auth_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  void _onLoginSubmitEvent(event, emit) async {
    emit(LoginLoadingState());
    try {
      final user = await AuthService.login(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccessState(
        user,
      ));
    } on FormGeneralException catch (e) {
      emit(LoginErrorState(e));
    } on FormFieldsException catch (e) {
      emit(LoginErrorState(e));
    } on ServerException catch (e) {
      emit(LoginErrorState(e));
    } catch (e) {
      emit(LoginErrorState(
        FormGeneralException(message: 'Couldn\'t Contact The Server'),
      ));
    }
  }

  LoginBloc() : super(LoginFormState()) {
    on<LoginSubmitEvent>(_onLoginSubmitEvent);
  }
}
