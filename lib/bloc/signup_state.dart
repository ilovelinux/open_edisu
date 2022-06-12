part of 'signup_bloc.dart';

@Freezed(equal: false)
class SignupState with _$SignupState {
  const factory SignupState.initial({String? error}) = _SignupStateInitial;
  const factory SignupState.requestVerifyCode(
    final String email, {
    @Default(false) final bool wrongCode,
    final String? error,
  }) = _SignupStateRequestVerifyCode;
  const factory SignupState.requestProfileDetails(
    final String email,
    final String token,
    final Universities universities, {
    final String? error,
  }) = _SignupStateRequestProfileDetails;
  const factory SignupState.success() = _SignupStateSuccess;
}
