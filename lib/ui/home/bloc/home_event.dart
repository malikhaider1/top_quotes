part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class FetchQuoteOfTheDayEvent extends HomeEvent {
   FetchQuoteOfTheDayEvent();
}
final class FetchAllQuotesEvent extends HomeEvent {
  final int page;
  FetchAllQuotesEvent({this.page = 1});
}
final class ClearHomeErrorEvent extends HomeEvent {
  ClearHomeErrorEvent();
}