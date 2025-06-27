part of 'quote_details_bloc.dart';

@immutable
sealed class QuoteDetailsEvent {}

final class FetchQuoteDetailsEvent extends QuoteDetailsEvent {
  final int quoteId;
  FetchQuoteDetailsEvent({required this.quoteId});
}
final class AddQuoteToFavoritesEvent extends QuoteDetailsEvent {
  final int id;
  AddQuoteToFavoritesEvent({required this.id});
}
final class RemoveQuoteFromFavoritesEvent extends QuoteDetailsEvent {
  final int id;
  RemoveQuoteFromFavoritesEvent({required this.id});
}
final class QuoteUpvoteEvent extends QuoteDetailsEvent {
  final int id;
  QuoteUpvoteEvent({required this.id});
}
final class QuoteDownVoteEvent extends QuoteDetailsEvent {
  final int id;
  QuoteDownVoteEvent({required this.id});
}
final class ClearVoteOnQuoteEvent extends QuoteDetailsEvent {
  final int id;
  ClearVoteOnQuoteEvent({required this.id});
}
