import 'dart:convert';

import 'package:flutter_chat_app/model/register.dart';
import 'package:http/http.dart'as http;

class ApiService {
  static String baseUrl = "http://192.168.88.52:3000";

  static Future<Map<String, dynamic>> login(String email, String password) async{
    final url = Uri.parse("$baseUrl/api/post/sign_in");
    final body = jsonEncode({
      'email':email,
      'password':password
    });
    try {
      final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: body
      );
      return jsonDecode(response.body);
    }catch(e){
      throw Exception("Failed to connect to the server: ${e}");
    }
  }
  static Future<Map<String,dynamic>> register(Register register) async{
    final url = Uri.parse("$baseUrl/api/post/create_user");
    try{
      final response = await http.post(
        url,
      headers: {
          'Content-Type': 'application/json',
      },
      body: jsonEncode(register.toJson()));

      return jsonDecode(response.body);
    }catch(e){
      throw Exception("Failed to connect to the server: ${e}");
    }
  }
  static Future<Map<String, dynamic>> getAllUser() async{
    final url = Uri.parse("$baseUrl/api/get/all_user");
    try{
      final response = await http.get(url);
      return jsonDecode(response.body);
    }catch(e){
      throw Exception("Failed to connect to the server: ${e}");
    }
  }
  static Future<Map<String, dynamic>> searchUser(String key) async {
    final url = Uri.parse("$baseUrl/api/post/search_user");
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json'
          },
          body: jsonEncode({
            'key': key
          }));
      return jsonDecode(response.body);
    }catch(e){
      throw Exception("Failed to connect to the server: ${e}");
    }
  }
  static Future<Map<String, dynamic>> getMessage(List<String> room) async{
    print("${room[0]}#${room[1]}");
    final url = Uri.parse("$baseUrl/api/get_all_message?id_receiver=${room[0]}&id_sender=${room[1]}");
    try{
      final response = await http.get(url);
      print(jsonDecode(response.body));
      return jsonDecode(response.body);
    }catch(e){
      throw Exception("Failed to connect to the server: ${e}");
    }
  }
}