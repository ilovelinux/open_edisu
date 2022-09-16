import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../auth/logic/auth_bloc.dart';
import '../../../auth/ui/widgets/logout_dialog.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context
        .read<AuthBloc>()
        .state
        .whenOrNull(authenticated: (user) => user)!;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.user,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppLocalizations.of(context)!.firstName),
            trailing: Text(user.name),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(AppLocalizations.of(context)!.lastName),
            trailing: Text(user.surname),
          ),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: Text(AppLocalizations.of(context)!.studentId),
            trailing: Text(user.studentCode),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(AppLocalizations.of(context)!.logout),
            onTap: () => showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext c) => BlocProvider.value(
                value: context.read<AuthBloc>(),
                child: const LogoutDialog(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.other,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          FutureBuilder(
            future: PackageInfo.fromPlatform(),
            builder: (context, AsyncSnapshot<PackageInfo> snapshot) =>
                AboutListTile(
              applicationIcon: Image.asset(
                'assets/icon/icon.png',
                scale: 50,
              ),
              applicationName: "Open Edisu",
              applicationVersion: snapshot.data?.version ?? "",
              applicationLegalese: [
                AppLocalizations.of(context)!.unofficialWarning,
                AppLocalizations.of(context)!.license,
              ].join("\n\n"),
              icon: const Icon(Icons.info),
              child: const Text("About"),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text("GitHub"),
            onTap: () =>
                launchUrl(Uri.https('github.com', '/ilovelinux/open_edisu')),
          ),
        ],
      ),
    );
  }
}
