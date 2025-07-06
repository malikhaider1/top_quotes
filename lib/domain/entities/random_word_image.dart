class RandomWordImage {
  final String id;
  final String url;
  final String shortUrl;
  final String purity;
  final String category;
  final String resolution;
  final String fileType;
  final DateTime createdAt;
  final List<dynamic> colors;
  final String path;
  final RandomWordThumbnail thumbs;
  final String source;

  RandomWordImage({
    required this.id,
    required this.url,
    required this.shortUrl,
    required this.purity,
    required this.category,
    required this.resolution,
    required this.fileType,
    required this.createdAt,
    required this.colors,
    required this.path,
    required this.source,
    required this.thumbs,
  });

  factory RandomWordImage.empty() {
    return RandomWordImage(
        id: '',
        url: '',
        shortUrl: '',
        purity: '',
        category: '',
        resolution: '',
        fileType: '',
        createdAt: DateTime.now(),
        colors: [],
        path: '',
        source: '',
    thumbs: RandomWordThumbnail.empty());
}}

class RandomWordThumbnail{
  final String? large;
  final String? original;
  final String? small;
  const RandomWordThumbnail({
    required this.large,
    required this.original,
    required this.small,
  });
  factory RandomWordThumbnail.empty() {
    return const RandomWordThumbnail(
      large: null,
      original: null,
      small: null,
    );
  }
}