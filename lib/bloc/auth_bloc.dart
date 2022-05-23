import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../models/edisu.dart';
import '../utilities/session.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<LoginRequested>((event, emit) async {
      emit(const AuthState.unknown());
      try {
        final user = await login(event.username, event.password);
        emit(AuthState(user));
      } catch (e) {
        emit(AuthState.unauthenticated(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await logout();
      emit(const AuthState.unauthenticated());
    });

    on<RestoreRequested>((event, emit) async {
      emit(const AuthState.unknown());
      User? user;
      String? error;
      try {
        user = await restore();
      } catch (e) {
        error = e.toString();
      }
      emit(user == null ? AuthState.unauthenticated(error) : AuthState(user));
    });
  }

  @override
  void onChange(Change<AuthState> change) {
    log(change.toString(), name: "AUTH");
    super.onChange(change);
  }
}
