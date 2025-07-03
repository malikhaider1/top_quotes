import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/repositories/auth_repository.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';
import 'package:top_quotes/domain/use_cases/auth_sign_up_use_case.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
final AuthSignUpUseCase _authSignUpUseCase;
  SignUpBloc(this._authSignUpUseCase) : super(SignUpState.initial()) {
    on<SignUpEvent>((event, emit) {
    });
    on<ClearSignUpError>((event, emit) {
      emit(
        state.copyWith(
          errorMessage: '',
        ),
      );
    });
    on<SignUpWithUsernameAndPassword>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          isSignedUp: false,
          errorMessage: '',
        ),
      ); // If successful, update the state
         final userToken = await _authSignUpUseCase.execute(
          email: event.email, password: event.password, username: event.username,
        );
         userToken.fold((failure){
           emit(
             state.copyWith(
               isLoading: false,
               isSignedUp: false,
               errorMessage: failure.message,
             ),
           );
         }, (userToken) async {
             emit(
               state.copyWith(
                 isLoading: false,
                 isSignedUp: true,
                 userToken: userToken,// Replace with actual token if available
                 errorMessage: '',
               ),
             );}
         );
    });
  }
}
