import 'package:flutter/material.dart';
import 'package:kilo/utils/home_card.dart';


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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          HomeCard.fromDetails(
            title: "Leg Day",
            icon: Icons.airline_seat_legroom_normal,
            date: DateTime(2018, 1, 1),
            subtitle: "with Arran, Joel",
          ),
          HomeCard.fromDetails(
            title: "Chest, Tris and Shoulders",
            icon: Icons.phone_android,
            date: DateTime(2018, 7, 14),
            subtitle: "with Arran",
          ),
          HomeCard.fromDetails(
            title: "Bis, Back and Traps",
            icon: Icons.bookmark,
            date: DateTime(2018, 12, 31),
            subtitle: "with Joel",
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