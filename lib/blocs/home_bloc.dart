import 'package:rxdart/rxdart.dart';
import 'package:kilo/models/home_card.dart';
import 'package:kilo/models/http_client.dart';


class HomeBloc {
  HTTPClient _client = HTTPClient("35.178.208.241:80");
  PublishSubject<List<HomeCard>> _source = PublishSubject<List<HomeCard>>();

  Observable<List<HomeCard>> get homeCardStream => this._source.stream;

  void dispose() => this._source.close();

  void fetchAllItems(String username, String password) async {
    Map<String, dynamic> json = await this._client.get(
        "card_details", username, password
    );
    json["_items"].sort((a, b) => a["date"].compareTo(b["date"]) as int);

    List<HomeCard> cards = [];
    for (dynamic item in json["_items"]) {
      cards.add(HomeCard.fromJson(item));
    }

    this._source.add(cards);
  }
}