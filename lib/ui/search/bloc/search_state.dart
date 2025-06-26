part of 'search_bloc.dart';

class SearchState {
  final bool isLoading;
  final String? errorMessage;
  final List<Quote> quotes;
  final List<Quote> authorQuotes;
  final List<Quote> tagQuotes;
  final int page;
  final String searchQuery;
  const SearchState({
    required this.isLoading,
    required this.errorMessage,
    required this.quotes,
    required this.authorQuotes,
    required this.tagQuotes,
    required this.page,
    required this.searchQuery,
  });
  factory SearchState.initial() {
    return const SearchState(
      isLoading: false,
      errorMessage: null,
      quotes: [],
      authorQuotes: [],
      tagQuotes: [],
      page: 1,
      searchQuery: '',
    );
  }
  SearchState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Quote>? quotes,
    List<Quote>? authorQuotes,
    List<Quote>? tagQuotes,
    int? page,
    String? searchQuery,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      quotes: quotes ?? this.quotes,
      authorQuotes: authorQuotes ?? this.authorQuotes,
      tagQuotes: tagQuotes ?? this.tagQuotes,
      page: page ?? this.page,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
