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
  bool _hasContent = false;
  Widget _content;


  void _toggleContent() {
    setState(() {
      this._hasContent = !this._hasContent;
      if (this._hasContent) {
        this._content = ListView(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.airline_seat_legroom_normal),
                title: Text("Leg Day!"),
                subtitle: Text(this._toDateString(DateTime(2018, 1, 1))),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.phone_android),
                title: Text("Chest, Tris and Shoulders"),
                subtitle: Text(this._toDateString(DateTime(2018, 7, 14))),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.bookmark),
                title: Text("Bis, Back and Traps"),
                subtitle: Text(this._toDateString(DateTime(2018, 12, 31))),
              ),
            ),
          ]
        );
      }

      else {
        this._content = Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Welcome to the start of your gym record!"),
              Text("Press the button in the bottom right to get started")
            ],
          ),
        );
      }
    });
  }

  String _toDateString(DateTime datetime) {
    return formatDate(datetime, [dd, "/", mm, "/", yy]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: this._content,
      floatingActionButton: FloatingActionButton(
        onPressed: this._toggleContent,
        tooltip: 'Toggle Content On/Off',
        child: Icon(Icons.swap_horiz),
      ),
    );
  }
}