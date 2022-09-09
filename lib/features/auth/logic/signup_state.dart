part of 'signup_bloc.dart';

@Freezed(equal: false)
class SignupState with _$SignupState {
  const factory SignupState.initial({final String? error}) = _Initial;
  const factory SignupState.requestVerifyCode(
    final String email, {
    @Default(false) final bool wrongCode,
    final String? error,
  }) = _RequestVerifyCode;
  const factory SignupState.requestProfileDetails(
    final String email,
    final String token,
    final Universities universities, {
    final String? error,
  }) = _RequestProfileDetails;
  const factory SignupState.success() = _Success;
}
