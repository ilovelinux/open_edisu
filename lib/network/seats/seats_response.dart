import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/edisu.dart';

part 'seats_response.freezed.dart';
part 'seats_response.g.dart';

@freezed
class SeatsResponse with _$SeatsResponse {
  const factory SeatsResponse({
    required final String timestamp,
    required final int status,
    final String? message,
    final String? messsage,
    final SeatsDataResponse? result,
    final String? error,
  }) = _SeatsResponse;

  factory SeatsResponse.fromJson(Map<String, dynamic> json) =>
      _$SeatsResponseFromJson(json);
}

@JsonSerializable()
class SeatsDataResponse {
  final List<Seats> seats;

  SeatsDataResponse({required final this.seats});

  factory SeatsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SeatsDataResponseFromJson(json);
}
