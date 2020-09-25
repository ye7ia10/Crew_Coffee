
import 'package:coffee/Screens/Authenticate.dart';
import 'package:coffee/Screens/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:coffee/Models/User.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);   //called whenever user value change.
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }

}