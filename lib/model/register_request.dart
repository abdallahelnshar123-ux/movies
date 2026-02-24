class RegisterRequest {
  String name;
  String email;
  String password;
  String confirmPassword;
  String phone;
  int avatarId;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avatarId,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "confirmPassword": confirmPassword,
      "phone": phone,
      "avaterId": avatarId,
    };
  }
}