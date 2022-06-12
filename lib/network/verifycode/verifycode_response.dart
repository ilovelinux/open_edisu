import 'package:freezed_annotation/freezed_annotation.dart';

part 'verifycode_response.freezed.dart';
part 'verifycode_response.g.dart';

@freezed
class VerifyCodeResponse with _$VerifyCodeResponse {
  const factory VerifyCodeResponse({
    required final String token,
    required final String message,
  }) = _VerifyCodeResponse;

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);
}
