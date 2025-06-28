import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:top_quotes/domain/repositories/local_db.dart';
import 'package:top_quotes/domain/repositories/profile_repository.dart';

import '../../../domain/entities/profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  final LocalDb localDb;
  ProfileBloc(this.profileRepository,this.localDb) : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) {
    });
    on<FetchProfileEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await profileRepository.getProfile(localDb.username, localDb.userToken).then((profile) {
        emit(state.copyWith(isLoading: false, errorMessage: null, profile: profile));
      }).catchError((error) {
        print(error);
        emit(state.copyWith(isLoading: false, errorMessage: error.toString()));
      });
    });


  }
}
