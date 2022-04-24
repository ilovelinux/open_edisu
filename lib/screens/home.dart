import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../bloc/authentication_bloc.dart';
import '../bloc/halls_bloc.dart';
import '../cubit/page_cubit.dart';
import '../bloc/bookings_bloc.dart';
import '../models/edisu.dart';
import '../widgets/commons.dart';
import 'booking/booking.dart';

part 'home_tabs/home.dart';
part 'home_tabs/bookings.dart';
part 'home_tabs/new_booking.dart';
part 'home_tabs/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  final _titles = const [
    "OPEN EDISU",
    "PRENOTAZIONI",
    "NUOVA PRENOTAZIONE",
    if (kDebugMode) "IMPOSTAZIONI",
  ];

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
        builder: (context, index) {
          return Scaffold(
            appBar: AppBar(title: Text(_titles[index])),
            body: IndexedStack(
              index: index,
              children: _pages,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: index,
              onTap: (i) => context.read<PageCubit>().change(i),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  label: "Prenotazioni",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.plus_one),
                  label: "Nuova",
                ),
                if (kDebugMode)
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: "Impostazioni",
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
