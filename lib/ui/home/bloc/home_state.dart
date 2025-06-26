part of 'home_bloc.dart';

class HomeState {
  final QuoteOfTheDay quoteOfTheDay;
  final List<Quote> quotes;
  final int page;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    required this.quoteOfTheDay,
    required this.isLoading,
    required this.errorMessage,
    required this.quotes,
    required this.page,
  });

  factory HomeState.initial() {
    return HomeState(
      quoteOfTheDay: QuoteOfTheDay.empty(),
      isLoading: false,
      errorMessage: null,
      quotes: [],
      page: 1,
    );
  }

  HomeState copyWith({
    QuoteOfTheDay? quoteOfTheDay,
    bool? isLoading,
    String? errorMessage,
    List<Quote>? quotes,
    int? page,
  }) {
    return HomeState(
      quoteOfTheDay: quoteOfTheDay ?? this.quoteOfTheDay,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      quotes: quotes??this.quotes,
      page: page ?? this.page,
    );
  }
}
