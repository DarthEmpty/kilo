import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/pages/session_page.dart';
import 'package:kilo/utils.dart';


class HomeCard {
  final Map<String, dynamic> session;
  BuildContext context;
  Card widget;

  HomeCard(this.session, this.context) {
    this.widget = Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: ListTile(
              leading: Icon(FontAwesomeIcons.dumbbell),
              title: Text(this.session["title"]),
              subtitle: Text(toDateString(
                DateTime.fromMillisecondsSinceEpoch(this.session["date"])
              )),
            )
          ),
          IconButton(
          onPressed: null,
            icon: Icon(FontAwesomeIcons.externalLinkAlt),
          ),
        ],
      )
    );
  }

  factory HomeCard.fromJson(Map<String, dynamic> json, BuildContext context) =>
    HomeCard(json, context);

  void _toSession(BuildContext context) => Navigator.push(
    this.context,
    MaterialPageRoute(builder: (context) => SessionPage(session: this.session))
  );
}