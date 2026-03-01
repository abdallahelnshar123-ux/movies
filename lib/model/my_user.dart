class MyUser {
  static const String collectionName = 'Users';
  String name;
  String email;
  String id;
  String phone;
  String provider;
  int avatarIndex;

  // bool isEmailPassword;
  // bool isGoogle;
  // bool isPhone;
  // bool isFacebook;
  // bool isPlayGames;
  // bool isGameCenter;
  // bool isApple;
  // bool isGithub;
  // bool isMicrosoft;
  // bool isTwitter;
  // bool isYahoo;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avatarIndex,
    required this.provider,
    // this.isEmailPassword = false,
    // this.isApple = false,
    // this.isFacebook = false,
    // this.isGameCenter = false,
    // this.isGithub = false,
    // this.isGoogle = false,
    // this.isMicrosoft = false,
    // this.isPhone = false,
    // this.isPlayGames = false,
    // this.isTwitter = false,
    // this.isYahoo = false,
  });

  /// todo : json => object
  MyUser.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'] as String,
        name: data['name'] as String,
        email: data['email'] as String,
        phone: data['phone'] as String,
        avatarIndex: data['avatarIndex'],
      provider: data['provider'] as String
      );

  // MyUser.fromFireStore(Map<String, dynamic> data)
  //     : this(
  //   id: data['id'] as String? ?? '',
  //   name: data['name'] as String? ?? '',
  //   email: data['email'] as String? ?? '',
  //   phone: data['phone'] as String? ?? '',
  //   avatarIndex: data['avatarIndex'] as int? ?? -1,
  //   isEmailPassword: data['isEmailPassword'] as bool? ?? false,
  //   isGoogle: data['isGoogle'] as bool? ?? false,
  //   isPhone: data['isPhone'] as bool? ?? false,
  //   isFacebook: data['isFacebook'] as bool? ?? false,
  //   isPlayGames: data['isPlayGames'] as bool? ?? false,
  //   isGameCenter: data['isGameCenter'] as bool? ?? false,
  //   isApple: data['isApple'] as bool? ?? false,
  //   isGithub: data['isGithub'] as bool? ?? false,
  //   isMicrosoft: data['isMicrosoft'] as bool? ?? false,
  //   isTwitter: data['isTwitter'] as bool? ?? false,
  //   isYahoo: data['isYahoo'] as bool? ?? false,
  // );


  ///  todo : object => jason
  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatarIndex': avatarIndex,
      'provider': provider,

    };
  }

// Map<String, dynamic> toFireStore() {
//   return {
//     'id': id,
//     'name': name,
//     'email': email,
//     'phone': phone,
//     'avatarIndex': avatarIndex,
//     'isEmailPassword': isEmailPassword,
//     'isGoogle': isGoogle,
//     'isPhone': isPhone,
//     'isFacebook': isFacebook,
//     'isPlayGames': isPlayGames,
//     'isGameCenter': isGameCenter,
//     'isApple': isApple,
//     'isGithub': isGithub,
//     'isMicrosoft': isMicrosoft,
//     'isTwitter': isTwitter,
//     'isYahoo': isYahoo,
//   };
// }
}

class AuthProviders {
  static const google = 'google';
  static const emailPassword = 'emailPassword';
  static const phone = 'phone';
  static const facebook = 'facebook';
  static const playGames = 'playGames';
  static const gameCenter = 'gameCenter';
  static const apple = 'apple';
  static const github = 'github';
  static const microsoft = 'microsoft';
  static const twitter = 'twitter';
  static const yahoo = 'yahoo';

}