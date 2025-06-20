part of 'home_bloc.dart';

class HomeState {
  final QuoteOfTheDay quoteOfTheDay;
  final AllQuotes allQuotes;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    required this.quoteOfTheDay,
    required this.isLoading,
    required this.errorMessage,
    required this.allQuotes,
  });

  factory HomeState.initial() {
    return HomeState(
      quoteOfTheDay: QuoteOfTheDay.empty(),
      isLoading: false,
      errorMessage: null,
      allQuotes: AllQuotes.empty(),
    );
  }

  HomeState copyWith({
    QuoteOfTheDay? quoteOfTheDay,
    bool? isLoading,
    String? errorMessage,
    AllQuotes? allQuotes,
  }) {
    return HomeState(
      quoteOfTheDay: quoteOfTheDay ?? this.quoteOfTheDay,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      allQuotes: allQuotes??this.allQuotes,
    );
  }
}
