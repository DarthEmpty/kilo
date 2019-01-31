import 'package:flutter/material.dart';
import 'package:kilo/models/set_row.dart';
import 'package:kilo/utils.dart';

class SessionPage extends StatelessWidget {
  final String title = "Session";
  final Map<String, dynamic> session;

  SessionPage({Key key, @required this.session}): super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(this.title),),

    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.session["title"] as String),
          Text(toDateString(
            DateTime.fromMillisecondsSinceEpoch(this.session["date"] as int))
          ),
          Text("Sets:"),
          Table(children: (this.session["sets"] as List)
            .map((set) => SetRow.fromJson(set, null).widget)
            .toList()
          )
        ],
      ),
    ),
  );
}