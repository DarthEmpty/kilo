import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';


class CardFactory {
  // Runs internal constructor and store result
  static final CardFactory _instance = CardFactory._internal();

  // Returns instance created by internal constructor
  factory CardFactory() => CardFactory._instance;

  // Internal constructor
  CardFactory._internal();

  String _toDateString(DateTime datetime) {
    return formatDate(datetime, [dd, "/", mm, "/", yy]);
  }

  Card buildCard(title, icon, date, subtitle) {
    StringBuffer buf = StringBuffer(this._toDateString(date));
    buf.write(" ");
    buf.write(subtitle);

    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
              child: ListTile(
                leading: Icon(icon),
                title: Text(title),
                subtitle: Text(buf.toString()),
              )
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.open_in_new),
          ),
        ],
      )
    );
  }
}