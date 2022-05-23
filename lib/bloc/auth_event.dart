part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(String username, String password) =
      LoginRequested;
  const factory AuthEvent.logout() = LogoutRequested;
  const factory AuthEvent.restore() = RestoreRequested;
}
