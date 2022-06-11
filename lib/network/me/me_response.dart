import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/edisu.dart';
import '../generic_response.dart';

part 'me_response.freezed.dart';
part 'me_response.g.dart';

@freezed
class MeResponse with _$MeResponse {
  const factory MeResponse({
    required final String timestamp,
    required final int status,
    final String? message,
    final String? messsage,
    required final MeDataResponse result,
    final int? timeStart,
    final int? timeEnd,
  }) = _MeResponse;

  factory MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(json);
}

@JsonSerializable()
class MeDataResponse extends GenericDataResponse<User> {
  const MeDataResponse(final User data) : super(data: data);

  factory MeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MeDataResponseFromJson(json);
}
