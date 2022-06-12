import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_response.freezed.dart';
part 'generic_response.g.dart';

@freezed
class GenericResponse with _$GenericResponse {
  const factory GenericResponse({
    required final Object? timestamp,
    @JsonKey(readValue: _readStatus) required final int status,
    @JsonKey(readValue: _readMessage) required final String message,
    final String? error,
    final Object? result,
  }) = _GenericResponse;

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);
}

int _readStatus(json, key) => json[key] ?? json["code"];
String _readMessage(json, key) => json[key] ?? json["messsage"];

abstract class GenericDataResponse<T> {
  final T data;

  const GenericDataResponse({required final this.data});

  static Type typeOf<T>() => T;
}

abstract class GenericListResponse<T> {
  final T list;

  const GenericListResponse({required final this.list});
}
