part of 'signup.dart';

class _InitialForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  _InitialForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.emailPlaceholder,
            ),
            validator: (s) => validateEmail(s)
                ? null
                : AppLocalizations.of(context)!.invalidEmail,
            controller: _emailController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => _sendForm(context),
              child: Text(AppLocalizations.of(context)!.continueSignup),
            ),
          ),
        ],
      ),
    );
  }

  void _sendForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      var email = _emailController.text.trim();
      context.read<SignupBloc>().add(SignupEvent.initialSignup(email));
    }
  }
}
