import 'package:flutter/material.dart';

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
  String replaceLocalhost(String url) {
    String wifiIp = '192.168.88.52';
    return url.replaceFirst('localhost', wifiIp);
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


