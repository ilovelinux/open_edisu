part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState(User user) = Authenticated;
  const factory AuthenticationState.unauthenticated([String? message]) =
      Unauthenticated;
  const factory AuthenticationState.unknown() = Unknown;
}
