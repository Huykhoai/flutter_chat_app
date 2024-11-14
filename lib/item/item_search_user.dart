
import 'package:flutter/material.dart';

import '../baseScreen/baseScreen.dart';
import '../model/user_response.dart';

class ItemSearchUser extends Basescreen {
  const ItemSearchUser(this.user,{super.key});
  final User user;
  @override
  _ItemSearchUserState createState() => _ItemSearchUserState();
}

class _ItemSearchUserState extends BaseScreenState<ItemSearchUser> {
  @override
  Widget buildScreen(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 10,),
              CircleAvatar(
                backgroundImage: NetworkImage(replaceLocalhost(widget.user.avatar),),
                radius:30 ,),
              const SizedBox(width: 10,),
              Text(widget.user.name, style: const TextStyle(fontSize: 16),)
            ],
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
