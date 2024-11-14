import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/baseScreen/baseScreen.dart';
import 'package:flutter_chat_app/item/item_list_user_online.dart';
import 'package:flutter_chat_app/model/user_response.dart';
import 'package:flutter_chat_app/services/api_service.dart';
import 'package:flutter_chat_app/model/user_response.dart';
class Home extends Basescreen{
  const Home(this.user, {Key? key}) : super(key: key);
  final User user;
  @override
  _HomeState createState() => _HomeState();

}
class _HomeState extends BaseScreenState<Home>{
  List<User> users = [];

  Future<void> fetchData() async {
    final response = await ApiService.getAllUser();
    if (response['status'] == 200) {
      setState(() {
        users = parseUsers(response);
      });
    } else {
      setState(() {
        users = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const SizedBox(),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: CircleAvatar(backgroundImage: NetworkImage(replaceLocalhost(widget.user.avatar)),)
                ),
                const SizedBox(width: 20),
                const Text("Danh Sách Tin Nhắn"),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Thanh tìm kiếm
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm...',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300]!,
                ),
              ),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ItemListUserOnline(user);
                },
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(
                      user.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(replaceLocalhost(user.avatar)),
                      radius: 30,
                    ),
                    subtitle: Text(
                      user.numberPhone,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
