import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:open_edisu/features/auth/logic/auth_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context)!.logout),
      content: Text(AppLocalizations.of(context)!.logoutMessage),
      actions: [
        TextButton(
          child: Text(AppLocalizations.of(context)!.yes),
          onPressed: () {
            context.read<AuthBloc>().add(const AuthEvent.logout());
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context)!.no),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
