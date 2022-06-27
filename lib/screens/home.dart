import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/halls_bloc.dart';
import '../cubit/error_cubit.dart';
import '../bloc/bookings_bloc.dart';
import '../models/edisu.dart';
import '../utilities/inceptor.dart';
import '../widgets/commons.dart';
import 'booking/booking.dart';

part 'home_tabs/home.dart';
part 'home_tabs/bookings.dart';
part 'home_tabs/new_booking.dart';
part 'home_tabs/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  final _pages = const [
    _Home(),
    _BookingsView(),
    _HallsView(),
    if (kDebugMode) _SettingsView(),
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
          title: Text(AppLocalizations.of(context)!.homeTitles(index)),
          actions: [
            if (index == 1)
              TextButton(
                onPressed: () => context
                    .read<BookingsBloc>()
                    .add(const BookingsEvent.update()),
                child: const Icon(Icons.replay, color: Colors.white),
              ),
          ],
        ),
        body: IndexedStack(index: index, children: widget._pages),
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
            BottomNavigationBarItem(
              icon: const Icon(Icons.plus_one),
              label: AppLocalizations.of(context)!.newBookingBottom,
            ),
            if (kDebugMode)
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: AppLocalizations.of(context)!.settingsBottom,
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
