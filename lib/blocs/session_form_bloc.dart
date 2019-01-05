import 'package:bloc/bloc.dart';
import 'package:kilo/utils.dart';
import 'package:meta/meta.dart';
import 'package:kilo/models/set_row.dart';


class SessionFormState {
  final String title;
  final DateTime date;
  final SetRow newSetRow;

  SessionFormState({
    @required this.title,
    @required this.date,
    @required this.newSetRow,
  });

  factory SessionFormState.initial() => SessionFormState(
    title: "",
    date: DateTime.now(),
    newSetRow: SetRow(name: "", reps: 0, weight: 0.0, unit: MassUnit.KG),
  );

  factory SessionFormState.fromMap(Map<String, dynamic> map) => SessionFormState(
      title: map["title"],
      date: map["date"],
      newSetRow: map["newSetRow"],
  );

  Map<String, dynamic> toMap() => {
    "title": this.title,
    "date": this.date,
    "newSetRow": this.newSetRow,
  };
}

// region Events
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
// endregion

class SessionFormBloc extends Bloc<SessionFormEvent, SessionFormState> {
  @override
  SessionFormState get initialState => SessionFormState.initial();

  @override
  Stream<SessionFormState> mapEventToState(SessionFormState currentState, SessionFormEvent event) async* {
    Map<String, dynamic> attr = currentState.toMap();

    if (event is UpdateTitle) {
      attr["title"] = event.newValue;
        title: event.newValue,
        date: currentState.date,
        newSetRow: currentState.newSetRow,
      );

    } else if (event is UpdateDate) {
      attr["date"] = event.newValue;
        title: currentState.title,
        date: event.newValue,
        newSetRow: currentState.newSetRow,
      );

    } else if (event is UpdateNewSetRow) {
      attr["newSetRow"] = event.newValue;
        title: currentState.title,
        date: currentState.date,
        newSetRow: event.newValue,
      );
    }

    yield SessionFormState.fromMap(attr);
  }
}
