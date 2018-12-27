import 'package:flutter/material.dart';
import 'package:kilo/pages/session_form.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/blocs/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kilo/models/home_card.dart';


class Home extends StatefulWidget {
  final String title = "Kilo";

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  final HomeBloc _bloc = HomeBloc();

  void _toSessionForm(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SessionForm())
  );

  ListView _buildList(List state) {
    return ListView.builder(
      itemCount: state.length,
      itemBuilder: (BuildContext context, int i) {
        if (state.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return HomeCard.fromJson(state[i]);
      }
    );
  }

  @override
  void initState() {
    super.initState();
    this._bloc.dispatch(Populate(username: "test_hash", password: "pass"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.title),
      ),

      body: BlocBuilder(
        bloc: this._bloc,
        builder: (BuildContext context, List state) => this._buildList(state)
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        tooltip: 'Create a new session',
        onPressed: () => this._toSessionForm(context),
      ),
    );
  }
}