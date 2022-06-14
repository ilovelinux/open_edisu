part of 'signup_bloc.dart';

@freezed
class SignupEvent with _$SignupEvent {
  const factory SignupEvent.initialSignup(final String email) = _InitialSignup;
  const factory SignupEvent.verifyCode(final String email, final String token) =
      _VerifyCode;

  const factory SignupEvent.signup({
    required final Universities universities,
    required final String email,
    required final String token,
    required final String firstName,
    required final String lastName,
    required final String rollNo,
    required final int universityId,
    required final String password,
    required final String cpassword,
    required final bool isDisabled,
  }) = _Signup;
}
