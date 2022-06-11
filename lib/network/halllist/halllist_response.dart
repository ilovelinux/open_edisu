import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/edisu.dart';
import '../generic_responses.dart';

part 'halllist_response.freezed.dart';
part 'halllist_response.g.dart';

@freezed
class HallListResponse with _$HallListResponse {
  const factory HallListResponse({
    required final String timestamp,
    required final int status,
    final String? message,
    final String? messsage,
    final HallListDataResponse? result,
    final String? error,
  }) = _HallListResponse;

  factory HallListResponse.fromJson(Map<String, dynamic> json) =>
      _$HallListResponseFromJson(json);
}

@JsonSerializable()
class HallListDataResponse
    extends GenericDataResponse<HallListDataListResponse> {
  HallListDataResponse(HallListDataListResponse data) : super(data: data);

  factory HallListDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HallListDataResponseFromJson(json);
}

@JsonSerializable()
class HallListDataListResponse extends GenericListResponse<Halls> {
  const HallListDataListResponse(final Halls list) : super(list: list);

  factory HallListDataListResponse.fromJson(Map<String, dynamic> json) =>
      _$HallListDataListResponseFromJson(json);
}
