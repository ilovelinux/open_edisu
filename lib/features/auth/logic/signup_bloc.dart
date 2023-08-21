import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logging/logging.dart';

import '../../../core/utilities/dio.dart';
import '../../../core/utilities/inceptor.dart';
import '../../settings/models/settings.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

final log = Logger('SignupBloc');

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState.initial()) {
    on<_InitialSignup>((event, emit) async {
      final email = event.email;

      try {
        await client.initialSignup(email);
        emit(SignupState.requestVerifyCode(email));
      } catch (e, stackTrace) {
        if (e is DioException && e.response?.statusCode == 403) {
          emit(SignupState.requestVerifyCode(email));
        } else {
          emit(SignupState.initial(error: getErrorString(e)));
        }

        log.warning("Catched exception on InitialSignup", e, stackTrace);
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
      } catch (e, stackTrace) {
        var wrongCode = false;
        String? error;
        if (e is DioException && e.response?.statusCode == 401) {
          wrongCode = true;
        } else {
          error = getErrorString(e);
        }
        emit(SignupState.requestVerifyCode(
          email,
          wrongCode: wrongCode,
          error: error,
        ));

        log.warning("Catched exception on VerifyCode", e, stackTrace);
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
      } catch (e, stackTrace) {
        emit(SignupState.requestProfileDetails(
          event.email,
          event.token,
          event.universities,
          error: getErrorString(e),
        ));

        log.warning("Catched exception on Signup", e, stackTrace);
      }
    });
  }
}
