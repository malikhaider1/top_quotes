part of 'login_bloc.dart';

class LoginState extends Equatable{
  final bool isLoading;
  final String errorMessage;
  final bool isAuthenticated;
  final String userToken;
  const LoginState({
    required this.isLoading,
    required this.errorMessage,
    required this.isAuthenticated,
    required this.userToken,
  });

  factory LoginState.initial() {
    return const LoginState(
      isLoading: false,
      errorMessage: '',
      isAuthenticated: false,
      userToken: '',
    );
  }

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isAuthenticated,
    String? userToken,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userToken: userToken ?? this.userToken,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    isLoading,
    errorMessage,
    isAuthenticated,
    userToken,
  ];
}