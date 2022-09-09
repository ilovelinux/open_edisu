part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(final String username, final String password) =
      _AuthLogin;
  const factory AuthEvent.logout() = _AuthLogout;
  const factory AuthEvent.restore() = _AuthRestore;
}
