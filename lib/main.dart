import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:kilo/global_state.dart';
import 'package:kilo/pages/intro_page.dart';
import 'package:redux/redux.dart';


class Delegate implements BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }
}

class Kilo extends StatelessWidget {
  final Store<KiloState> store;

  Kilo(this.store);

  Widget build(BuildContext context) => StoreProvider<KiloState>(
    store: this.store,
    child: MaterialApp(
      title: "Kilo",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IntroPage(),
    )
  );
}

void main() {
  BlocSupervisor().delegate = Delegate();
  Store<KiloState> store = Store<KiloState>(
    kiloReducer,
    initialState: KiloState.initial(),
    middleware: [logger, dataProvider]
  );

  runApp(Kilo(store));
}