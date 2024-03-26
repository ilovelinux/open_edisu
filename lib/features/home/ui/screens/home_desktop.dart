import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/features/booking/ui/screens/book.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/widgets/commons.dart';
import '../../../halls/logic/halls_bloc.dart';
import '../../../settings/ui/screens/settings.dart';
import '../widgets/chart.dart';
import '../widgets/next_booking.dart';

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
          builder: (context, state) => state.when(
                success: (halls, hallsMobile) => NavigationView(
                  appBar: NavigationAppBar(
                    title: Text(
                      "Open Edisu",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                      textScaler: const TextScaler.linear(1.05),
                    ),
                    actions: IconButton(
                      onPressed: () => Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => const SettingsView(),
                        ),
                      ),
                      icon: const Icon(FluentIcons.settings),
                    ),
                  ),
                  pane: NavigationPane(
                    selected: topIndex,
                    onChanged: (index) => setState(() => topIndex = index),
                    items: [
                      PaneItem(
                        icon: const Icon(FluentIcons.home),
                        title: const Text('Home'),
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
                      ),
                      PaneItemSeparator(),
                      PaneItemHeader(header: Text("Halls")),
                      ...halls.map(
                        (e) => PaneItem(
                          icon: const Icon(FluentIcons.add_home),
                          title: Text(e.hname),
                          body: BookingView(hall: e),
                        ),
                      ),
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
                loading: () => const ProgressRing(),
                error: (e) => CenteredText(
                  kDebugMode ? e : AppLocalizations.of(context)!.genericError,
                ),
              )),
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
