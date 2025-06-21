part of 'sign_up_bloc.dart';

class SignUpState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSignedUp;
  final String userToken;

  const SignUpState({
    required this.isLoading,
    required this.errorMessage,
    required this.isSignedUp,
    required this.userToken,
  });

  factory SignUpState.initial() {
    return const SignUpState(
      isLoading: false,
      errorMessage: null,
      isSignedUp: false,
      userToken: '',
    );
  }

  SignUpState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSignedUp,
    String? userToken,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSignedUp: isSignedUp ?? this.isSignedUp,
      userToken: userToken ?? this.userToken,
    );
  }
}

