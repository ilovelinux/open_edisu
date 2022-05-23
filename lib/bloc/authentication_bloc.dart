import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../models/edisu.dart';
import '../utilities/session.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthBloc() : super(const AuthenticationState.unknown()) {
    on<LoginRequested>((event, emit) async {
      emit(const AuthenticationState.unknown());
      try {
        final user = await login(event.username, event.password);
        emit(AuthenticationState(user));
      } catch (e) {
        emit(AuthenticationState.unauthenticated(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await logout();
      emit(const AuthenticationState.unauthenticated());
    });

    on<RestoreRequested>((event, emit) async {
      emit(const AuthenticationState.unknown());
      User? user;
      String? error;
      try {
        user = await restore();
      } catch (e) {
        error = e.toString();
      }
      emit(user == null
          ? AuthenticationState.unauthenticated(error)
          : AuthenticationState(user));
    });
  }

  @override
  void onChange(Change<AuthenticationState> change) {
    log(change.toString(), name: "AUTH");
    super.onChange(change);
  }
}
