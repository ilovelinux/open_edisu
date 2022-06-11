import 'package:freezed_annotation/freezed_annotation.dart';

part 'generic_response.freezed.dart';
part 'generic_response.g.dart';

@freezed
class GenericResponse with _$GenericResponse {
  const factory GenericResponse({
    required final String timestamp,
    required final int status,
    required final String message,
    final Object? result,
  }) = _GenericResponse;

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);
}

abstract class GenericDataResponse<T> {
  final T data;

  const GenericDataResponse({required final this.data});

  static Type typeOf<T>() => T;
}

abstract class GenericListResponse<T> {
  final T list;

  const GenericListResponse({required final this.list});
}
