import 'package:flutter/foundation.dart';

class Register{
  final String email;
  final String number_phone;
  final String password;
  final String user_name;
  final String name;
  final String avatar;

  Register({required this.email,required this.number_phone,required this.password,required this.user_name,
    required this.name,required this.avatar});
  factory Register.fromJson(Map<String, dynamic> json){
    return Register(
        email: json['email'],
        number_phone: json['number_phone'],
        password: json['password'],
        user_name: json['user_name'],
        name: json['name'],
        avatar: json['avatar']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'number_phone': number_phone,
      'password': password,
      'user_name': user_name,
      'name': name,
      'avatar': avatar,
    };
  }
}