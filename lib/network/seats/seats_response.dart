import 'package:json_annotation/json_annotation.dart';
import 'package:open_edisu/network/generic_response.dart';

import '../../models/edisu.dart';

part 'seats_response.g.dart';

typedef SeatsResponse = Result<SeatsListResponse>;

@JsonSerializable()
class SeatsListResponse {
  final SeatsList seats;

  const SeatsListResponse({required final this.seats});

  factory SeatsListResponse.fromJson(Map<String, dynamic> json) =>
      _$SeatsListResponseFromJson(json);
}
