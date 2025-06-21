import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/repositories/auth_repository.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final LocalDb localDb;
  LoginBloc(this.authRepository,this.localDb) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) {
    });
    on<LoginWithUsernameAndPassword>((event, emit) async {
  emit(
        state.copyWith(
          isLoading: true,
          isAuthenticated: false,
          errorMessage: null,
        ),
      );
      try {
        final token = await authRepository.loginUser(
          event.username,
          event.password,
        );
        if(token.isNotEmpty){
         await localDb.saveCredentials(token, event.username, event.password);
          emit(
            state.copyWith(
              isLoading: false,
              isAuthenticated: true,
              userToken: token,
              errorMessage: null,
            ),
          );
        }
      } catch (error) {
        emit(
          state.copyWith(
            isLoading: false,
            isAuthenticated: false,
            errorMessage: error is Exception ? error.toString() : 'An unknown error occurred',
          ),
        );
      }
    });
  }
}
