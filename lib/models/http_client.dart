import 'dart:core';
import 'dart:convert';

import 'package:http/http.dart';


class HTTPClient {
  static final Map<String, HTTPClient> _cache = {};
  static final String protocol = "http://";
  final Client _inner = Client();
  final String domain;
  String auth;

  static String _authString(String username, String password) =>
    Base64Codec().encode(Latin1Codec().encode("$username:$password"));

  HTTPClient._internal(this.domain, String username, String password):
    this.auth = HTTPClient._authString(username, password);

  factory HTTPClient(String domain, {String username, String password}) {
    if (HTTPClient._cache.containsKey(domain)) {
      return HTTPClient._cache[domain];
    }

    print("CREATE CLIENT: $domain");
    return HTTPClient._internal(domain, username, password);
  }

  String _buildURL(String collection) => "$protocol$domain/$collection";

  void setAuth(String username, String password) =>
    this.auth = HTTPClient._authString(username, password);

  void close() {
    this._inner.close();
    HTTPClient._cache.remove(this.domain);
  }

  Future<int> head(String entity) async {
    String url = this._buildURL(entity);
    Map<String, String> headers = {"Authorization": "Basic $auth"};

    print("HEAD $entity ${headers.toString()}");

    Response res = await this._inner.head(url, headers: headers);
    return res.statusCode;
  }

  Future<Map<String, dynamic>> get(String collection) async {
    String url = this._buildURL(collection);
    Map<String, String> headers = {"Authorization": "Basic $auth"};

    print("GET $collection ${headers.toString()}");

    Response res =  await this._inner.get(url, headers: headers);
    return json.decode(res.body);
  }

  Future<Map<String, dynamic>> post(String collection, Map<String, dynamic> body) async {
    String url = this._buildURL(collection);
    Map<String, String> headers = {
      "Authorization": "Basic $auth",
      "Content-Type": "application/json"
    };

    print("POST $collection ${headers.toString()} ${body.toString()}");

    Response res =  await this._inner.post(
      url,
      headers: headers,
      body: json.encode(body)
    );
    return json.decode(res.body);
  }
}
