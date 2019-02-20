import 'package:flutter/material.dart';
import 'package:kilo/models/http_client.dart';
import 'package:redux/redux.dart';
import 'utils.dart';


class KiloState {
  final HTTPClient client;
  final bool loggedIn;
  final List sessions;

  KiloState({
    @required this.client,
    @required this.loggedIn,
    @required this.sessions,
  });

  factory KiloState.initial() => KiloState(
    client: HTTPClient(kiloServerIP),
    loggedIn: false,
    sessions: [],
  );
}

// region Actions
class SubmitCredentials {
  final String username;
  final String password;
  SubmitCredentials(this.username, this.password);
}

class ResolveLogIn {
  final int status;
  ResolveLogIn(this.status);
}

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
    Map<String, dynamic> json = await store.state.client.get("sessions");
    next(Populate(json["_items"] as List));

  } else if (action is SubmitCredentials) {
    store.state.client.setAuth(action.username, action.password);
    int status = await store.state.client.head("accounts/${action.username}");
    next(ResolveLogIn(status));

  } else {
    next(action);
  }
}
// endregion

KiloState kiloReducer(KiloState currentState, dynamic action) {
  if (action is Populate) {
    action.sessions.sort((a, b) => a["date"].compareTo(b["date"]) as int);
    return KiloState(
      client: currentState.client,
      loggedIn: currentState.loggedIn,
      sessions: action.sessions,
    );

  } else if (action is AddToSessions) {
    List sessions = currentState.sessions;
    sessions.add(action.session);
    sessions.sort((a, b) => a["date"].compareTo(b["date"]) as int);
    return KiloState(
      client: currentState.client,
      loggedIn: currentState.loggedIn,
      sessions: sessions,
    );

  } else if (action is ResolveLogIn && action.status == 200) {
    return KiloState(
      client: currentState.client,
      loggedIn: true,
      sessions: currentState.sessions,
    );
  }

  return currentState;
}
