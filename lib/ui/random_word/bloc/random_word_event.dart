part of 'random_word_bloc.dart';

@immutable
sealed class RandomWordEvent {}

final class FetchRandomWordEvent extends RandomWordEvent {
  FetchRandomWordEvent();
}

final class ClearRandomWordErrorEvent extends RandomWordEvent {
  ClearRandomWordErrorEvent();
}
final class FetchRandomWordImagesEvent extends RandomWordEvent {
  FetchRandomWordImagesEvent();
}