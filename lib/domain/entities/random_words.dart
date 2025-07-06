import 'package:top_quotes/domain/entities/random_word_image.dart';

class RandomWord{
  final List<RandomWordImage> images;
  final int? totalCached;
  final DateTime? cacheTimestamp;
  final dynamic nextCursor;
  const RandomWord({
    required this.images,
    required this.totalCached,
    required this.cacheTimestamp,
    required this.nextCursor,
  });
  factory RandomWord.empty() {
    return const RandomWord(
      images: [],
      totalCached: 0,
      cacheTimestamp: null,
      nextCursor: null,
    );
  }
}