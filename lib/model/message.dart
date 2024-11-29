import 'package:flutter_chat_app/model/user_message.dart';

class Message{
  final String id;
  final String room;
  final User receiver;
  final User sender;
  final String content;
  final DateTime timestamp;

  Message({required this.id,required this.room,required this.receiver,required this.sender,required this.content,
    required this.timestamp});

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      id: json['_id'] ?? '',
      room: json['room'] ?? '',
      receiver: User.fromJson(json['receiver'] ?? {}),
      sender: User.fromJson(json['sender'] ?? {}) ,
      content: json['content'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? ''),
    );
  }
  Map<String, dynamic> toJson(){
    return {
      '_id':id,
      'room': room,
      'receiver': receiver.toJson(),
      'sender': sender.toJson(),
      'content': content,
      'timestamp': timestamp.toIso8601String()
    };
  }
}