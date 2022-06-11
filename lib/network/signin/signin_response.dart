import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/edisu.dart';
import '../generic_responses.dart';

part 'signin_response.freezed.dart';
part 'signin_response.g.dart';

@freezed
class SigninResponse with _$SigninResponse {
  const factory SigninResponse({
    required final String timestamp,
    required final int status,
    final String? message,
    final String? messsage,
    required final SigninDataResponse? result,
    final String? token,
    final int? timeStart,
    final int? timeEnd,
  }) = _SigninResponse;

  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);
}

@JsonSerializable()
class SigninDataResponse extends GenericDataResponse<User> {
  const SigninDataResponse(data) : super(data: data);

  factory SigninDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninDataResponseFromJson(json);
}
