import 'package:flutter/material.dart';
import 'package:kilo/models/http_client.dart';
import 'package:redux/redux.dart';


class KiloState {
  final List sessions;

  KiloState({@required this.sessions});

  factory KiloState.initial() => KiloState(sessions: []);
}

// region Actions
class FetchSessions {
  final String username;
  final String password;
  FetchSessions({@required this.username, @required this.password});
}

class Populate {
  final Map<String, dynamic> json;
  Populate(this.json);
}
// endregion

// region Middleware
void logger(Store<KiloState> store, action, NextDispatcher next) {
  print("Action!: $action");
  next(action);
}

void dataProvider(Store<KiloState> store, dynamic action, NextDispatcher next) async {
  if (action is FetchSessions) {
    final HTTPClient client = HTTPClient("35.178.208.241:80");
    Map<String, dynamic> json = await client.get(
        "sessions",
        action.username,
        action.password
    );

    next(Populate(json));
  }
}
// endregion

KiloState kiloReducer(KiloState currentState, dynamic action) {
  if (action is Populate) {
    action.json["_items"].sort((a, b) => a["date"].compareTo(b["date"]) as int);
    return KiloState(sessions: action.json["_items"] as List);
  }

  return currentState;
}
