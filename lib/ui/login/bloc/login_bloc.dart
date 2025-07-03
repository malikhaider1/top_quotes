import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/domain/use_cases/auth_login_user_case.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthLoginUserCase authLoginUserCase;
  LoginBloc(this.authLoginUserCase) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) {
    });
    on<ClearLoginError>((event, emit) {
      emit(
        state.copyWith(
          errorMessage: '',
        ),
      );
    });
    on<LoginWithUsernameAndPassword>((event, emit) async {
        emit(
          state.copyWith(
            isLoading: true,
            isAuthenticated: false,
            errorMessage: null,
          ),
        );
        final token = await authLoginUserCase.login(event.username, event.password);
        token.fold((failure){
          emit(
            state.copyWith(
              isLoading: false,
              isAuthenticated: false,
              errorMessage: failure.message,
            ),
          );
        }, (token){
          emit(
              state.copyWith(
                userToken: token,
                isLoading: false,
                isAuthenticated: true,
                errorMessage: null,));
          }

         );
    });
  }
}
