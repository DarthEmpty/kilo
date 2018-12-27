import 'package:flutter/material.dart';
import 'package:kilo/pages/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class IntroPage extends StatelessWidget {
  void _toHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Welcome to the start of your gym record!"),
            Text("Press the button in the bottom right to get started")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => this._toHomePage(context),
        tooltip: "Go Home",
        child: Icon(FontAwesomeIcons.home),
      ),
    );
  }
}