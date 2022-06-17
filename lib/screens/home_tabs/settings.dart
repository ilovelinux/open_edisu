part of '../home.dart';

class _SettingsView extends StatefulWidget {
  const _SettingsView({Key? key}) : super(key: key);

  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  late final User user;

  @override
  void initState() {
    user = context
        .read<AuthBloc>()
        .state
        .whenOrNull(authenticated: (user) => user)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final kDebugMode = false;

    return ListView(
      children: [
        ListTile(
          title: Text(
            "User",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Account"),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AccountView(),
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text("Notifications"),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text("Logout"),
          onTap: () => context.read<AuthBloc>().add(const AuthEvent.logout()),
        ),
        const Divider(),
        ListTile(
          title: Text(
            "Other",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        AboutListTile(
          applicationIcon: Image.asset(
            'assets/icon/icon.png',
            scale: 40,
          ),
          applicationName: "Open Edisu",
          applicationVersion: "0.1.2",
          applicationLegalese: "Released under GPLv3",
          icon: const Icon(Icons.info),
          child: const Text("About"),
        )
      ],
    );
  }
}
