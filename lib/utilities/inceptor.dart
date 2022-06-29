import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:open_edisu/network/client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network/api.dart';
import '../network/models.dart';

void initInceptor() {
  final dio = Dio(BaseOptions(receiveDataWhenStatusError: true));

  if (kDebugMode) {
    dio.interceptors
        .add(PrettyDioLogger(requestBody: true, responseBody: true));
  }

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers[HttpHeaders.userAgentHeader] = "Open Edisu";
        final token = await flutterSecureStorage.read(key: 'token');
        if (token != null) {
          options.headers[HttpHeaders.authorizationHeader] = "Bearer $token";
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        final genericResponse = Result.fromJson(response.data, (_) => null);
        if (genericResponse.status >= 400) {
          response.statusCode = genericResponse.status;
          throw DioError(
            requestOptions: response.requestOptions,
            response: response,
            type: DioErrorType.response,
          );
        }
        handler.next(response);
      },
      onError: (error, handler) {
        if (error.type == DioErrorType.response) {
          final genericResponse =
              Result.fromJson(error.response!.data, (_) => null);

          final status = genericResponse.status;
          final errormsg = genericResponse.error;
          final message = genericResponse.message;

          error = DioError(
            requestOptions: error.requestOptions,
            response: error.response,
            type: DioErrorType.response,
            error: ApiException(
              status,
              message,
              errormsg,
              error.response?.data,
            ),
          );
        }
        handler.next(error);
      },
    ),
  );

  GetIt.I.registerLazySingleton(() => Client(RestClient(dio)));
  GetIt.I.registerLazySingleton(() => const FlutterSecureStorage());
}

Client get client => GetIt.I<Client>();
FlutterSecureStorage get flutterSecureStorage =>
    GetIt.I<FlutterSecureStorage>();
