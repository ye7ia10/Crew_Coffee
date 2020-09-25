import 'package:coffee/Screens/Sign_In.dart';
import 'package:coffee/Screens/Sign_Up.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _AuthenticateState();
  }

}

class _AuthenticateState extends State<Authenticate>{

  bool isSignIn = true;
  void toggleView (){
    setState(() {
      isSignIn = !isSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (isSignIn){
      return SignIn(toggleView);
    } else {
      return SignUp(toggleView);
    }
  }
}