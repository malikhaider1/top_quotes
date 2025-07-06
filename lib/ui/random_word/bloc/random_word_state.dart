part of 'random_word_bloc.dart';

class RandomWordState {
  final bool isLoading;
  final String errorMessage;
  final RandomWord randomWord;
  final int count;
  const RandomWordState({
    required this.isLoading,
    required this.errorMessage,
    required this.randomWord,
    required this.count,
  });
factory RandomWordState.initial() {
    return RandomWordState(
      isLoading: false,
      errorMessage: '',
      randomWord: RandomWord.empty(),
      count: 250,
    );
  }

  RandomWordState copyWith({
    bool? isLoading,
    String? errorMessage,
    RandomWord? randomWord,
    int? count,
  }) {
    return RandomWordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      randomWord: randomWord ?? this.randomWord,
      count: count ?? this.count,
    );
  }

}
