import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../core/utilities/dio.dart';
import '../../../core/utilities/inceptor.dart';
import '../models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

final log = Logger('AuthBloc');

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.unknown()) {
    on<_AuthLogin>((event, emit) async {
      emit(const AuthState.unknown());
      try {
        emit(AuthState.authenticated(
          await client.signin(event.username, event.password),
        ));
      } catch (e, stackTrace) {
        if (e is DioError &&
            e.type == DioErrorType.other &&
            e.error is SocketException) {
          emit(const AuthState.unauthenticated(connectionError: true));
        } else {
          emit(AuthState.unauthenticated(message: getErrorString(e)));

          log.warning("Catched exception on AuthLogin", e, stackTrace);
        }
      }
    });

    on<_AuthLogout>((event, emit) async {
      await client.logout();
      emit(const AuthState.unauthenticated());
    });

    on<_AuthRestore>((event, emit) async {
      emit(const AuthState.unknown());
      try {
        emit(AuthState.authenticated(await client.me()));
      } catch (e, stackTrace) {
        bool sessionExpired = false;
        bool connectionError = false;
        String? message;
        if (e is DioError) {
          if (e.type == DioErrorType.other && e.error is SocketException) {
            connectionError = true;
          } else if (e.type == DioErrorType.response &&
              e.response?.statusCode == 403) {
            if (await flutterSecureStorage.containsKey(key: 'token')) {
              await flutterSecureStorage.delete(key: 'token');
              sessionExpired = true;
            }
          } else {
            message = getErrorString(e);
          }
        }

        emit(AuthState.unauthenticated(
          sessionExpired: sessionExpired,
          connectionError: connectionError,
          message: message,
        ));

        log.warning("Catched exception on AuthRestore", e, stackTrace);
      }
    });
  }

  @override
  void onChange(Change<AuthState> change) {
    log.fine(change.toString());
    super.onChange(change);
  }
}
