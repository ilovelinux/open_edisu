part of '../models.dart';

@freezed
class SigninResponse with _$SigninResponse {
  const factory SigninResponse({
    required final DataResponse<User> result,
    required final String token,
  }) = _SigninResponse;

  factory SigninResponse.fromJson(Map<String, dynamic> json) =>
      _$SigninResponseFromJson(json);
}
