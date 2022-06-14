import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_edisu/widgets/login_signup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OPEN EDISU")),
      body: LoginWidget(
        title: AppLocalizations.of(context)!.login,
        child: _LoginForm(),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.emailPlaceholder,
                ),
                validator: (s) => validateEmail(s)
                    ? null
                    : AppLocalizations.of(context)!.invalidEmail,
                controller: _emailController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.passwordPlaceholder,
                ),
                validator: (s) => validateInput(s)
                    ? null
                    : AppLocalizations.of(context)!.invalidPassword,
                controller: _passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () => _sendForm(context),
                  child: Text(AppLocalizations.of(context)!.submit),
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 32),
          child: OrSeparator(),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pushNamed('signup'),
          child: Text(AppLocalizations.of(context)!.signupButton),
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
