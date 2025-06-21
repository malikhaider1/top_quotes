import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/repositories/auth_repository.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepository;
  final LocalDb localDb;
  SignUpBloc(this.authRepository,this.localDb) : super(SignUpState.initial()) {
    on<SignUpEvent>((event, emit) {
    });
    on<SignUpWithUsernameAndPassword>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          isSignedUp: false,
          errorMessage: null,
        ),
      );
      try {
        // If successful, update the state
         final userToken = await authRepository.registerUser(
          event.username,
          event.email,
          event.password,
        );
         if(userToken.isNotEmpty){
         await localDb.saveCredentials(userToken, event.username, event.password);
           emit(
           state.copyWith(
             isLoading: false,
             isSignedUp: true,
             userToken: userToken,// Replace with actual token if available
             errorMessage: null,
           ),
         );}
             } catch (error) {
        // Handle any errors that occur during sign-up
        emit(
          state.copyWith(
            isLoading: false,
            isSignedUp: false,
            errorMessage: "Failed to sign up",
          ),
        );
      }
    });
  }
}
