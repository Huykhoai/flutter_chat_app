import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/item/item_list_message.dart';

import '../model/coffee.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  _HomeState createState() {
    return _HomeState();
  }

}
class _HomeState extends State<Home> with TickerProviderStateMixin {
  List<Coffee> coffees = [];

  Future<void> fetchData() async {
    final url = Uri.parse("https://api.sampleapis.com/coffee/hot");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        coffees = data.map((item) => Coffee.fromJson(item)).toList();
      });
    } else {
      setState(() {
        coffees = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: const SizedBox(),
            title: const Text("Danh Sách Tin Nhắn"),
            centerTitle: true,
          ),
          body: Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                // Thanh tìm kiếm
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                // Danh sách tin nhắn
                Expanded(
                  child: ListView.builder(
                    itemCount: coffees.length,
                    itemBuilder: (context, index) {
                      final coffee = coffees[index];
                      return InkWell(
                        child: ItemListMessage(
                            coffee
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),)
      ),
    );
  }
}
