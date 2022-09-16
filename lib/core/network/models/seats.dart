part of '../models.dart';

typedef SeatsResponse = Result<SeatsListResponse>;

@JsonSerializable()
class SeatsListResponse {
  final SeatsList seats;

  const SeatsListResponse({required this.seats});

  factory SeatsListResponse.fromJson(Map<String, dynamic> json) =>
      _$SeatsListResponseFromJson(json);
}
