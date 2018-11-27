import 'package:flutter/material.dart';
import 'package:kilo/pages/home.dart';

void main() => runApp(new Kilo());

class Kilo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter Demo",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Home(title: "Kilo"),
    );
  }
}
