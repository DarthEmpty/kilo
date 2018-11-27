import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  String _asDateString(DateTime datetime) {
    return formatDate(datetime, [dd, "/", mm, "/", yy]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.account_box),
              title: Text("Leg Day!"),
              subtitle: Text(_asDateString(DateTime(2018, 1, 1))),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.phone_android),
              title: Text("Chest, Tris and Shoulders"),
              subtitle: Text(_asDateString(DateTime(2018, 7, 14))),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.bookmark),
              title: Text("Bis, Back and Traps"),
              subtitle: Text(_asDateString(DateTime(2018, 12, 31))),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}