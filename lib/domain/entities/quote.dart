import 'package:equatable/equatable.dart';
import 'package:top_quotes/domain/entities/user_details.dart';

class Quote extends Equatable {
  final int id;
  final bool dialogue;
  final bool? private;
  final List<String> tags;
  final String url;
  final int? favoritesCount;
  final int upvotesCount;
  final int downvotesCount;
  final String? author;
  final String authorPermalink;
  final String body;
  final UserDetails? userDetails;

  const Quote({
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

  factory Quote.empty() {
    return Quote(
      id: 0,
      dialogue: false,
      private: false,
      tags: [],
      url: '',
      favoritesCount: 0,
      upvotesCount: 0,
      downvotesCount: 0,
      author: '',
      authorPermalink: '',
      body: '',
      userDetails: null,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [id,author,userDetails];
}
