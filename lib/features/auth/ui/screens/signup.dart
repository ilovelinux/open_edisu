import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/utilities/errors.dart';
import '../../logic/auth_bloc.dart';
import '../../logic/signup_bloc.dart';
import '../widgets/login_signup.dart';

part 'signup_initial.dart';
part 'signup_verify_code.dart';
part 'signup_final.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OPEN EDISU")),
      body: BlocProvider(
        create: (context) => SignupBloc(),
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<SignupBloc, SignupState>(
                listener: (context, state) {
                  final error = state.whenOrNull(
                    initial: (final error) => error,
                    requestVerifyCode: (_, __, final error) => error,
                    requestProfileDetails: (_, __, ___, final error) => error,
                  );

                  if (error != null) {
                    showErrorInSnackbar(context, error);
                  }
                },
                builder: (context, state) => state.when(
                  initial: (_) => LoginWidget(
                    title: AppLocalizations.of(context)!.signup,
                    child: _InitialForm(),
                  ),
                  requestVerifyCode: (email, wrongCode, _) => LoginWidget(
                    title: AppLocalizations.of(context)!.verifyCode,
                    child: _VerifyCodeForm(email: email, error: wrongCode),
                  ),
                  requestProfileDetails: (email, token, universities, _) =>
                      LoginWidget(
                    title: AppLocalizations.of(context)!.signupInformations,
                    child: _SignupForm(
                      email: email,
                      token: token,
                      universities: universities,
                    ),
                  ),
                  success: () => Column(
                    children: [
                      const Icon(Icons.check_circle,
                          size: 50, color: Colors.green),
                      const SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context)!.signupSuccess,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context
                              .read<AuthBloc>()
                              .add(const AuthEvent.restore());
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signupSuccessButton,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
