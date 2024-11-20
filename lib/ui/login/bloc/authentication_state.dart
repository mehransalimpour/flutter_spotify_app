import 'package:dartz/dartz.dart';

abstract class AuthState {}

class AuthLoadingState extends AuthState {}

class AuthInitiateState extends AuthState {}

class AuthResponseState extends AuthState {
  Either<String, String> response;
  AuthResponseState(this.response);
}
