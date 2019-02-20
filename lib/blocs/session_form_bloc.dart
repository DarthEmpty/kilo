import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kilo/utils.dart';
import 'package:kilo/models/set_row.dart';
import 'package:kilo/models/http_client.dart';


@immutable
class SessionFormState {
  final String title;
  final DateTime date;
  final bool addButtonEnabled;
  final SetRow newSetRow;
  final Set<SetRow> tableRows;

  SessionFormState({
    @required this.title,
    @required this.date,
    @required this.addButtonEnabled,
    @required this.newSetRow,
    @required this.tableRows,
  });

  factory SessionFormState.initial() => SessionFormState(
    title: "",
    date: DateTime.now(),
    addButtonEnabled: false,
    newSetRow: SetRow(name: "", reps: 0, weight: 0.0, unit: MassUnit.KG),
    tableRows: LinkedHashSet()
  );

  factory SessionFormState.fromMutable(Map<String, dynamic> map) => SessionFormState(
    title: map["title"],
    date: map["date"],
    addButtonEnabled: map["addButtonEnabled"],
    newSetRow: map["newSetRow"],
    tableRows: map["tableRows"],
  );

  Map<String, dynamic> toMutable() => {
    "title": this.title,
    "date": this.date,
    "addButtonEnabled": this.addButtonEnabled,
    "newSetRow": this.newSetRow,
    "tableRows": this.tableRows,
  };

  Map<String, dynamic> toJson() => {
    "title": this.title,
    "date": this.date.millisecondsSinceEpoch,
    "sets": this.tableRows.map((SetRow row) => row.toJson()).toList()
  };
}

// region Events
@immutable
abstract class SessionFormEvent {}

class UpdateTitle extends SessionFormEvent {
  final String newValue;
  UpdateTitle(this.newValue);
}

class UpdateDate extends SessionFormEvent {
  final DateTime newValue;
  UpdateDate(this.newValue);
}

class UpdateNewSetRow extends SessionFormEvent {
  final SetRow newValue;
  UpdateNewSetRow(this.newValue);
}

class CheckIfAddButtonEnabled extends SessionFormEvent {
  final bool newValue;
  CheckIfAddButtonEnabled(this.newValue);
}

class AddToTable extends SessionFormEvent {}

class RemoveFromTable extends SessionFormEvent {
  final SetRow row;
  RemoveFromTable(this.row);
}

class PostSession extends SessionFormEvent {
  final Map<String, dynamic> session;
  PostSession(this.session);
}
// endregion

class SessionFormBloc extends Bloc<SessionFormEvent, SessionFormState> {
  @override
  SessionFormState get initialState => SessionFormState.initial();

  @override
  Stream<SessionFormState> mapEventToState(SessionFormState currentState, SessionFormEvent event) async* {
    Map<String, dynamic> attr = currentState.toMutable();

    if (event is UpdateTitle) {
      attr["title"] = event.newValue;

    } else if (event is UpdateDate) {
      attr["date"] = event.newValue;

    } else if (event is UpdateNewSetRow) {
      attr["newSetRow"] = event.newValue;

    } else if (event is CheckIfAddButtonEnabled) {
      attr["addButtonEnabled"] = event.newValue;

    } else if (event is AddToTable) {
      (attr["tableRows"] as Set).add(attr["newSetRow"].copy());

    } else if (event is RemoveFromTable) {
      (attr["tableRows"] as Set).remove(event.row);

    } else if (event is PostSession) {
      HTTPClient client = HTTPClient(kiloServerIP);
      client.post("sessions", event.session);
    }

    yield SessionFormState.fromMutable(attr);
  }
}
