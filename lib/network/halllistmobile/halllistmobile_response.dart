import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/edisu.dart';
import '../generic_response.dart';

part 'halllistmobile_response.freezed.dart';
part 'halllistmobile_response.g.dart';

@freezed
class HallListMobileResponse with _$HallListMobileResponse {
  const factory HallListMobileResponse({
    required final String timestamp,
    required final int status,
    final String? message,
    final String? messsage,
    final HallListMobileDataResponse? result,
    final String? error,
  }) = _HallListResponse;

  factory HallListMobileResponse.fromJson(Map<String, dynamic> json) =>
      _$HallListMobileResponseFromJson(json);
}

@JsonSerializable()
class HallListMobileDataResponse
    extends GenericDataResponse<HallListMobileDataListResponse> {
  HallListMobileDataResponse(data) : super(data: data);

  factory HallListMobileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HallListMobileDataResponseFromJson(json);
}

@JsonSerializable()
class HallListMobileDataListResponse extends GenericListResponse<HallsMobile> {
  const HallListMobileDataListResponse(final list) : super(list: list);

  factory HallListMobileDataListResponse.fromJson(Map<String, dynamic> json) =>
      _$HallListMobileDataListResponseFromJson(json);
}
