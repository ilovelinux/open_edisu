import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_edisu/utilities/json/converters.dart';

import '../../models/edisu.dart';
import '../generic_response.dart';

part 'slots_response.freezed.dart';
part 'slots_response.g.dart';

@freezed
class SlotsResponse with _$SlotsResponse {
  const factory SlotsResponse({
    required final String timestamp,
    required final int status,
    final String? message,
    final String? messsage,
    final SlotsDataResponse? result,
    final String? error,
  }) = _SlotsResponse;

  factory SlotsResponse.fromJson(Map<String, dynamic> json) =>
      _$SlotsResponseFromJson(json);
}

@JsonSerializable()
class SlotsDataResponse extends GenericDataResponse<SlotsDataListResponse> {
  SlotsDataResponse(data) : super(data: data);

  factory SlotsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SlotsDataResponseFromJson(json);
}

@JsonSerializable(converters: [SlotConverter()])
class SlotsDataListResponse extends GenericListResponse<Slots> {
  const SlotsDataListResponse(final list) : super(list: list);

  factory SlotsDataListResponse.fromJson(Map<String, dynamic> json) =>
      _$SlotsDataListResponseFromJson(json);
}
