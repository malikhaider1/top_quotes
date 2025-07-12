import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_quotes/domain/use_cases/auth_login_use_case.dart';
import '../../../core/utils/scaffold_messenger/scaffold_messenger.dart';
import '../../../domain/use_cases/auth_log_out_use_case.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthLoginUseCase authLoginUseCase;
  final AuthLogOutUseCase _authLogOutUseCase;
  LoginBloc(this.authLoginUseCase,this._authLogOutUseCase) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) {
    });
    on<ClearLoginError>((event, emit) {
      emit(
        state.copyWith(
          errorMessage: '',
        ),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: ''));
      final result = await _authLogOutUseCase.execute();
      result.fold(
            (failure) {
          emit(
            state.copyWith(isLoading: false, errorMessage: failure.message),
          );
        },
            (success) {
          CustomScaffoldMessenger.showSnackBar(message: 'Logged out successfully');
          emit(state.copyWith(isLoading: false, errorMessage: '',isAuthenticated: false));
        },
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
        final token = await authLoginUseCase.execute(event.username, event.password);
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
