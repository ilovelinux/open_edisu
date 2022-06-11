part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated(User user) = AuthStateAuthenticated;
  const factory AuthState.unauthenticated([String? message]) =
      _AuthStateUnauthenticated;
  const factory AuthState.unknown() = Unknown;
}
