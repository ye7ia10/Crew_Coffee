import 'dart:math';

import 'package:coffee/Models/User.dart';
import 'package:coffee/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _getUserFromFireBase(FirebaseUser user) {
    return user != null ? User(user.uid) : null;
  }

  //Detect if the user is logged in or not.
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_getUserFromFireBase);
  }

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _getUserFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerUser(String email, String password) async{
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      DataBaseService(cUId: result.user.uid).UpdateData("name", "2", 100);
      return _getUserFromFireBase(result.user);
    } catch (e) {
      return null;
    }
  }

  Future loginUser(String email, String password) async{
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return _getUserFromFireBase(result.user);
    } catch (e) {
      return null;
    }
  }

  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch (e){
      return null;
    }
  }
}
