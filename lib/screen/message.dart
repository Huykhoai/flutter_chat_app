import 'package:flutter/material.dart';
import 'package:flutter_chat_app/baseScreen/baseScreen.dart';
import 'package:flutter_chat_app/model/message.dart';
import 'package:flutter_chat_app/model/user_response.dart';
import 'package:flutter_chat_app/services/api_service.dart';
import 'package:flutter_chat_app/ultils/socket_manager.dart';

import 'package:image_slide_show/image_slide_show.dart';

class MessageScreen extends Basescreen {
  const MessageScreen(this.user, {super.key});
  final User user;
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends BaseScreenState<MessageScreen> {
   List<Message> messages =[];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final SocketManager socketManager = SocketManager();
  Future<List<String>> getRoom() async{
    String userReceiver = widget.user.id;
    User? user = await getUser();
    List<String> ids = [userReceiver, user?.id ?? ''];
    return ids;
  }
  @override
  void initState(){
    super.initState();
    getMessage();
    socketManager.connect((Message message) {
      setState(() {
        messages.insert(0,message);
      });
      _scrollToBottom();
    },);
    _initializeRoom();
  }
  Future<void> _initializeRoom() async {
    List<String> room = await getRoom();
    socketManager.join_room(room);
  }
  @override
  void dispose() {
    socketManager.disconnect();
    super.dispose();
  }
  Future<void> _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      List<String> room = await getRoom();
      socketManager.sendMessage(room, _messageController.text);
      _messageController.clear();
    }
  }
   void _scrollToBottom() {
     if (_scrollController.hasClients) {
       _scrollController.animateTo(
         _scrollController.position.minScrollExtent,
         duration: const Duration(milliseconds: 300),
         curve: Curves.easeOut,
       );
     }
   }
  Future<void> getMessage()async{
     try{
       List<String> room = await getRoom();
      final response = await ApiService.getMessage(room);
      if(response['message']== "successfully"){
        print(response);
        setState(() {
          messages = parseMessages(response);
        });
      }else{
        setState(() {
          messages =[];
        });
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget buildScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(leadingWidth: 0,
          backgroundColor: Colors.white,
          leading: const SizedBox(),
          title: Row(
            children: [
              InkWell(
                child:const Icon(Icons.arrow_back),
                onTap: (){
                  Navigator.pop(context);
                },),
              const SizedBox(width: 15,),
                CircleAvatar(backgroundImage: NetworkImage(replaceLocalhost(widget.user.avatar)),
                radius: 18,),
              const SizedBox(width:15,),
              Text(widget.user.name,style: const TextStyle(fontSize: 20),)
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index){
                    final message = messages[index];
                    final isUserMessage = message.sender.id != widget.user.id;
                    return Align(
                      alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.bottomLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isUserMessage ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(16).copyWith(
                          bottomRight: isUserMessage ? Radius.zero : const Radius.circular(16),
                          bottomLeft: isUserMessage ? const Radius.circular(16) : Radius.zero
                        )
                      ),
                      child: Text(message.content,
                      style: TextStyle(
                        color: isUserMessage ? Colors.white : Colors.black
                      ),
                      ),
                    ),
                    );
                  },
              )
          ),
           Padding(
               padding: const EdgeInsets.all(8.0),
             child: Row(
               children: [
                 Expanded(
                   child: TextField(
                     controller: _messageController,
                     decoration: InputDecoration(
                       hintText: "Type a message...",
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(24)
                       ),
                       contentPadding: const EdgeInsets.symmetric(horizontal: 16)
                     ),
                   ),
                 ),
                 const SizedBox(width: 8,),
                 IconButton(
                     onPressed: _sendMessage,
                     icon: const Icon(Icons.send, color: Colors.blue,)
                 )
               ],
             ),
           )
          ]
        ),
      ),
    );
  }
}

