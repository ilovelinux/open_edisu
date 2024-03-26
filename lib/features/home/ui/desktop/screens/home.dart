import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/features/booking/ui/desktop/screens/bookings.dart';
import 'package:open_edisu/features/booking/ui/desktop/screens/book.dart';
import 'package:open_edisu/features/home/ui/desktop/widgets/next_booking.dart';
import 'package:open_edisu/features/home/ui/desktop/widgets/chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:open_edisu/features/halls/logic/halls_bloc.dart';
import 'package:open_edisu/features/settings/ui/desktop/screens/settings.dart';

class HomePageDesktop extends StatefulWidget {
  const HomePageDesktop({super.key});

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  var topIndex = 0;

  @override
  Widget build(BuildContext context) {
    _showChangelogOnUpdate(context);

    return BlocProvider(
      create: (context) => HallsBloc()..add(const HallsEvent.update()),
      child: BlocBuilder<HallsBloc, HallsState>(
        builder: (context, state) => NavigationView(
          appBar: const NavigationAppBar(
            title: Text(
              "Open Edisu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
          pane: NavigationPane(
            selected: topIndex,
            onChanged: (index) => setState(() => topIndex = index),
            items: [
              PaneItem(
                icon: const Icon(FluentIcons.home),
                title: Text(AppLocalizations.of(context)!.home),
                body: const HomeView(),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.book_answers),
                title: Text(AppLocalizations.of(context)!.bookings),
                body: const BookingsPage(),
              ),
              PaneItemSeparator(),
              PaneItemHeader(header: Text(AppLocalizations.of(context)!.halls)),
              ...state.when(
                  success: (halls, hallsMobile) => halls.map(
                        (e) => PaneItem(
                          icon: const Icon(FluentIcons.add_home),
                          title: Text(e.hname),
                          body: BookingPage(hall: e),
                        ),
                      ),
                  loading: () => [PaneItemHeader(header: Text('Loading'))],
                  error: (e) => [
                        PaneItemHeader(
                          header: Text(
                            kDebugMode
                                ? e
                                : AppLocalizations.of(context)!.genericError,
                          ),
                        ),
                      ]),
            ],
            footerItems: [
              PaneItem(
                icon: const Icon(FluentIcons.settings),
                title: const Text('Settings'),
                body: const SettingsView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(title: Text(AppLocalizations.of(context)!.welcomeTo)),
      children: const [
        NextBookingCard(),
        WeeklyStatisticsCard(),
        // HyperlinkButton(child: Text("Donate!"), onPressed: () {})
      ],
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
    builder: (context) => ContentDialog(
      title: Text(
        "${AppLocalizations.of(context)!.openEdisu} v${packageInfo.version}",
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
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              child: Text(AppLocalizations.of(context)!.dontshowagain),
              onPressed: () {
                SharedPreferences.getInstance().then(
                  (prefs) => prefs.setBool("showChangelog", false),
                );
                Navigator.pop(context);
              },
            ),
            FilledButton(
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
