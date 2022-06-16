part of '../models.dart';

@Freezed(toJson: true)
class UpdatePasswordRequest with _$UpdatePasswordRequest {
  const factory UpdatePasswordRequest({
    required final String oldPassword,
    required final String password,
    required final String confirmPassword,
  }) = _UpdatePasswordRequest;
}
