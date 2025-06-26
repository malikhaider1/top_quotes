part of 'favorite_bloc.dart';

class FavoriteState {
  final bool isLoading;
  final AllQuotes quotes;
  final String errorMessage;
  final int page;

  const FavoriteState({
    required this.isLoading,
    required this.quotes,
    required this.errorMessage,
    required this.page,
});
  factory FavoriteState.initial() {
    return FavoriteState(
      isLoading: false,
      quotes: AllQuotes.empty(),
      errorMessage: '',
      page: 1,
    );
  }

  FavoriteState copyWith({
    bool? isLoading,
    AllQuotes? quotes,
    String? errorMessage,
    int? page,
  }) {
    return FavoriteState(
      isLoading: isLoading ?? this.isLoading,
      quotes: quotes ?? this.quotes,
      errorMessage: errorMessage ?? this.errorMessage,
      page: page ?? this.page,
    );
  }


}
