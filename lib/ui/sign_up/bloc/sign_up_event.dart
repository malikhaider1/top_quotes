part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

final class SignUpWithUsernameAndPassword extends SignUpEvent {
  final String username;
  final String email;
  final String password;
  SignUpWithUsernameAndPassword({
    required this.username,
    required this.email,
    required this.password,
  });
}
