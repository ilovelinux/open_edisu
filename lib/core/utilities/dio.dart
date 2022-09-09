import 'package:dio/dio.dart';

String getErrorString(Object error) =>
    error is DioError ? error.message : error.toString();
