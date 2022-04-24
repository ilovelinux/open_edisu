import 'dart:developer';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants/urls.dart' as urls;

class HttpClient extends http.BaseClient {
  static const _storage = FlutterSecureStorage();
  final http.Client _inner = http.Client();
  String? _token;

  Future<void> restore() async => _token = await _storage.read(key: "token");

  Future<void> setToken(String? newToken) async =>
      await _storage.write(key: "token", value: _token = newToken);

  bool isAuthenticated() => _token != null;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    if (request.url != urls.signin) {
      request.headers[HttpHeaders.authorizationHeader] = "Bearer ${_token!}";
    }

    return _inner.send(request);
  }

  Future<Map<String, dynamic>> postAPIRaw(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final response =
        await post(url, headers: headers, body: body, encoding: encoding);

    final data = jsonDecode(utf8.decode(response.bodyBytes));
    log("$url : ${response.body}", name: "HTTP");

    if (data["status"] != 202) {
      final message = data["message"] ?? data["messsage"];
      throw ApiException(data["status"], message, data["error"], data);
    }

    return data;
  }

  Future<Map<String, dynamic>> postAPI(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final data =
        await postAPIRaw(url, headers: headers, body: body, encoding: encoding);

    return data["result"];
  }
}

class ApiException implements Exception {
  ApiException(this.status, this.message, this.error, [this.data]);

  // Used only for debugging purposes
  final Map? data;

  final int status;
  final String message;
  final String? error;

  @override
  String toString() => "$status: $message : $error";
}
