import 'package:flutter/material.dart';
import 'package:kilo/pages/session_form_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kilo/blocs/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kilo/models/home_card.dart';


class HomePage extends StatefulWidget {
  final String title = "Kilo";

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc();

  void _toSessionForm(BuildContext context) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SessionFormPage())
  );

  ListView _buildList(HomeState state) {
    return ListView.builder(
      itemCount: state.items.length,
      itemBuilder: (BuildContext context, int i) {
        if (state.items.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return HomeCard.fromJson(state.items[i]);
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
        builder: (BuildContext context, HomeState state) => this._buildList(state)
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        tooltip: 'Create a new session',
        onPressed: () => this._toSessionForm(context),
      ),
    );
  }
}