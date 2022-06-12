part of 'signup.dart';

class _SignupForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  int _universityId = -1;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  bool _isDisabled = false;

  final String email;
  final String token;
  final Universities universities;

  _SignupForm({
    Key? key,
    required this.email,
    required this.token,
    required this.universities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(
              hintText: loc.firstNamePlaceholder,
            ),
            validator: (s) => validateInput(s) ? null : loc.emptyField,
            controller: _firstNameController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: loc.lastNamePlaceholder,
            ),
            validator: (s) => validateInput(s) ? null : loc.emptyField,
            controller: _lastNameController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: loc.rollNoPlaceholder,
            ),
            validator: (s) => validateInput(s) ? null : loc.emptyField,
            controller: _rollNoController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: loc.passwordPlaceholder,
            ),
            validator: (s) => validateInput(s, 8) ? null : loc.emptyField,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _passwordController,
          ),
          const SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              hintText: loc.cpasswordPlaceholder,
            ),
            validator: (s) => validateInput(s, 8)
                ? s != _passwordController.text
                    ? loc.passwordNotMatched
                    : null
                : loc.emptyField,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            controller: _cpasswordController,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              loc.university,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField(
            items: universities
                .map(
                  (university) => DropdownMenuItem<int>(
                    value: university.id,
                    child: Text(university.name),
                  ),
                )
                .toList(),
            onChanged: (int? universityId) =>
                _universityId = universityId ?? -1,
            validator: (int? universityId) =>
                universityId == null ? loc.emptyField : null,
            isExpanded: true,
            isDense: false,
          ),
          const SizedBox(height: 20),
          _SwitchFormField(
            text: loc.isDisabled,
            onToggle: (value) => _isDisabled = value,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () => _sendForm(context),
              child: Text(loc.continueSignup),
            ),
          ),
        ],
      ),
    );
  }

  void _sendForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<SignupBloc>().add(SignupEvent.signup(
            universities: universities,
            email: email,
            token: token,
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            rollNo: _rollNoController.text.trim(),
            universityId: _universityId,
            password: _passwordController.text.trim(),
            cpassword: _cpasswordController.text.trim(),
            isDisabled: _isDisabled,
          ));
    }
  }
}

class _SwitchFormField extends StatefulWidget {
  const _SwitchFormField({
    Key? key,
    required this.text,
    required this.onToggle,
  }) : super(key: key);

  final String text;
  final void Function(bool) onToggle;

  @override
  State<_SwitchFormField> createState() => _SwitchFormFieldState();
}

class _SwitchFormFieldState extends State<_SwitchFormField> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.text),
        const Spacer(),
        Switch(
          value: value,
          onChanged: (v) => setState(() {
            value = v;
            widget.onToggle(v);
          }),
        ),
      ],
    );
  }
}
