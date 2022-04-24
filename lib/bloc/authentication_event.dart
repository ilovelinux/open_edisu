part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.login(String username, String password) =
      LoginRequested;
  const factory AuthenticationEvent.logout() = LogoutRequested;
  const factory AuthenticationEvent.restore() = RestoreRequested;
}
