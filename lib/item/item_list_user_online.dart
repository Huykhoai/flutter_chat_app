import 'package:flutter/material.dart';
import 'package:flutter_chat_app/baseScreen/baseScreen.dart';
import 'package:flutter_chat_app/model/user_response.dart';

class ItemListUserOnline extends Basescreen {
  const ItemListUserOnline(this.user,{super.key});
  final User user;
  @override
  _ItemListUserOnlineState createState() => _ItemListUserOnlineState();
}

class _ItemListUserOnlineState extends BaseScreenState<ItemListUserOnline> {
  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(replaceLocalhost(widget.user.avatar)),
            radius: 30,),
            Text(widget.user.name),
          ],
        ),
        onTap: (){

        },
      ),
    );
  }
}
