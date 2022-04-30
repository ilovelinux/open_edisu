import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/authentication_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, this.error}) : super(key: key);

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("OPEN EDISU")),
      body: const LoginWidget(),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: _LoginForm(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text("OPPURE"),
                ),
                Expanded(child: Divider()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0),
            child: TextButton(
              onPressed: () => launchUrl(
                Uri.https(
                    "edisuprenotazioni.edisu-piemonte.it", "auth/register"),
              ),
              child: const Text("Non sei ancora registrato? Registrati!"),
            ),
          )
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter your email',
            ),
            validator: _validateEmail,
            controller: _emailController,
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Password',
            ),
            validator: _validateInput,
            controller: _passwordController,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => _sendForm(context),
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _sendForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      var email = _emailController.text;
      var password = _passwordController.text;
      context.read<AuthBloc>().add(LoginRequested(email, password));
    }
  }

  // Using regex to validate email. Code is pretty awful though
  String? _validateEmail(String? value) =>
      _validateInput(value) ??
      (RegExp(r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
              .hasMatch(value!)
          ? null
          : "Invalid email");

  String? _validateInput(String? value) =>
      (value == null || value.isEmpty) ? 'Please enter some text' : null;
}
