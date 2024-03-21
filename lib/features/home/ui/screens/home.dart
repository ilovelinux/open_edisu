import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:open_edisu/features/auth/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../booking/logic/bookings_bloc.dart';
import '../../../booking/ui/screens/tabs/bookings.dart';
import '../../../halls/ui/screens/tabs/halls.dart';
import '../../../settings/ui/screens/settings.dart';
import 'tabs/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final _pages = const [
    Home(),
    BookingsView(),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    _showChangelogOnUpdate(context);

    return BlocProvider(
      create: (_) => BookingsBloc()..add(const BookingsEvent.update()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              switch (index) {
                0 => AppLocalizations.of(context)!
                    .welcome(GetIt.I<User>().name, ''),
                1 => AppLocalizations.of(context)!.bookingsBottom,
                _ => '',
              },
              style: switch (index) {
                0 => const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                _ => null,
              },
              textScaler: switch (index) {
                0 => const TextScaler.linear(1.05),
                _ => null,
              }),
          actions: [
            if (index == 0)
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SettingsView(),
                  ),
                ),
                child: const Icon(Icons.settings),
              ),
            if (index == 1)
              TextButton(
                onPressed: () => context
                    .read<BookingsBloc>()
                    .add(const BookingsEvent.update()),
                child: const Icon(Icons.replay),
              ),
          ],
          centerTitle: index == 1,
        ),
        body: IndexedStack(index: index, children: widget._pages),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const HallsView(),
            ),
          ),
          icon: const Icon(Icons.add),
          label: Text(AppLocalizations.of(context)!.newBooking),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppLocalizations.of(context)!.homeBottom,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.library_books),
              label: AppLocalizations.of(context)!.bookingsBottom,
            ),
          ],
        ),
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
