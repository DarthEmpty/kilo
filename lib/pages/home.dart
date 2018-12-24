import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kilo/models/home_card.dart';
import 'package:kilo/models/http_client.dart';
import 'package:kilo/pages/session_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatefulWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List items = [];
  HTTPClient client = HTTPClient("35.178.208.241:80");

  void _toSessionForm(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SessionForm())
  );

  void _requestItems() async {
    Map<String, dynamic> res = await client.get("card_details", "test_hash", "pass");
    res["_items"].sort((a, b) => a["date"].compareTo(b["date"]) as int);
    setState(() => this.items = res["_items"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          if (i >= this.items.length) {
            if (this.items.isEmpty) {
              this._requestItems();
            }
            return null;
          }

          return HomeCard.fromJson(this.items[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        tooltip: 'Create a new session',
        onPressed: () => this._toSessionForm(context),
      ),
    );
  }
}