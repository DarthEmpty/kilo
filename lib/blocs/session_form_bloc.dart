import 'package:bloc/bloc.dart';
import 'package:kilo/utils.dart';
import 'package:meta/meta.dart';


class SessionFormState {
  final String title;
  final DateTime date;
  final MassUnit unit;

  SessionFormState({
    @required this.title,
    @required this.date,
    @required this.unit,
  });

  factory SessionFormState.initial() => SessionFormState(
    title: "",
    date: DateTime.now(),
    unit: null,
  );
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

class UpdateUnit extends SessionFormEvent {
  final MassUnit newValue;
  UpdateUnit(this.newValue);
}
// endregion

class SessionFormBloc extends Bloc<SessionFormEvent, SessionFormState> {
  @override
  SessionFormState get initialState => SessionFormState.initial();

  @override
  Stream<SessionFormState> mapEventToState(SessionFormState currentState, SessionFormEvent event) async* {
    if (event is UpdateTitle) {
      yield SessionFormState(
        title: event.newValue,
        date: currentState.date,
        unit: currentState.unit,
      );

    } else if (event is UpdateDate) {
      yield SessionFormState(
        title: currentState.title,
        date: event.newValue,
        unit: currentState.unit,
      );

    } else if (event is UpdateUnit) {
      yield SessionFormState(
        title: currentState.title,
        date: currentState.date,
        unit: event.newValue,
      );
    }
  }
}
