import 'package:top_quotes/domain/entities/user_details.dart';

class UserDetailsInQuoteJson {
  final bool favorite;
  final bool upvote;
  final bool downvote;
  final bool hidden;
  UserDetailsInQuoteJson({
    required this.favorite,
    required this.upvote,
    required this.downvote,
    required this.hidden,
  });

  factory UserDetailsInQuoteJson.fromJson(Map<String, dynamic> json) {
    return UserDetailsInQuoteJson(
      favorite: json['favorite'],
      upvote: json['upvote'],
      downvote: json['downvote'],
      hidden: json['hidden'],
    );
  }

  UserDetails toDomain() {
    return UserDetails(
      favorite: favorite,
      upvote: upvote,
      downvote: downvote,
      hidden: hidden,
    );
  }
}
