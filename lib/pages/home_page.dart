import 'package:flutter/material.dart';
import 'package:kilo/pages/session_form_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/models/home_card.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kilo/global_state.dart';


class HomePage extends StatefulWidget {
  final String title = "Kilo";

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  void _toSessionForm(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SessionFormPage())
  );

  Widget _buildList(List sessions) => ListView.builder(
    itemCount: sessions.length,
    itemBuilder: (BuildContext context, int i) {
      if (sessions.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return HomeCard.fromJson(sessions[i], context).widget;
    }
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
        automaticallyImplyLeading: false,
      ),

      body: StoreConnector<KiloState, List>(
        onInit: (Store<KiloState> store) => store.dispatch(FetchSessions()),
        converter: (Store<KiloState> store) => store.state.sessions,
        builder: (BuildContext context, List sessions) => this._buildList(sessions),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        tooltip: 'Create a new session',
        onPressed: () => this._toSessionForm(context),
      ),
    )
  );
}