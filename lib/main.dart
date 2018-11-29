import 'package:flutter/material.dart';
import 'package:kilo/pages/intro.dart';

void main() => runApp(Kilo());

class Kilo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kilo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Intro(),
    );
  }
}
