import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/utils.dart';


class HomeCard extends Card {
  final String title;
  final DateTime date;

  HomeCard({
    @required this.title,
    @required this.date,
  }): super(
    child: Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            leading: Icon(FontAwesomeIcons.dumbbell),
            title: Text(title),
            subtitle: Text(toDateString(date)),
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
      date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "title": this.title,
    "date": this.date.millisecondsSinceEpoch,
  };
}