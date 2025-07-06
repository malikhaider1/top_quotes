class RandomWordsThumbnail {
  final String? large;
  final String? original;
  final String? small;

  RandomWordsThumbnail({
    required this.large,
    required this.original,
    required this.small,
  });
  factory RandomWordsThumbnail.empty() {
    return RandomWordsThumbnail(
      large: null,
      original: null,
      small: null,
    );
  }
}