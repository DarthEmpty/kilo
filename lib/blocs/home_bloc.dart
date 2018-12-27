import 'package:bloc/bloc.dart';
import 'package:kilo/models/http_client.dart';
import 'package:meta/meta.dart';


// region Events
abstract class HomeEvent {}

class Populate extends HomeEvent {
  final String username;
  final String password;
  Populate({@required this.username, @required this.password});
}
// endregion

class HomeBloc extends Bloc<HomeEvent, List>{
  @override
  List get initialState => [];

  @override
  Stream<List> mapEventToState(List currentState, HomeEvent event) async* {
    if (event is Populate) {
      HTTPClient client = HTTPClient("35.178.208.241:80");
      Map<String, dynamic> json = await client.get(
          "card_details",
          event.username,
          event.password
      );

      json["_items"].sort((a, b) => a["date"].compareTo(b["date"]) as int);

      yield json["_items"];
    }
  }
}