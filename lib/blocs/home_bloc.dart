import 'package:bloc/bloc.dart';
import 'package:kilo/models/http_client.dart';
import 'package:meta/meta.dart';


class HomeState {
  final List items;

  HomeState(this.items);

  factory HomeState.initial() => HomeState([]);
}

// region Events
abstract class HomeEvent {}

class Populate extends HomeEvent {
  final String username;
  final String password;
  Populate({@required this.username, @required this.password});
}
// endregion

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  @override
  HomeState get initialState => HomeState.initial();

  @override
  Stream<HomeState> mapEventToState(HomeState currentState, HomeEvent event) async* {
    if (event is Populate) {
      HTTPClient client = HTTPClient("35.178.208.241:80");
      Map<String, dynamic> json = await client.get(
          "sessions",
          event.username,
          event.password
      );

      json["_items"].sort((a, b) => a["date"].compareTo(b["date"]) as int);

      yield HomeState(json["_items"]);
    }
  }
}