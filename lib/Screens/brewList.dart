import 'package:coffee/Screens/BrewTile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffee/Models/Brew.dart';


class BrewList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _brewListState();
  }

}

// ignore: camel_case_types
class _brewListState extends State<BrewList>{

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile(brews[index]);
      },
    );
  }

}