import 'dart:convert';

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
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if(response.statusCode == 401) {
        return jsonDecode(response.body);
      }else{
        throw Exception("Failed to login: ${response.statusCode}");
      }
    }catch(e){
      throw Exception("Failed to connect to the server: ${e}");
    }
  }
}