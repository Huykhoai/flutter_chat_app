import 'package:flutter/material.dart';
import 'package:flutter_chat_app/model/coffee.dart';
import 'package:image_slide_show/image_slide_show.dart';

class Message extends StatefulWidget {
  const Message(this.coffee,{super.key});
  final Coffee coffee;
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  final List<Map<String, dynamic>> messages = [
    {'text': 'Hello!', 'isUserMessage': false},
    {'text': 'Hi! How are you?', 'isUserMessage': true},
    {'text': 'I’m good, thanks!', 'isUserMessage': false},
    {'text': 'What about you?', 'isUserMessage': false},
    {'text': 'I’m doing well too.', 'isUserMessage': true},
  ];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.insert(0, {'text':_messageController.text,'isUserMessage':true}); // Thêm tin nhắn mới vào đầu danh sách
      });
      _messageController.clear();
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
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
              const SizedBox(width: 10,),
                CircleAvatar(backgroundImage: NetworkImage(widget.coffee.image),
                radius: 18,),
              const SizedBox(width:10,),
              Text(widget.coffee.title,style: const TextStyle(fontSize: 18),)
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index){
                    final message = messages[index];
                    final isUserMessage = message['isUserMessage'] as bool;
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
                      child: Text(message['text'],
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

