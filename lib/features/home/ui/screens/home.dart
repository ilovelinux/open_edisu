import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:open_edisu/features/auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../halls/ui/screens/halls.dart';
import '../../../settings/ui/screens/settings.dart';
import '../widgets/chart.dart';
import '../widgets/next_booking.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    _showChangelogOnUpdate(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.welcome(GetIt.I<User>().name, ''),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
          textScaler: const TextScaler.linear(1.05),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SettingsView(),
              ),
            ),
            child: const Icon(Icons.settings),
          ),
        ],
      ),
      drawer: const SettingsView(),
      body: const SingleChildScrollView(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NextBookingCard(),
            WeeklyStatisticsCard(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const HallsPage(),
          ),
        ),
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.newBooking),
      ),
    );
  }
}

Future<void> _showChangelogOnUpdate(context) async {
  final packageInfo = await PackageInfo.fromPlatform();
  final prefs = await SharedPreferences.getInstance();
  final hasUpdated = packageInfo.buildNumber != prefs.getString('buildNumber');
  final shouldShow = prefs.getBool('showChangelog') ?? true;
  if (shouldShow && hasUpdated) {
    await prefs.setString('buildNumber', packageInfo.buildNumber);
    await _showChangelogDialog(context);
  }
}

Future<void> _showChangelogDialog(context) async {
  final packageInfo = await PackageInfo.fromPlatform();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        "Open Edisu v${packageInfo.version}",
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.whatsnew,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ..._changelogWidgets(context),
        ],
      ),
      actionsOverflowAlignment: OverflowBarAlignment.start,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.dontshowagain),
              onPressed: () {
                SharedPreferences.getInstance().then(
                  (prefs) => prefs.setBool("showChangelog", false),
                );
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.great),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    ),
  );
}

// TODO: Find a way to parse changelog from CHANGELOG.md
List<Widget> _changelogWidgets(context) => AppLocalizations.of(context)!
        .changelog
        .replaceAll(RegExp(r'^-', multiLine: true), "•")
        .split("\n")
        .fold<Iterable<Widget>>(
      const [],
      (widgets, line) => widgets.followedBy(
        [Text(line), const SizedBox(height: 4)],
      ),
    ).toList()
      ..removeLast();
