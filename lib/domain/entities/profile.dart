class Profile{
  final String login;
  final String picUrl;
  final int publicFavoritesCount;
  final int following;
  final int followers;
  final bool? pro;
  final AccountDetails accountDetails;

  const Profile({
    required this.login,
    required this.picUrl,
    required this.publicFavoritesCount,
    required this.following,
    required this.followers,
    required this.pro,
    required this.accountDetails,
  });

  factory Profile.empty(){
    return Profile(
      login: '',
      picUrl: '',
      publicFavoritesCount: 0,
      following: 0,
      followers: 0,
      pro: null,
      accountDetails: AccountDetails.empty(),
    );
  }
}

class AccountDetails {
  final String email;
  final int privateFavoritesCount;
  final String proExpiration;
  const AccountDetails({
    required this.email,
    required this.privateFavoritesCount,
    required this.proExpiration,
  });

  factory AccountDetails.empty(){
    return AccountDetails(
      email: '',
      privateFavoritesCount: 0,
      proExpiration: '',
    );
  }

}