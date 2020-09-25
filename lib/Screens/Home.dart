import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee/Models/Brew.dart';
import 'package:coffee/Screens/panel_settings.dart';
import 'package:coffee/Services/auth.dart';
import 'package:coffee/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/Screens/brewList.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _showPanelSettings(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          child: Padding (
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: PanelSettings(),
          ),
        );
      });
    }

    final AuthService _auth = AuthService();
    return StreamProvider<List<Brew>>.value(
      value: DataBaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text("Coffee App"),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text("Logout")),
            FlatButton.icon(
                onPressed: ()  {
                  _showPanelSettings();
                },
                icon: Icon(Icons.settings),
                label: Text("Settings")),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
