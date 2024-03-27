part of 'signup.dart';

class _VerifyCodeForm extends StatefulWidget {
  _VerifyCodeForm({required this.email, this.error = false});

  final String email;
  bool error;

  @override
  State<_VerifyCodeForm> createState() => _VerifyCodeFormState();
}

class _VerifyCodeFormState extends State<_VerifyCodeForm> {
  final TextEditingController _codeController = TextEditingController();

  bool verifying = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) => state.whenOrNull<void>(
        requestVerifyCode: (email, wrongCode, error) {
          if (wrongCode) {
            _codeController.clear();
          } else {
            showErrorInSnackbar(context, error);
          }
          verifying = false;
        },
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          PinCodeTextField(
            appContext: context,
            controller: _codeController,
            length: 6,
            onChanged: (_) => widget.error = false,
            onCompleted: (code) => _sendForm(context, code),
            autoFocus: true,
            readOnly: verifying,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            validator: (code) => widget.error ? "Wrong code" : null,
          ),
          const SizedBox(height: 32),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green[400],
            ),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            child: Text(
              AppLocalizations.of(context)!.verifyCodeInfo,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendForm(BuildContext context, final String code) {
    setState(() {
      verifying = true;
    });
    context.read<SignupBloc>().add(SignupEvent.verifyCode(widget.email, code));
  }
}
