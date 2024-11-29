import 'dart:convert';

import 'package:flutter_chat_app/model/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
class SocketManager{
  static final String server_url = "http://192.168.88.52:3000";
  static final SocketManager _instance = SocketManager._internal();
  factory SocketManager(){
    return _instance;
  }
  late IO.Socket socket;
  Function(SocketManager)? onMessageReceived;

  SocketManager._internal(){
    try{
      socket = IO.io(server_url,
      IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableAutoConnect()
      .build()
      );
    }catch(error){
      print("Error while creating socket: $error");
    }
  }
  void connect(Function(Message) onReciverMessage){
    socket.connect();
    socket.onConnect((_){
      print("Connected to server");
    });
    socket.on("send_message", (data){
      print(data['data']);
        Message message = Message.fromJson(data['data']);
        onReciverMessage(message);
    });
    socket.onDisconnect((_){
      print('Disconnected from server');
    });
  }
  void disconnect() {
    socket.off('send_message');
    socket.disconnect();
  }
  void sendMessage(List<String> room, String content){
    try{
      final message = {
        'id_receiver': room[0],
        'id_sender': room[1],
        'data':{
          'receiver': room[0],
          'sender': room[1],
          'content':content
        }
      };
      socket.emit("send_message", message);
    } catch (e) {
      print('Error while send message: $e');
    }
  }
  void join_room(List<String> room){
    print("Join room: $room");
    try{
      final roomJson = {
        'id_receiver': room[0],
        'id_sender': room[1]
      };
      socket.emit("join_room", roomJson);
    } catch (e) {
      print('Error while joining room: $e');
    }
  }
}