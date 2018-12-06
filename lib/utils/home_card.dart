import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class HomeCard extends Card {
  final String title;
  final DateTime date;
  final String subtitle;

  static String _toDateString(DateTime datetime) {
    return formatDate(datetime, [dd, "/", mm, "/", yy]);
  }

  HomeCard({this.title, this.date, this.subtitle}): super(
    child: Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            leading: Icon(FontAwesomeIcons.dumbbell),
            title: Text(title),
            subtitle: Text(HomeCard._toDateString(date) + " " + subtitle),
          )
        ),
        IconButton(
          onPressed: null,
          icon: Icon(FontAwesomeIcons.externalLinkAlt),
        ),
      ],
    )
  );

  factory HomeCard.fromJson(Map<String, dynamic> json) {
    return HomeCard(
      title: json["title"] as String,
      date: DateTime.fromMillisecondsSinceEpoch(json["date"] as int),
      subtitle: json["subtitle"] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    "title": this.title,
    "date": this.date.millisecondsSinceEpoch,
    "subtitle": this.subtitle
  };
}