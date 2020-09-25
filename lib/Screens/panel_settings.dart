import 'package:coffee/Models/User.dart';
import 'package:coffee/Services/database.dart';
import 'package:coffee/Sharred/LoadingKit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PanelSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _panelState();
  }
}

class _panelState extends State<PanelSettings> {
  final key = GlobalKey<FormState>();
  List<String> sugars = ['0', '1', '2', '3', '4'];

  String _name, _sugar;
  int _strength;

  @override
  Widget build(BuildContext context) {
    final user =
        Provider.of<User>(context); //called whenever user value change.
    return StreamBuilder<UserData>(
        stream: DataBaseService(cUId: user.uId).user,
        builder: (context, snapshot) {
          //if (snapshot.hasData) {
            UserData data = snapshot.data;
            return Form(
              key: key,
              child: Column(
                children: <Widget>[
                  Text(
                    "Update your settings",
                    style: TextStyle(color: Colors.brown, fontSize: 18.0),
                  ),
                  TextFormField(
                    initialValue: data.name ?? " ",
                    decoration: InputDecoration(
                      hintText: "Name",
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.brown[500], width: 2.0),
                      ),
                    ),
                    validator: (val) => val.isEmpty ? "Enter Your Name" : null,
                    onChanged: (val) {
                      setState(() {
                        _name = val;
                      });
                    },
                  ),
                  DropdownButtonFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.brown[500], width: 2.0),
                        ),
                      ),
                      value: _sugar ?? data.sugar ?? "0",
                      items: sugars.map((sug) {
                        return DropdownMenuItem(
                          value: sug,
                          child: Text('$sug sugars'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _sugar = val;
                        });
                      }),
                  Slider(
                      value: (_strength ?? data.strength ?? 100).toDouble(),
                      activeColor: Colors.brown[_strength ?? data.strength ?? 100],
                      inactiveColor: Colors.brown[_strength ?? data.strength ?? 100],
                      min: 100.0,
                      max: 900.0,
                      divisions: 8,
                      onChanged: (val) {
                        setState(() {
                          _strength = val.round();
                        });
                      }),
                  RaisedButton(
                    child: Text(
                      "Update",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    color: Colors.pink[400],
                    onPressed: () async {
                      if (key.currentState.validate()){
                        await DataBaseService(cUId : user.uId).UpdateData(_name ?? data.name,
                            _sugar ?? data.sugar, _strength ?? data.strength);
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
         // } else {
            return LoadingKit();
       //   }
        });
  }
}
