part of 'profile_bloc.dart';

class ProfileState {
  final bool isLoading;
  final String? errorMessage;
  final Profile profile;

  ProfileState({
    required this.isLoading,
    required this.errorMessage,
    required this.profile,
  });

  factory ProfileState.initial() {
    return ProfileState(
      isLoading: false,
      errorMessage: null,
      profile: Profile.empty(),
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    Profile? profile,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      profile: profile ?? this.profile,
    );
  }
}
