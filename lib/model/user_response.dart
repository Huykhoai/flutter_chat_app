class User {
  final String id;
  final String email;
  final String numberPhone;
  final String password;
  final String userName;
  final String name;
  final String avatar;

  User({
    required this.id,
    required this.email,
    required this.numberPhone,
    required this.password,
    required this.userName,
    required this.name,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'] ?? '',
      numberPhone: json['number_phone'] ?? '',
      password: json["password"] ?? '',
      userName: json['user_name'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
    );
  }
}