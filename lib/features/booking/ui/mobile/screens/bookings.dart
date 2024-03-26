import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:open_edisu/core/utilities/dio.dart';
import 'package:open_edisu/core/utilities/errors.dart';
import 'package:open_edisu/core/utilities/inceptor.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/models/booking.dart';
import 'package:open_edisu/features/booking/ui/mobile/widgets/booking.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.bookings),
        actions: [
          TextButton(
            onPressed: () =>
                context.read<BookingsBloc>().add(const BookingsEvent.update()),
            child: const Icon(Icons.replay),
          ),
        ],
        centerTitle: true,
      ),
      body: const _BookingViewBody(),
    );
  }
}

class _BookingViewBody extends StatelessWidget {
  const _BookingViewBody();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context)!.upcomingBookings),
                Tab(text: AppLocalizations.of(context)!.pastBookings),
              ],
            ),
          ),
          primary: false,
          automaticallyImplyLeading: false,
        ),
        body: BlocBuilder<BookingsBloc, BookingsState>(
          builder: (context, state) => state.when(
            success: (bookings) {
              List<Booking> upcoming = [];
              List<Booking> past = [];

              for (final booking in bookings) {
                if (booking.isUpcoming()) {
                  upcoming.add(booking);
                } else {
                  past.add(booking);
                }
              }

              upcoming.sortBy((a) => a.toDateTime());
              past.sortBy((a) => a.toDateTime());

              return TabBarView(
                children: [
                  BookingList(bookings: upcoming),
                  BookingList(bookings: past.reversed),
                ],
              );
            },
            loading: () => const LoadingWidget(),
            error: (e) => CenteredText(
              kDebugMode ? e : AppLocalizations.of(context)!.genericError,
            ),
          ),
        ),
      ),
    );
  }
}

class BookingList extends StatelessWidget {
  const BookingList({super.key, required this.bookings});

  final Bookings bookings;

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return CenteredText("${AppLocalizations.of(context)!.noBookings} :(");
    }

    final bookingsByDate = groupBy(bookings, (Booking booking) => booking.date);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
        child: Column(
          children: bookingsByDate.entries
              .map<Widget>(
                (b) => StickyHeader(
                  header: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.background,
                          blurRadius: 1.0,
                          offset: const Offset(0.0, -2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        DateFormat.yMMMMEEEEd(
                          Localizations.localeOf(context).toLanguageTag(),
                        ).format(b.key),
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: b.value
                          .map(
                            (e) => BookingTicket(
                              e,
                              dialogBuilder: _dialogBuilder,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void _dialogBuilder(BuildContext context, Booking booking) => AlertDialog(
        title: const Text("Delete booking"),
        content: const Text("Are you sure you wanna delete booking"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No, keep it"),
          ),
          TextButton(
            child: const Text("Yes, delete!"),
            onPressed: () => client
                .bookingCancel(booking.id)
                .then((_) => context
                    .read<BookingsBloc>()
                    .add(const BookingsEvent.update()))
                .catchError(
                    (e) => showErrorInDialog(context, getErrorString(e)))
                .whenComplete(() => Navigator.of(context).pop()),
          ),
        ],
        actionsAlignment: MainAxisAlignment.spaceBetween,
      );
}
