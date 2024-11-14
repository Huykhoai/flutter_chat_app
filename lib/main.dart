import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_chat_app/screen/home.dart';
import 'package:flutter_chat_app/screen/login.dart';
import 'package:flutter_chat_app/screen/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
class MyCalculator extends StatefulWidget{
  const MyCalculator({super.key});
  @override
  _MyCalculatorState createState() {
    return _MyCalculatorState();
  }
}
class _MyCalculatorState extends State<MyCalculator>{
  TextEditingController number1 = TextEditingController();
  TextEditingController number2 = TextEditingController();

  String kq = '';
  void calculatorSum(){
    double num1 = double.tryParse(number1.text) ?? 0.0;
    double num2 = double.tryParse(number2.text) ?? 0.0;
    double num = num1 + num2;
    setState(() {
      kq = 'Tong: $num';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ung dung tinh tong"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: number1,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "nhap so 1"),
          ),
          const SizedBox(height: 10.0,),
          TextField(
            controller: number2,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "nhap so 2"),
          ),
          const SizedBox(height: 20.0,),
          ElevatedButton(onPressed: calculatorSum,
              child: const Text("Tinh tong")),
          const SizedBox(height: 20.0),
          Text(
            kq,
            style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
          )
        ],
      ),),
    );
  }
}

