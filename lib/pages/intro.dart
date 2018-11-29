import 'package:flutter/material.dart';
import 'package:kilo/pages/home.dart';

class Intro extends StatelessWidget {
  void _toHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home(title: "Kilo",))
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
        onPressed: () => this._toHome(context),
        tooltip: "Go Home",
        child: Icon(Icons.home),
      ),
    );
  }
}