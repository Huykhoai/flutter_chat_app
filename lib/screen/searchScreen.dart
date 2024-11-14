import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/baseScreen/baseScreen.dart';
import 'package:flutter_chat_app/item/item_search_user.dart';
import 'package:flutter_chat_app/model/user_response.dart';
import 'package:flutter_chat_app/services/api_service.dart';

class SearchPage extends Basescreen {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}
class _SearchPageState extends BaseScreenState<SearchPage>{
  final TextEditingController _key = TextEditingController();
  List<User> users = [];
  Future<void> search (String key) async{
    final response = await ApiService.searchUser(key);
    if(response['status'] == 200){
      setState(() {
        users = parseUsers(response);
      });
    }else{
      users = [];
      print(response['data']);
    }
  }
  @override
  Widget buildScreen(BuildContext contetx) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 40,
          title: CupertinoSearchTextField(
            autofocus: true,
            controller: _key,
            onSubmitted: (value)=>{
              search(value)
            },
            onChanged: (value)=>{
              search(value)
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index){
                      final user = users[index];
                      return ItemSearchUser(
                        user
                      );
                    }))
          ],
        ),
      ),
    );
  }

}
