import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/message.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_response.dart';

abstract class Basescreen extends StatefulWidget {
  const Basescreen({Key? key}) : super(key: key);

  @override
  BaseScreenState createState();
}
abstract class BaseScreenState<T extends Basescreen> extends State<T>{
  bool isLoading = false;

  void showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      isLoading = false;
    });
  }
  List<User> parseUsers(dynamic jsonData) {
    final List<dynamic> data = jsonData['data'];
    return data.map((json) => User.fromJson(json)).toList();
  }
  List<Message> parseMessages(dynamic jsonData) {
    final List<dynamic> data = jsonData['data'];
    return data.map((json) => Message.fromJson(json)).toList();
  }
  String replaceLocalhost(String url) {
    String wifiIp = '192.168.88.52';
    return url.replaceFirst('localhost', wifiIp);
  }
  static const key = "huy";
  Future<void> saveUser(User user) async{
    final pres = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    print("user json: $userJson");
    await pres.setString(key, userJson);
  }
  Future<User?> getUser() async{
    final pres = await SharedPreferences.getInstance();
    String? userJson = pres.getString(key);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }
  Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildScreen(context),
        // if(isLoading)
        //   const Center(
        //     child: CircularProgressIndicator(color: Colors.black,),)
      ],
    );
  }
  Widget buildScreen(BuildContext contetx);
}


