import 'package:flutter/material.dart';
import 'package:kilo/models/http_client.dart';
import 'package:redux/redux.dart';


class KiloState {
  final List sessions;

  KiloState({@required this.sessions});

  factory KiloState.initial() => KiloState(sessions: []);
}

// region Actions
class FetchSessions {}

class Populate {
  final List sessions;
  Populate(this.sessions);
}

class AddToSessions {
  final Map<String, dynamic> session;
  AddToSessions(this.session);
}
// endregion

// region Middleware
void logger(Store<KiloState> store, action, NextDispatcher next) {
  print("Global State Action: $action");
  next(action);
}

void dataProvider(Store<KiloState> store, dynamic action, NextDispatcher next) async {
  if (action is FetchSessions) {
    final HTTPClient client = HTTPClient("35.178.208.241:80");
    Map<String, dynamic> json = await client.get("sessions");

    next(Populate(json["_items"] as List));

  } else {
    next(action);
  }
}
// endregion

KiloState kiloReducer(KiloState currentState, dynamic action) {
  if (action is Populate) {
    action.sessions.sort((a, b) => a["date"].compareTo(b["date"]) as int);
    return KiloState(sessions: action.sessions);

  } else if (action is AddToSessions) {
    List sessions = currentState.sessions;
    sessions.add(action.session);
    sessions.sort((a, b) => a["date"].compareTo(b["date"]) as int);
    return KiloState(sessions: sessions);
  }

  return currentState;
}
