part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnTapConfirmButtonAuthEvent extends AuthEvent {
  final IAuthRepository repository;
  final String login;
  final String password;

  OnTapConfirmButtonAuthEvent(
      {required this.login, required this.password, required this.repository});
}
