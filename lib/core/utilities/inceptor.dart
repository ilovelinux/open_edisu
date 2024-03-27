import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'package:open_edisu/core/network/api.dart';
import 'package:open_edisu/core/network/client.dart';
import 'package:open_edisu/core/network/models.dart';

Future<CacheOptions> get defaultCacheOptions async => CacheOptions(
      store: HiveCacheStore((await getTemporaryDirectory()).absolute.path),
      hitCacheOnErrorExcept: [401, 403],
      // Cache policy will be overriden on requests that needs to be cached.
      policy: CachePolicy.noCache,
      allowPostMethod: true,
    );

Future<void> initInceptor() async {
  final dio = Dio(BaseOptions(receiveDataWhenStatusError: true));

  dio.interceptors.add(DioCacheInterceptor(options: await defaultCacheOptions));

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
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
              message: genericResponse.message,
              type: DioExceptionType.badResponse,
            ),
          );
          return;
        }

        handler.next(response);
      },
      onError: (error, handler) {
        if (error.type == DioExceptionType.badResponse) {
          final genericResponse =
              Result.fromJson(error.response!.data, (_) => null);

          final status = genericResponse.status;
          final errormsg = genericResponse.error;
          final message = genericResponse.message;

          error = DioException(
            requestOptions: error.requestOptions,
            response: error.response,
            type: DioExceptionType.badResponse,
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

  if (kDebugMode) {
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
    ));
  }

  GetIt.I.registerLazySingleton(() => Client(RestClient(dio)));
  GetIt.I.registerLazySingleton(() => const FlutterSecureStorage());
}

Client get client => GetIt.I<Client>();
FlutterSecureStorage get flutterSecureStorage =>
    GetIt.I<FlutterSecureStorage>();
