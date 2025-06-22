part of 'search_bloc.dart';

class SearchState {
  final bool isLoading;
  final String? errorMessage;
  final List<Quote> quotes;
  final String searchQuery;
  const SearchState({
    required this.isLoading,
    required this.errorMessage,
    required this.quotes,
    required this.searchQuery,
  });
  factory SearchState.initial() {
    return const SearchState(
      isLoading: false,
      errorMessage: null,
      quotes: [],
      searchQuery: '',
    );
  }
  SearchState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<Quote>? quotes,
    String? searchQuery,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      quotes: quotes ?? this.quotes,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
