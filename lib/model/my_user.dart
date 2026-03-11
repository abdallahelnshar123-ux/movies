class MyUser {
  static const String collectionName = 'Users';
  String name;
  String email;
  String id;
  String phone;
  String provider;
  int avatarIndex;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.avatarIndex,
    required this.provider,
  });

  /// todo : json => object
  MyUser.fromFireStore(Map<String, dynamic> data)
    : this(
        id: data['id'] as String,
        name: data['name'] as String,
        email: data['email'] as String,
        phone: data['phone'] as String,
        avatarIndex: data['avatarIndex'],
        provider: data['provider'] as String,
      );

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
