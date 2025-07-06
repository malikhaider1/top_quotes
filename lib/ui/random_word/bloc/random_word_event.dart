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
final class DownloadRandomWordImageEvent extends RandomWordEvent {
  final String imageUrl;
  DownloadRandomWordImageEvent(this.imageUrl);
}
final class SetImageUrlEvent extends RandomWordEvent {
  final String imageUrl;
  SetImageUrlEvent(this.imageUrl);
}