import 'dart:core';
import 'dart:convert';

import 'package:http/http.dart';


class HTTPClient {
  static final Map<String, HTTPClient> _cache = {};
  static final String protocol = "http://";
  final String host;
  final Client _inner;

  HTTPClient._internal(this.host) : this._inner = Client();

  factory HTTPClient(String host) {
    if (HTTPClient._cache.containsKey(host)) {
      return HTTPClient._cache[host];
    }

    return HTTPClient._internal(host);
  }

  String _toBase64(String string) =>
      Base64Codec().encode(Latin1Codec().encode(string));

  void close() {
    this._inner.close();
    HTTPClient._cache.remove(this.host);
  }

  Future<Map<String, dynamic>> get(String collection, String username, String password) async {
    String url = "${HTTPClient.protocol}${this.host}/$collection";
    String auth = this._toBase64("$username:$password");
    Map<String, String> headers = {"Authorization": "Basic $auth"};

    Response res =  await this._inner.get(url, headers: headers);
    return json.decode(res.body);
  }
}
