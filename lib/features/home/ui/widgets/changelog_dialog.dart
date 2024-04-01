import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

const changelogPreference = "showChangelog";

abstract class ChangelogDialog extends StatelessWidget {
  const ChangelogDialog(this.packageInfo, {super.key});

  final PackageInfo packageInfo;

  String getTitle(BuildContext context) =>
      "${AppLocalizations.of(context)!.openEdisu} v${packageInfo.version}";

  // TODO: Find a way to parse changelog from CHANGELOG.md
  String getChangelog(BuildContext context) => AppLocalizations.of(context)!
      .changelog
      .replaceAll(RegExp(r'^-', multiLine: true), "•");

  void disableChangelog(BuildContext context) => SharedPreferences.getInstance()
      .then((prefs) => prefs.setBool(changelogPreference, false))
      .whenComplete(() => Navigator.pop(context));
}

Future<void> showChangelogOnUpdate(
  context,
  Widget Function(PackageInfo) dialogBuilder,
) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final prefs = await SharedPreferences.getInstance();
  final hasUpdated = packageInfo.buildNumber != prefs.getString('buildNumber');
  final shouldShow = prefs.getBool('showChangelog') ?? true;
  if (shouldShow && hasUpdated) {
    await prefs.setString('buildNumber', packageInfo.buildNumber);

    showDialog(
      context: context,
      builder: (_) => dialogBuilder(packageInfo),
    );
  }
}
