import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/features/booking/ui/desktop/screens/bookings.dart';
import 'package:open_edisu/features/booking/ui/desktop/screens/book.dart';
import 'package:open_edisu/features/home/ui/desktop/widgets/changelog_dialog.dart';
import 'package:open_edisu/features/home/ui/desktop/widgets/next_booking.dart';
import 'package:open_edisu/features/home/ui/desktop/widgets/chart.dart';
import 'package:open_edisu/features/home/ui/widgets/changelog_dialog.dart';

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
    showChangelogOnUpdate(context, ChangelogDialogDesktop.new);

    return BlocProvider(
      create: (context) => HallsBloc()..add(const HallsEvent.update()),
      child: BlocBuilder<HallsBloc, HallsState>(
        builder: (context, state) => NavigationView(
          appBar: NavigationAppBar(
            title: Text(
              AppLocalizations.of(context)!.openEdisu,
              style: const TextStyle(
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
                  loading: () => [
                        PaneItemHeader(
                          header: Text(AppLocalizations.of(context)!.loading),
                        ),
                      ],
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
