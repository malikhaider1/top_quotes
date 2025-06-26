import 'package:top_quotes/domain/entities/quote_of_the_day.dart';

class QuotesOfTheDayJson {
 final  int id;
  final bool dialogue;
 final  bool private;
  final List<String> tags;
  final String url;
  final int favoritesCount;
  final int upvotesCount;
  final int downvotesCount;
  final String author;
  final String authorPermalink;
  final String body;

const QuotesOfTheDayJson({
    required this.id,
    required this.dialogue,
    required this.private,
    required this.tags,
    required this.url,
   required this.favoritesCount,
    required this.upvotesCount,
    required this.downvotesCount,
    required this.author,
    required this.authorPermalink,
    required this.body,
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
