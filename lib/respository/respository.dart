import 'package:flutter_chat_app/services/api_service.dart';

class Respository{
  final ApiService apiService;
  Respository({required this.apiService});

  Future<Map<String, dynamic>> login(String email, String password) async{
    return await apiService.login(email, password);
  }
}