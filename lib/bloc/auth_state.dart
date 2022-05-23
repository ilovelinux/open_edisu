part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState(User user) = Authenticated;
  const factory AuthState.unauthenticated([String? message]) = Unauthenticated;
  const factory AuthState.unknown() = Unknown;
}
