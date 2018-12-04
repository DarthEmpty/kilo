import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';


class HomeCard extends Card {
  static String _toDateString(DateTime datetime) {
    return formatDate(datetime, [dd, "/", mm, "/", yy]);
  }

  HomeCard({child}): super(child: child);

  HomeCard.fromDetails({title, icon, date, subtitle}): this(
    child: Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            leading: Icon(icon),
            title: Text(title),
            subtitle: Text(HomeCard._toDateString(date) + " " + subtitle),
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