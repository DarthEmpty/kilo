import 'package:flutter/material.dart';
import 'package:kilo/pages/intro.dart';
import 'package:kilo/utils/card_factory.dart';


class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _toIntro(BuildContext context) => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    CardFactory cardFactory = CardFactory();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          cardFactory.buildCard(
            "Leg Day",
            Icons.airline_seat_legroom_normal,
            DateTime(2018, 1, 1),
            "with Arran, Joel",
          ),
          cardFactory.buildCard(
            "Chest, Tris and Shoulders",
            Icons.phone_android,
            DateTime(2018, 7, 14),
            "with Arran",
          ),
          cardFactory.buildCard(
            "Bis, Back and Traps",
            Icons.bookmark,
            DateTime(2018, 12, 31),
            "with Joel",
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => this._toIntro(context),
        tooltip: 'Toggle Content On/Off',
        child: Icon(Icons.swap_horiz),
      ),
    );
  }
}