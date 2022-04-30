part of '../home.dart';

class _SettingsView extends StatelessWidget {
  const _SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text("About"),
          onTap: () => showDialog(
            context: context,
            // TODO: Use AboutDialog()
            builder: (_) => _AboutDialog(),
          ),
        )
      ],
    );
  }
}

class _AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SimpleDialog(
      title: Text("About"),
      children: [
        Text("App svilu"),
      ],
    );
  }
}
