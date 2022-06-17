import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:open_edisu/screens/settings/account.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/halls_bloc.dart';
import '../cubit/error_cubit.dart';
import '../cubit/page_cubit.dart';
import '../bloc/bookings_bloc.dart';
import '../models/edisu.dart';
import '../utilities/inceptor.dart';
import '../widgets/commons.dart';
import 'booking/booking.dart';

part 'home_tabs/home.dart';
part 'home_tabs/bookings.dart';
part 'home_tabs/new_booking.dart';
part 'home_tabs/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final _pages = const [
    _Home(),
    _BookingsView(),
    _HallsView(),
    if (kDebugMode) _SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageCubit()),
        BlocProvider(
          create: (_) => BookingsBloc()..add(const BookingsEvent.update()),
        ),
      ],
      child: BlocBuilder<PageCubit, int>(
        builder: (context, index) => Scaffold(
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
          body: IndexedStack(index: index, children: _pages),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: index,
            onTap: (i) => context.read<PageCubit>().change(i),
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
      ),
    );
  }
}
