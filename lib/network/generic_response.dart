import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class Result<T> {
  final Object? timestamp;
  @JsonKey(readValue: _readStatus)
  final int status;
  @JsonKey(readValue: _readMessage)
  final String message;
  final String? error;
  final T result;

  const Result({
    this.timestamp,
    required this.status,
    required this.message,
    this.error,
    required this.result,
  });

  factory Result.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ResultFromJson<T>(json, fromJsonT);
}

int _readStatus(json, key) => json[key] ?? json["code"];
String _readMessage(json, key) => json[key] ?? json["messsage"];

@JsonSerializable(genericArgumentFactories: true)
class DataResponse<T> {
  final T data;

  const DataResponse({required final this.data});

  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$DataResponseFromJson<T>(json, fromJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class ListResponse<T> {
  final T list;

  const ListResponse({required final this.list});

  factory ListResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) =>
      _$ListResponseFromJson<T>(json, fromJsonT);
}
