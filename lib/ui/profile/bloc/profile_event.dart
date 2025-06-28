part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class FetchProfileEvent extends ProfileEvent {
  FetchProfileEvent();
}