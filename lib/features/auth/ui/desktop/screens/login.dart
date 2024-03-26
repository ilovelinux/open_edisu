import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_edisu/features/auth/ui/widgets/login_signup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:open_edisu/features/auth/logic/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Fix overflow when keyboard pops up before re-enabling warning
    return ScaffoldPage(
      header: PageHeader(title: const Text("OPEN EDISU")),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoginWidget(
            title: "Welcome!",
            child: _LoginForm(),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormBox(
                  autofocus: true,
                  placeholder: AppLocalizations.of(context)!.emailPlaceholder,
                  validator: (s) => validateEmail(s)
                      ? null
                      : AppLocalizations.of(context)!.invalidEmail,
                  controller: _emailController,
                ),
                const SizedBox(height: 10),
                PasswordFormBox(
                  placeholder:
                      AppLocalizations.of(context)!.passwordPlaceholder,
                  validator: (s) => validateInput(s)
                      ? null
                      : AppLocalizations.of(context)!.invalidPassword,
                  controller: _passwordController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: FilledButton(
                    onPressed: () => _sendForm(context),
                    child: Text(AppLocalizations.of(context)!.submit),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _sendForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      var email = _emailController.text.trim();
      var password = _passwordController.text;
      context.read<AuthBloc>().add(AuthEvent.login(email, password));
    }
  }
}
