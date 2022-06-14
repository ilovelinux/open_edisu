import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:open_edisu/models/edisu.dart';
import 'package:open_edisu/utilities/dio.dart';
import 'package:open_edisu/utilities/inceptor.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState.initial()) {
    on<_InitialSignup>((event, emit) async {
      final email = event.email;

      try {
        await client.initialSignup(email);
        emit(SignupState.requestVerifyCode(email));
      } catch (e) {
        if (e is DioError && e.response?.statusCode == 403) {
          emit(SignupState.requestVerifyCode(email));
        } else {
          emit(SignupState.initial(error: getErrorString(e)));
        }

        if (kDebugMode) {
          rethrow;
        }
      }
    });
    on<_VerifyCode>((event, emit) async {
      final email = event.email;
      final token = event.token;

      try {
        final response = await client.verifyCode(email, token);
        final universities = await client.master();
        emit(SignupState.requestProfileDetails(
            email, response.token, universities));
      } catch (e) {
        var wrongCode = false;
        String? error;
        if (e is DioError && e.response?.statusCode == 401) {
          wrongCode = true;
        } else {
          error = getErrorString(e);
        }
        emit(SignupState.requestVerifyCode(
          email,
          wrongCode: wrongCode,
          error: error,
        ));

        if (kDebugMode) {
          rethrow;
        }
      }
    });
    on<_Signup>((event, emit) async {
      try {
        await client.signup(
          email: event.email,
          token: event.token,
          firstName: event.firstName,
          lastName: event.lastName,
          rollNo: event.rollNo,
          universityId: event.universityId,
          password: event.password,
          cpassword: event.cpassword,
          isDisabled: event.isDisabled,
        );
        emit(const SignupState.success());
      } catch (e) {
        emit(SignupState.requestProfileDetails(
          event.email,
          event.token,
          event.universities,
          error: getErrorString(e),
        ));

        if (kDebugMode) {
          rethrow;
        }
      }
    });
  }
}
