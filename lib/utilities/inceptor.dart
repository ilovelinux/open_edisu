import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:open_edisu/network/client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network/api.dart';

void initInceptor() {
  final dio = Dio(BaseOptions(receiveDataWhenStatusError: true))
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await flutterSecureStorage.read(key: 'token');
          if (token != null) {
            options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
          }
          handler.next(options);
        },
        // onResponse: (response, handler) {
        //   print(response.statusCode);
        //   print(response);
        //   // final message = response.data.message ?? response["messsage"];
        //   // if (message != "success") {
        //   //   response.;
        //   // }
        // },
        onError: (error, handler) {
          if (error.type == DioErrorType.response) {
            final response = error.response!.data as Map;

            final status = response["status"];
            final errormsg = response["error"];
            final message = response["message"] ?? response["messsage"];

            error = DioError(
              requestOptions: error.requestOptions,
              response: error.response,
              error: ApiException(status, message, errormsg, response),
            );
          }
          handler.next(error);
        },
      ),
    );

  if (kDebugMode) {
    dio.interceptors
        .add(PrettyDioLogger(requestBody: true, responseBody: true));
  }

  GetIt.I.registerLazySingleton(() => Client(RestClient(dio)));
  GetIt.I.registerLazySingleton(() => const FlutterSecureStorage());
}

Client get client => GetIt.I<Client>();
FlutterSecureStorage get flutterSecureStorage =>
    GetIt.I<FlutterSecureStorage>();
