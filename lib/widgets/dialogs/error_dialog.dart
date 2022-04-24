import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog(this.e, {Key? key}) : super(key: key);

  final Object e;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Errore"),
      content: Text(e.toString()),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
