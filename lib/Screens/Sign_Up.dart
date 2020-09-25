import 'package:coffee/Services/auth.dart';
import 'package:coffee/Services/database.dart';
import 'package:coffee/Sharred/LoadingKit.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget{

  final Function toggleView;
  SignUp(this.toggleView);

  @override
  State<StatefulWidget> createState() {
    return _signUpState();
  }

}

// ignore: camel_case_types
class _signUpState extends State<SignUp>{

  AuthService _auth = AuthService();
  String email = "";
  String password  = "";
  String err = "";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading ? LoadingKit() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[200],
          elevation: 0.0,
          title: Text("Sign Up"),
          actions: <Widget>[
            FlatButton.icon(onPressed: (){widget.toggleView();}, icon:Icon(Icons.person), label:Text("Sign In")),
          ],
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown[500], width: 2.0),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Enter Your E-mail' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Password",
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.brown[500], width: 2.0),
                  ),
                ),
                validator: (val) => val.length < 6 ? 'Enter Your 6+ Password' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.brown[500],
                child: Text(
                  'Regiter',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.registerUser(email, password);
                    if (result == null){
                      setState(() {
                        loading = false;
                        err = "Enter A Valid Mail";
                      });
                    }  // else it will automatically go to home because of stream provider.
                  }
                },
              ),
              SizedBox(height: 20.0,),
              Text(
                err,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
              )
            ],
          ),
        )
    );
  }

}