import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kilo/utils/home_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _toIntro(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    print(json.encode(HomeCard(
      title: "Leg Day",
      date: DateTime(2018, 1, 1),
      subtitle: "with Arran, Joel",
    )));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          HomeCard(
            title: "Leg Day",
            date: DateTime(2018, 1, 1),
            subtitle: "with Arran, Joel",
          ),
          HomeCard(
            title: "Chest, Tris and Shoulders",
            date: DateTime(2018, 7, 14),
            subtitle: "with Arran",
          ),
          HomeCard(
            title: "Bis, Back and Traps",
            date: DateTime(2018, 12, 31),
            subtitle: "with Joel",
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => this._toIntro(context),
        tooltip: 'Toggle Content On/Off',
        child: Icon(FontAwesomeIcons.exchangeAlt),
      ),
    );
  }
}