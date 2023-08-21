import 'package:dio/dio.dart';

String getErrorString(Object error) =>
    error is DioException && error.message != null
        ? error.message!
        : error.toString();
