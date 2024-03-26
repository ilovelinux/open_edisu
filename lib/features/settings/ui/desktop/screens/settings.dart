import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:open_edisu/features/auth/logic/auth_bloc.dart';
import 'package:open_edisu/features/auth/ui/widgets/logout_dialog.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context
        .read<AuthBloc>()
        .state
        .whenOrNull(authenticated: (user) => user)!;

    final controller = FlyoutController();

    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text(AppLocalizations.of(context)!.settings)),
      children: [
        ListTile(title: Text(AppLocalizations.of(context)!.user)),
        ListTile(
          leading: const Icon(FluentIcons.contact_info),
          title: Text(AppLocalizations.of(context)!.firstName),
          trailing: Text(user.name),
        ),
        ListTile(
          leading: const Icon(FluentIcons.contact_info),
          title: Text(AppLocalizations.of(context)!.lastName),
          trailing: Text(user.surname),
        ),
        ListTile(
          leading: const Icon(FluentIcons.number_symbol),
          title: Text(AppLocalizations.of(context)!.studentId),
          trailing: Text(user.studentCode),
        ),
        const Divider(),
        FlyoutTarget(
          controller: controller,
          child: ListTile(
              leading: const Icon(FluentIcons.sign_out),
              title: Text(AppLocalizations.of(context)!.logout),
              onPressed: () => controller.showFlyout(
                    autoModeConfiguration: FlyoutAutoConfiguration(
                      preferredMode: FlyoutPlacementMode.topLeft,
                    ),
                    barrierDismissible: true,
                    dismissOnPointerMoveAway: false,
                    dismissWithEsc: true,
                    builder: (context) {
                      return FlyoutContent(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'You will be logged out. Do you want to continue?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12.0),
                            Button(
                              onPressed: () {
                                context
                                    .read<AuthBloc>()
                                    .add(const AuthEvent.logout());
                                Flyout.of(context).close();
                              },
                              child: const Text('Yes, logout!'),
                            ),
                          ],
                        ),
                      );
                    },
                  )),
        ),
        const Divider(),
        ListTile(title: Text(AppLocalizations.of(context)!.other)),
        ListTile(
          leading: const Icon(FluentIcons.info),
          title: const Text("About"),
          onPressed: () async {
            final platform = await PackageInfo.fromPlatform();

            showDialog(
              context: context,
              builder: (context) => ContentDialog(
                title: Row(
                  children: [
                    Image.asset(
                      'assets/icon/icon.png',
                      scale: 40,
                    ),
                    const SizedBox(width: 16),
                    Text('Open Edisu v${platform.version}'),
                  ],
                ),
                style: const ContentDialogThemeData(
                  titlePadding: EdgeInsets.only(
                    bottom: 20,
                  ),
                ),
                content: Text(
                  [
                    AppLocalizations.of(context)!.unofficialWarning,
                    AppLocalizations.of(context)!.license,
                  ].join("\n\n"),
                ),
                actions: [
                  HyperlinkButton(
                      child: Text("View license"), onPressed: () {}),
                  FilledButton(
                      child: Text("Close"),
                      onPressed: () => Navigator.pop(context)),
                ],
              ),
            );
          },
        ),
        ListTile(
          leading: const Icon(FluentIcons.code),
          title: const Text("GitHub"),
          onPressed: () =>
              launchUrl(Uri.https('github.com', '/ilovelinux/open_edisu')),
        ),
      ],
    );
  }
}
