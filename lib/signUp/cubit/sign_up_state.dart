part of 'sign_up_cubit.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final String username;
  SignUpEvent(this.username);
}

class GetNameEvent extends AuthEvent {}

abstract class AuthState {}

class InitialState extends AuthState {}

class AuthenticatedState extends AuthState {
  final String name;
  AuthenticatedState(this.name);
}
