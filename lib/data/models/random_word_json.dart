import 'package:equatable/equatable.dart';
import 'package:top_quotes/domain/entities/random_words.dart';

import '../../domain/entities/random_word_image.dart';

class RandomWordJson extends Equatable {
  const RandomWordJson({
    required this.images,
    required this.totalCached,
    required this.cacheTimestamp,
    required this.nextCursor,
  });

  final List<ImageJson> images;
  final int? totalCached;
  final DateTime? cacheTimestamp;
  final dynamic nextCursor;

  factory RandomWordJson.fromJson(Map<String, dynamic> json) {
    return RandomWordJson(
      images:
          json["images"] == null
              ? []
              : List<ImageJson>.from(
                json["images"]!.map((x) => ImageJson.fromJson(x)),
              ),
      totalCached: json["total_cached"],
      cacheTimestamp: DateTime.tryParse(json["cache_timestamp"] ?? ""),
      nextCursor: json["next_cursor"],
    );
  }

  @override
  List<Object?> get props => [images, totalCached, cacheTimestamp, nextCursor];
  RandomWord toDomain() {
    return RandomWord(
      images: images.toList().map((e) => e.toDomain()).toList(),
      totalCached: totalCached,
      cacheTimestamp: cacheTimestamp,
      nextCursor: nextCursor,
    );
  }
}

class ImageJson extends Equatable {
  const ImageJson({
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
    required this.thumbs,
    required this.source,
  });

  final String? id;
  final String? url;
  final String? shortUrl;
  final String? purity;
  final String? category;
  final String? resolution;
  final String? fileType;
  final DateTime? createdAt;
  final List<dynamic> colors;
  final String? path;
  final Thumbs? thumbs;
  final String? source;

  factory ImageJson.fromJson(Map<String, dynamic> json) {
    return ImageJson(
      id: json["id"],
      url: json["url"],
      shortUrl: json["short_url"],
      purity: json["purity"],
      category: json["category"],
      resolution: json["resolution"],
      fileType: json["fileType"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      colors:
          json["colors"] == null
              ? []
              : List<dynamic>.from(json["colors"]!.map((x) => x)),
      path: json["path"],
      thumbs: json["thumbs"] == null ? null : Thumbs.fromJson(json["thumbs"]),
      source: json["source"],
    );
  }

  RandomWordImage toDomain() {
    return RandomWordImage(
      id: id ?? '',
      url: url ?? '',
      shortUrl: shortUrl ?? '',
      purity: purity ?? '',
      category: category ?? '',
      resolution: resolution ?? '',
      fileType: fileType ?? '',
      createdAt: createdAt ?? DateTime.now(),
      colors: colors,
      path: path ?? '',
      source: source ?? '',
      thumbs: thumbs?.toDomain() ?? RandomWordThumbnail.empty(),
    );
  }

  @override
  List<Object?> get props => [
    id,
    url,
    shortUrl,
    purity,
    category,
    resolution,
    fileType,
    createdAt,
    colors,
    path,
    thumbs,
    source,
  ];
}

class Thumbs extends Equatable {
  const Thumbs({
    required this.large,
    required this.original,
    required this.small,
  });

  final String? large;
  final String? original;
  final String? small;

  factory Thumbs.fromJson(Map<String, dynamic> json) {
    return Thumbs(
      large: json["large"],
      original: json["original"],
      small: json["small"],
    );
  }
  RandomWordThumbnail toDomain() {
    return RandomWordThumbnail(large: large, original: original, small: small);
  }

  @override
  List<Object?> get props => [large, original, small];
}
