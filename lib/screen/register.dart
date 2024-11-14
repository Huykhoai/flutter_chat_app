import 'package:flutter/material.dart';
import 'package:flutter_chat_app/baseScreen/baseScreen.dart';
import 'package:flutter_chat_app/model/register.dart';
import 'package:flutter_chat_app/screen/login.dart';
import 'package:flutter_chat_app/services/api_service.dart';

import '../animation/FadeAnimation.dart';

class RegisterScreen extends Basescreen {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseScreenState<RegisterScreen> {
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  RegExp phoneRegex = RegExp(r'^\d{10,12}$');
  RegExp passwordRegex = RegExp(r'^(?=.*[A-Z]).{8,}$');
  String emailError = "";
  String passwordError = "";
  String usernameError = "";
  String nameError = "";
  bool isLoading = false;
  bool _obscureText = true;
  Future<void> register() async{
    String emailOrPhone = _emailOrPhoneController.text;
    String password = _passwordController.text;
    String username = _userNameController.text;
    String name = _nameController.text;
    setState(() {
      isLoading = true;
      if (emailOrPhone.isNotEmpty && (emailRegex.hasMatch(emailOrPhone) || phoneRegex.hasMatch(emailOrPhone))) {
        emailError = "";
      } else if (emailOrPhone.isEmpty) {
        emailError = "Email or phone number cannot be empty";
      } else {
        emailError = "Invalid email or phone number format";
      }

      if (password.isNotEmpty && passwordRegex.hasMatch(password)) {
        passwordError = "";
      } else if (password.isEmpty) {
        passwordError = "Password cannot be empty";
      } else {
        passwordError = "Password must be at least 8 characters with at least one uppercase letter";
      }

      if(username.isNotEmpty){
        usernameError = "";
      }else{
        usernameError = "Username cannot be empty";
      }
      if(name.isNotEmpty){
        nameError = "";
      }else{
        nameError = "Name cannot be empty";
      }
    });
    if (emailError.isEmpty && passwordError.isEmpty) {
      try{
        final Register register = Register(
            email:emailRegex.hasMatch(emailOrPhone) ? emailOrPhone: "",
            number_phone: phoneRegex.hasMatch(emailOrPhone) ? emailOrPhone: "",
            password: password,
            user_name: username,
            name: name,
            avatar: "");
        final response = await ApiService.register(register);
        print(response);
        if(response['status'] == 201){
          await Future.delayed(const Duration(seconds: 3));
          setState(() {
            isLoading = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return LoginScreen();
          }));
        }else if(response['status'] ==  401){
          await Future.delayed(const Duration(seconds: 3));
          setState(() {
            passwordError = response['message'];
            isLoading = false;
          });
        }
      }catch(e){
        print(e);
      }
    }else {
      setState(() {
        isLoading = false;
      });
    }
  }
  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(left: 0,top: 30.0,bottom: 0,right: 0),
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin:Alignment.topCenter,
                      colors:[
                        Colors.blue,
                        Colors.blue[400]!,
                        Colors.blue[200]!
                      ]
                  )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40,),
                  const Padding(
                    padding:EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FadeAnimation(1, Text("Sign Up", style: TextStyle(color: Colors.white,fontSize: 40),)),
                          SizedBox(height: 10,),
                          FadeAnimation(1.3,Text("Sign Up An Account For You", style: TextStyle(color: Colors.white,fontSize: 18),))
                        ]
                    ),
                  ),
                  const SizedBox(height:20,),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(60),topRight: Radius.circular(60))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                          FadeAnimation(1.4, Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow:  [
                                  BoxShadow(
                                      color: Colors.blue[200]!,
                                      blurRadius: 20,
                                      offset: const Offset(0, 10)
                                  )]
                            ),
                            padding: const EdgeInsets.all(20),
                            child:Column(
                              children: [
                                Container(
                                  padding:const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(0, 238, 238, 238)))
                                  ),
                                  child: TextField(
                                    controller: _emailOrPhoneController,
                                    decoration: InputDecoration(
                                      hintText: "Email or Phone number",
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      errorText: emailError,
                                      errorBorder:emailError.isNotEmpty
                                          ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                                          : null,
                                      icon: const Icon(Icons.email),

                                    ),
                                  ),
                                ),
                                Container(
                                  padding:const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(0, 238, 238, 238)))
                                  ),
                                  child: TextField(
                                    controller: _userNameController,
                                    decoration: InputDecoration(
                                      hintText: "User Name",
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      errorText: emailError,
                                      errorBorder:emailError.isNotEmpty
                                          ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                                          : null,
                                      icon: const Icon(Icons.person),

                                    ),
                                  ),
                                ),
                                Container(
                                  padding:const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(0, 238, 238, 238)))
                                  ),
                                  child: TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                      errorText: emailError,
                                      errorBorder:emailError.isNotEmpty
                                          ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                                          : null,
                                      icon: const Icon(Icons.account_box_outlined),

                                    ),
                                  ),
                                ),
                                Container(
                                  padding:const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Color.fromARGB(0, 238, 238, 238)))
                                  ),
                                  child:  TextField(
                                    controller: _passwordController,
                                    obscureText: _obscureText ? true : false,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: const TextStyle(color: Colors.grey),
                                        border: InputBorder.none,
                                        errorText: passwordError,
                                        errorBorder:passwordError.isNotEmpty
                                            ? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red))
                                            : null,
                                        icon: const Icon(Icons.key),
                                        suffixIcon: IconButton(
                                          onPressed: _togglePasswordView,
                                          icon: Icon(
                                              _obscureText ? Icons.visibility_off : Icons.visibility
                                          ),
                                        ),
                                        suffixIconColor: Colors.black
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                          ),
                          //Text(error, style: const TextStyle(color: Colors.red),),
                          const SizedBox(height: 30,),
                          GestureDetector(
                            child: FadeAnimation(1.6, Container(
                              height: 50,
                              margin: const EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: const Color(0xFFFF5722),
                              ),
                              child: Center(
                                child: isLoading
                                    ? const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.white),)
                                    : const Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
                              ),
                            )
                            ),
                            onTap: (){
                              register();
                            },
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FadeAnimation(1.7, Text("Already have an account? ",style: TextStyle(color: Colors.grey),)),
                              FadeAnimation(1.7, GestureDetector(
                                  onTap: (){
                                    Navigator.pushReplacementNamed(context, '/');
                                  },
                                  child: const Text("Sign in ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)))
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
        )
    );
  }
}
