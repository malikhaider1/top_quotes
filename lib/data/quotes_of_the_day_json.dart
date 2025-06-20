import 'package:top_quotes/domain/entities/quote_of_the_day.dart';

class QuotesOfTheDayJson {
  int? id;
  bool? dialogue;
  bool? private;
  List<String>? tags;
  String? url;
  int? favoritesCount;
  int? upvotesCount;
  int? downvotesCount;
  String? author;
  String? authorPermalink;
  String? body;

  QuotesOfTheDayJson({
    this.id,
    this.dialogue,
    this.private,
    this.tags,
    this.url,
    this.favoritesCount,
    this.upvotesCount,
    this.downvotesCount,
    this.author,
    this.authorPermalink,
    this.body,
  });

  factory QuotesOfTheDayJson.fromJson(Map<String, dynamic> json) {
    return QuotesOfTheDayJson(
      id: json['id'],
      dialogue: json['dialogue'],
      private: json['private'],
      tags: List<String>.from(json['tags'] ?? []),
      url: json['url'],
      favoritesCount: json['favorites_count'],
      upvotesCount: json['upvotes_count'],
      downvotesCount: json['downvotes_count'],
      author: json['author'],
      authorPermalink: json['author_permalink'],
      body: json['body'],
    );
  }
  QuoteOfTheDay toDomain() => QuoteOfTheDay(
    id: id,
    dialogue: dialogue,
    private: private,
    tags: tags,
    url: url,
    favoritesCount: favoritesCount,
    upvotesCount: upvotesCount,
    downvotesCount: downvotesCount,
    author: author,
    authorPermalink: authorPermalink,
    body: body,
  );
}
