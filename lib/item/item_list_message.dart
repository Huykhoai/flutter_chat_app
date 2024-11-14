import 'package:flutter/material.dart';
import 'package:flutter_chat_app/baseScreen/baseScreen.dart';
import 'package:flutter_chat_app/screen/message.dart';

class ItemListMessage extends Basescreen {
  const ItemListMessage( {super.key});
  @override
  _ItemListMessageState createState() => _ItemListMessageState();
}

class _ItemListMessageState extends BaseScreenState<ItemListMessage> {
  @override
  Widget buildScreen(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: Colors.black,
            width: 1)),
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
              //child: ,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(widget.coffee.title
                  // ,style:
                  //   const TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //   fontSize: 20),),
                  // Text(widget.coffee.description)
                ],
              ),
            )
          ],
        )
      ),
      onTap: (){
        // Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return Message(widget.coffee);
        // }));
      },
    );
  }
}
