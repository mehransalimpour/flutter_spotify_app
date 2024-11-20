import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_app/DI/di.dart';
import 'package:flutter_spotify_app/data/repository/autentication_repository.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRepository _authRepository = locator.get();
  AuthBloc() : super(AuthInitiateState()) {
    on<AuthLoadingRequest>((event, emit) async {
      emit(AuthLoadingState());

      var response =
          await _authRepository.login(event.username, event.passeord);

      emit(AuthResponseState(response));
    });
  }
}
