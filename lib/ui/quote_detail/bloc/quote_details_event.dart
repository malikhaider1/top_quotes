part of 'quote_details_bloc.dart';

@immutable
sealed class QuoteDetailsEvent {}

final class FetchQuoteDetailsEvent extends QuoteDetailsEvent {
  final int quoteId;
  FetchQuoteDetailsEvent({required this.quoteId});
}