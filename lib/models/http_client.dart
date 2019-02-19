import 'dart:core';
import 'dart:convert';

import 'package:http/http.dart';


class HTTPClient {
  static final Map<String, HTTPClient> _cache = {};
  static final String protocol = "http://";
  final Client _inner = Client();
  final String domain;
  String auth;

  static String _toBase64(String string) =>
      Base64Codec().encode(Latin1Codec().encode(string));

  HTTPClient._internal(this.domain, String username, String password):
    this.auth = HTTPClient._toBase64("$username:$password");

  factory HTTPClient(String domain, {String username, String password}) {
    if (HTTPClient._cache.containsKey(domain)) {
      return HTTPClient._cache[domain];
    }

    return HTTPClient._internal(domain, username, password);
  }

  setAuth(String username, String password) =>
    this.auth = HTTPClient._toBase64("$username:$password");

  void close() {
    this._inner.close();
    HTTPClient._cache.remove(this.domain);
  }

  String buildURL(String collection) => "$protocol$domain/$collection";

  Future<int> head(String collection) async {
    String url = this.buildURL(collection);
    Map<String, String> headers = {"Authorization": "Basic $auth"};

    Response res = await this._inner.head(url, headers: headers);
    return res.statusCode;
  }

  Future<Map<String, dynamic>> get(String collection) async {
    String url = this.buildURL(collection);
    Map<String, String> headers = {"Authorization": "Basic $auth"};

    Response res =  await this._inner.get(url, headers: headers);
    return json.decode(res.body);
  }

  Future<Map<String, dynamic>> post(String collection, Map<String, dynamic> body) async {
    String url = this.buildURL(collection);
    Map<String, String> headers = {
      "Authorization": "Basic $auth",
      "Content-Type": "application/json"
    };

    Response res =  await this._inner.post(
      url,
      headers: headers,
      body: json.encode(body)
    );
    return json.decode(res.body);
  }
}
