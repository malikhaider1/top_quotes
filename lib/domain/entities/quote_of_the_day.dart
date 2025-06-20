import 'package:equatable/equatable.dart';

class QuoteOfTheDay extends Equatable{
  final int? id;
  final bool? dialogue;
  final bool? private;
  final List<String>? tags;
  final String? url;
  final int? favoritesCount;
  final int? upvotesCount;
  final int? downvotesCount;
  final String? author;
  final String? authorPermalink;
  final String? body;

  const QuoteOfTheDay({
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

  factory QuoteOfTheDay.empty() {
    return QuoteOfTheDay(
      id: null,
      dialogue: null,
      private: null,
      tags: [],
      url: null,
      favoritesCount: null,
      upvotesCount: null,
      downvotesCount: null,);
  }

  @override
  List<Object?> get props => [
    id,author,body,url
  ];
}