import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../models/edisu.dart';
import '../utilities/inceptor.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<LoginRequested>((event, emit) async {
      emit(const AuthState.unknown());
      try {
        emit(AuthState.authenticated(
            await client.signin(event.username, event.password)));
      } catch (e) {
        emit(AuthState.unauthenticated(e.toString()));
      }
    });

    on<LogoutRequested>((event, emit) async {
      await client.logout();
      emit(const AuthState.unauthenticated());
    });

    on<RestoreRequested>((event, emit) async {
      emit(const AuthState.unknown());
      try {
        emit(AuthState.authenticated(await client.me()));
      } catch (e) {
        emit(AuthState.unauthenticated(e.toString()));
        rethrow;
      }
    });
  }

  @override
  void onChange(Change<AuthState> change) {
    log(change.toString(), name: "AUTH");
    super.onChange(change);
  }
}
