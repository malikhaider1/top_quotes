part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginWithUsernameAndPassword extends LoginEvent {
  final String username;
  final String password;
  LoginWithUsernameAndPassword({
    required this.username,
    required this.password,
  });
}

final class ClearLoginError extends LoginEvent {
  ClearLoginError();
}