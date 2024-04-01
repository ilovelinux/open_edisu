import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:open_edisu/features/auth/models/user.dart';
import 'package:open_edisu/features/halls/ui/mobile/screens/halls.dart';
import 'package:open_edisu/features/home/ui/mobile/widgets/changelog_dialog.dart';
import 'package:open_edisu/features/home/ui/mobile/widgets/chart.dart';
import 'package:open_edisu/features/home/ui/mobile/widgets/next_booking.dart';
import 'package:open_edisu/features/home/ui/widgets/changelog_dialog.dart';
import 'package:open_edisu/features/settings/ui/mobile/screens/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    showChangelogOnUpdate(context, ChangelogDialogMobile.new);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.welcome(GetIt.I<User>().name),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
          textScaler: const TextScaler.linear(1.05),
        ),
        actions: [
          TextButton(
            onPressed: () => _openSettings(context),
            child: const Icon(Icons.settings),
          ),
        ],
      ),
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
        onPressed: () => _openHalls(context),
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context)!.newBooking),
      ),
    );
  }

  void _openSettings(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const SettingsView(),
        ),
      );

  void _openHalls(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const HallsPage(),
        ),
      );
}
