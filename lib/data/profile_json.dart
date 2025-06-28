import 'package:equatable/equatable.dart';
import '../domain/entities/profile.dart';

class ProfileJson extends Equatable {
  const ProfileJson({
    required this.login,
    required this.picUrl,
    required this.publicFavoritesCount,
    required this.following,
    required this.followers,
    required this.pro,
    required this.accountDetails,
  });

  final String login;
  final String picUrl;
  final int publicFavoritesCount;
  final int following;
  final int followers;
  final bool? pro;
  final AccountDetailsJson accountDetails;

  factory ProfileJson.fromJson(Map<String, dynamic> json) {
    return ProfileJson(
      login: json["login"],
      picUrl: json["pic_url"],
      publicFavoritesCount: json["public_favorites_count"],
      following: json["following"],
      followers: json["followers"],
      pro: json["pro"],
      accountDetails: AccountDetailsJson.fromJson(json["account_details"]),
    );
  }

  Profile toDomain() {
    return Profile(
      login: login,
      picUrl: picUrl,
      publicFavoritesCount: publicFavoritesCount,
      following: following,
      followers: followers,
      pro: pro,
      accountDetails: AccountDetails(
        email: accountDetails.email,
        privateFavoritesCount: accountDetails.privateFavoritesCount,
        proExpiration: accountDetails.proExpiration,
      ),
    );
  }

  @override
  List<Object?> get props => [
    login,
    picUrl,
    publicFavoritesCount,
    following,
    followers,
    pro,
    accountDetails,
  ];
}

class AccountDetailsJson extends Equatable {
  const AccountDetailsJson({
    required this.email,
    required this.privateFavoritesCount,
    required this.proExpiration,
  });

  final String email;
  final int privateFavoritesCount;
  final String proExpiration;
  factory AccountDetailsJson.fromJson(Map<String, dynamic> json) {
    return AccountDetailsJson(
      email: json["email"],
      privateFavoritesCount: json["private_favorites_count"],
      proExpiration: json["pro_expiration"] ?? '',
    );
  }

  @override
  List<Object?> get props => [email, privateFavoritesCount];
}
