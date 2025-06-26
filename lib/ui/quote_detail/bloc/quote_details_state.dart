part of 'quote_details_bloc.dart';

class QuoteDetailsState {
  final bool isLoading;
  final String errorMessage;
  final Quote quote;

  const QuoteDetailsState({
    required this.isLoading,
    required this.errorMessage,
    required this.quote,
  });

  factory QuoteDetailsState.initial() {
    return  QuoteDetailsState(
      isLoading: false,
      errorMessage: '',
      quote: Quote.empty(),
    );
  }

  QuoteDetailsState copyWith({
    bool? isLoading,
    String? errorMessage,
    Quote? quote,
  }) {
    return QuoteDetailsState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      quote: quote ?? this.quote,
    );
  }
}

