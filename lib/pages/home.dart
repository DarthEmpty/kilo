import 'package:flutter/material.dart';
import 'package:kilo/models/home_card.dart';
import 'package:kilo/pages/session_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/blocs/home_bloc.dart';


class Home extends StatelessWidget {
  final String title = "Kilo";
  final HomeBloc bloc = HomeBloc();

  void _toSessionForm(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SessionForm())
  );

  Widget buildList(BuildContext context, AsyncSnapshot<List<HomeCard>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int i) {
        return snapshot.data[i];
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    this.bloc.fetchAllItems("test_hash", "pass");

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),

      body: StreamBuilder(
        stream: this.bloc.homeCardStream,
        builder: (BuildContext context, AsyncSnapshot<List<HomeCard>> snapshot) {
          if (snapshot.hasData) {
            return this.buildList(context, snapshot);
          }
          return Center(child: CircularProgressIndicator());
        }
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        tooltip: 'Create a new session',
        onPressed: () => this._toSessionForm(context),
      ),
    );
  }
}