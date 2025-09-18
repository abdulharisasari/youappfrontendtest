class AuthRequest {
  String? email;
  String? username;
  String? password;

  AuthRequest({
    this.email,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "username": username,
      "password": password,
    };
  }
}
