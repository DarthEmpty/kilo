import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class SessionFormState {
  final String title;
  final DateTime date;

  SessionFormState({@required this.title, @required this.date});

  factory SessionFormState.initial() => SessionFormState(
    title: "",
    date: DateTime.now()
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
// endregion

class SessionFormBloc extends Bloc<SessionFormEvent, SessionFormState> {
  @override
  SessionFormState get initialState => SessionFormState.initial();

  @override
  Stream<SessionFormState> mapEventToState(SessionFormState currentState, SessionFormEvent event) async* {
    if (event is UpdateTitle) {
      yield SessionFormState(
        title: event.newValue,
        date: currentState.date
      );

    } else if (event is UpdateDate) {
      yield SessionFormState(
        title: currentState.title,
        date: event.newValue,
      );
    }
  }
}
