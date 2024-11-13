import 'package:flutter/material.dart';
import 'package:flutter_chat_app/services/api_service.dart';

import '../animation/FadeAnimation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
   RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
   RegExp phoneRegex = RegExp(r'^\d{10,12}$');
   RegExp passwordRegex = RegExp(r'^(?=.*[A-Z]).{8,}$');
   String emailError = "";
   String passwordError = "";
   bool isLoading = false;
   bool _obscureText = true;
  Future<void> login() async{
    String emailOrPhone = _emailController.text;
    String password = _passwordController.text;
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
    });
    if (emailError.isEmpty && passwordError.isEmpty) {
      try{
        final response = await ApiService.login(emailOrPhone, password);
        print(response);
        if(response['status'] == 200){
          await Future.delayed(const Duration(seconds: 3));
          setState(() {
            isLoading = false;
          });
          Navigator.pushReplacementNamed(context, '/home');
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                      FadeAnimation(1, Text("Login", style: TextStyle(color: Colors.white,fontSize: 40),)),
                      SizedBox(height: 10,),
                      FadeAnimation(1.3,Text("Welcome Back", style: TextStyle(color: Colors.white,fontSize: 18),))
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
                      const SizedBox(height: 60,),
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
                                controller: _emailController,
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
                            )
                            ,
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
                      const SizedBox(height: 40,),
                      const FadeAnimation(1.5,Text("Forgot Password? ", style: TextStyle(color: Colors.grey),)),
                      const SizedBox(height: 20,),
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
                              "Login",
                              style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
                          ),
                        )
                        ),
                        onTap: (){
                          login();
                        },
                      ),
                      const SizedBox(height: 20,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeAnimation(1.7, Text("Don't have an account yet? ",style: TextStyle(color: Colors.grey),)),
                          FadeAnimation(1.7, Text("Register ",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),))
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const FadeAnimation(1.75, Text("Or")),
                      const SizedBox(height: 10,),
                      const FadeAnimation(1.8, Text("Continue with social media",style: TextStyle(color: Colors.grey),)),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                          Expanded(
                            child: FadeAnimation(1.9, Container(
                              height:50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue
                              ),
                              child: const Center(
                                child: Text("Facebook", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
                              ),
                            )
                            ),
                          ),
                          const SizedBox(width: 30,),
                          Expanded(
                            child: FadeAnimation(1.9,Container(
                              height:50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black
                              ),
                              child: const Center(
                                child: Text("Github", style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),),
                              ),
                            )
                            ),
                          )
                        ],
                      )
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
