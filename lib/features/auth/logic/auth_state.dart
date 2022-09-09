part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated({
    @Default(false) final bool sessionExpired,
    @Default(false) final bool connectionError,
    final String? message,
  }) = _Unauthenticated;
  const factory AuthState.unknown() = _Unknown;
}
