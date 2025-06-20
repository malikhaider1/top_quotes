import 'package:equatable/equatable.dart';

class UserDetails extends Equatable {
  final bool favorite;
  final bool upvote;
  final bool downvote;
  final bool hidden;
  const UserDetails({
    required this.favorite,
    required this.upvote,
    required this.downvote,
    required this.hidden,
  });

  factory UserDetails.empty() {
    return UserDetails(favorite: false, upvote: false, downvote: false, hidden: false);
  }

  @override
  List<Object?> get props => [
    favorite,
    upvote,
    downvote,
    hidden,
  ];

}