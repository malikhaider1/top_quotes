part of 'random_word_bloc.dart';

class RandomWordState {
  final bool isLoading;
  final String errorMessage;
  final RandomWord randomWord;
  final String imageUrl;
  final int count;
  const RandomWordState({
    required this.isLoading,
    required this.errorMessage,
    required this.randomWord,
    required this.count,
    required this.imageUrl,
  });
factory RandomWordState.initial() {
    return RandomWordState(
      isLoading: false,
      errorMessage: '',
      randomWord: RandomWord.empty(),
      count: 250,
      imageUrl: '',
    );
  }

  RandomWordState copyWith({
    bool? isLoading,
    String? errorMessage,
    RandomWord? randomWord,
    int? count,
    String? imageUrl,
  }) {
    return RandomWordState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      randomWord: randomWord ?? this.randomWord,
      count: count ?? this.count,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

}
