import 'package:top_quotes/data/user_details_in_quotes_json.dart';
import 'package:top_quotes/domain/entities/quote.dart';
import 'package:top_quotes/domain/entities/user_details.dart';

class QuotesJson {
  final int id;
  final bool? dialogue;
  final bool? private;
  final List<String> tags;
  final String url;
  final int favoritesCount;
  final int upvotesCount;
  final int downvotesCount;
  final String author;
  final String authorPermalink;
  final String body;
  final UserDetailsInQuoteJson userDetails;

  QuotesJson({
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
    required this.userDetails,
  });

  factory QuotesJson.fromJson(Map<String, dynamic> json) {
    return QuotesJson(
      id: json['id'],
      dialogue: json['dialogue'],
      private: json['private'],
      tags: List<String>.from(json['tags']),
      url: json['url'],
      favoritesCount: json['favorites_count'],
      upvotesCount: json['upvotes_count'],
      downvotesCount: json['downvotes_count'],
      author: json['author'],
      authorPermalink: json['author_permalink'],
      body: json['body'],
      userDetails:
          json['user_details'] != null
              ? UserDetailsInQuoteJson.fromJson(json['user_details'])
              : UserDetailsInQuoteJson(
                favorite: false,
                upvote: false,
                downvote: false,
                hidden: false,
              ),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['dialogue'] = dialogue;
    data['private'] = private;
    data['tags'] = tags;
    data['url'] = url;
    data['favorites_count'] = favoritesCount;
    data['upvotes_count'] = upvotesCount;
    data['downvotes_count'] = downvotesCount;
    data['author'] = author;
    data['author_permalink'] = authorPermalink;
    data['body'] = body;
    data['user_details'] = userDetails;
    return data;
  }

  Quote toDomain() {
    return Quote(
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
      userDetails: userDetails.toDomain(),
    );
  }
}
