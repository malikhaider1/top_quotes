part of 'favorite_bloc.dart';

sealed class FavoriteEvent {}

final class FetchFavoriteQuotesEvent extends FavoriteEvent {
  final int page;
  FetchFavoriteQuotesEvent({required this.page});
}