import 'package:coffee/Services/auth.dart';
import 'package:coffee/Sharred/LoadingKit.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget{
  final Function toggleView;
  SignIn(this.toggleView);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInState();
  }

}

class _SignInState extends State<SignIn>{

  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();
    final _formKey = GlobalKey<FormState>();

    String email = "";
    String password  = "";
    String err = "";
    bool loading = false;

    return loading ? LoadingKit() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[200],
        elevation: 0.0,
        title: Text("Sign In"),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){widget.toggleView();}, icon:Icon(Icons.person), label:Text("Sign up")),
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
              validator: (val) => val.isEmpty ? 'Enter Your Email' : null,
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
              validator: (val) => val.length < 6 ? 'Enter Your Valid Passwrod' : null,
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
                'Login',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                if (_formKey.currentState.validate()){
                  setState(() {
                    loading = true;
                  });
                  dynamic result =  await _auth.loginUser(email, password);
                  if (result == null){
                    setState(() {
                      loading = false;
                      err = "User does not have an account or invalid password.";
                    });
                  } // else go to automatic to Home page.
                }
              },
            ),
            SizedBox(height: 20.0,),
            Text(
              err,
              style: TextStyle(color: Colors.red, fontSize: 14.0),
            )
          ],
        ),
      )
    );
  }


}