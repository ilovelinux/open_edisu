part of '../home.dart';

class _SettingsView extends StatefulWidget {
  const _SettingsView({Key? key}) : super(key: key);

  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  late final User user;
  String version = "";

  @override
  void initState() {
    user = context
        .read<AuthBloc>()
        .state
        .whenOrNull(authenticated: (user) => user)!;
    PackageInfo.fromPlatform().then(
      (packageInfo) => setState(() => version = packageInfo.version),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          onTap: () => context.read<AuthBloc>().add(const AuthEvent.logout()),
        ),
        const Divider(),
        ListTile(
          title: Text(
            AppLocalizations.of(context)!.other,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        AboutListTile(
          applicationIcon: Image.asset(
            'assets/icon/icon.png',
            scale: 50,
          ),
          applicationName: "Open Edisu",
          applicationVersion: version,
          applicationLegalese: [
            AppLocalizations.of(context)!.unofficialWarning,
            AppLocalizations.of(context)!.license,
          ].join("\n\n"),
          icon: const Icon(Icons.info),
          child: const Text("About"),
        ),
        ListTile(
          leading: const Icon(Icons.code),
          title: const Text("GitHub"),
          onTap: () =>
              launchUrl(Uri.https('github.com', '/ilovelinux/open_edisu')),
        ),
      ],
    );
  }
}
