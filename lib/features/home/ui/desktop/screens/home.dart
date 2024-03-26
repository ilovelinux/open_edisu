import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/features/auth/logic/auth_bloc.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/ui/desktop/screens/bookings.dart';
import 'package:open_edisu/features/booking/ui/desktop/screens/book.dart';
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
                title: const Text('Home'),
                body: ScaffoldPage(
                  header: PageHeader(
                    title: Text(
                      "Welcome to Open Edisu!",
                    ),
                  ),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Fetching data..."),
                      SizedBox(height: 20),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 30.0,
                                ),
                                child: Icon(
                                  FluentIcons.accounts,
                                  size: 50,
                                ),
                              ),
                              Text("User info"),
                              Center(
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  builder: (_, state) => state.when(
                                      authenticated: (_) => FilledButton(
                                            child: Text("Ok!"),
                                            onPressed: () {},
                                          ),
                                      unauthenticated: (_, __, ___) =>
                                          FilledButton(
                                            child: Text("Error!"),
                                            onPressed: () {},
                                          ),
                                      unknown: () => const ProgressRing()),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 30.0,
                                ),
                                child: Icon(
                                  FluentIcons.bookmarks,
                                  size: 50,
                                ),
                              ),
                              Text("Bookings"),
                              BlocBuilder<BookingsBloc, BookingsState>(
                                builder: (_, state) => state.when(
                                    success: (_) => FilledButton(
                                          child: Text("Ok!"),
                                          onPressed: () {},
                                        ),
                                    error: (_) => FilledButton(
                                          child: Text("Error!"),
                                          onPressed: () {},
                                        ),
                                    loading: () => const ProgressRing()),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 20.0,
                                  horizontal: 30.0,
                                ),
                                child: Icon(
                                  FluentIcons.home,
                                  size: 50,
                                ),
                              ),
                              Text("Halls"),
                              BlocBuilder<HallsBloc, HallsState>(
                                builder: (_, state) => state.when(
                                    success: (_, __) => FilledButton(
                                          child: Text("Ok!"),
                                          onPressed: () {},
                                        ),
                                    error: (_) => FilledButton(
                                          child: Text("Error!"),
                                          onPressed: () {},
                                        ),
                                    loading: () => const ProgressRing()),
                              )
                            ],
                          ),
                        ],
                      ),
                      HyperlinkButton(child: Text("Donate!"), onPressed: () {})
                    ],
                  ),
                ),
              ),
              PaneItem(
                icon: const Icon(FluentIcons.book_answers),
                title: const Text("Bookings"),
                body: const BookingsPage(),
              ),
              PaneItemSeparator(),
              PaneItemHeader(header: Text("Halls")),
              ...state.when(
                  success: (halls, hallsMobile) => halls.map(
                        (e) => PaneItem(
                          icon: const Icon(FluentIcons.add_home),
                          title: Text(e.hname),
                          body: BookingView(hall: e),
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
