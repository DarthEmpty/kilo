import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kilo/pages/intro_page.dart';

void main() {
  BlocSupervisor().delegate = Delegate();
  runApp(Kilo());
}

class Delegate implements BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

class Kilo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kilo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage(),
    );
  }
}
