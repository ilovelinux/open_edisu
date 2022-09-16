import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../../../../../core/utilities/dio.dart';
import '../../../../../core/utilities/errors.dart';
import '../../../../../core/utilities/inceptor.dart';
import '../../../../../core/widgets/commons.dart';
import '../../../logic/bookings_bloc.dart';
import '../../../models/booking.dart';
import '../../widgets/booking.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsBloc, BookingsState>(
      builder: (context, state) => state.when(
        success: (bookings) => _BookingViewBody(bookings),
        loading: () => const LoadingWidget(),
        error: (e) => CenteredText(
          kDebugMode ? e : AppLocalizations.of(context)!.genericError,
        ),
      ),
    );
  }
}

class _BookingViewBody extends StatelessWidget {
  const _BookingViewBody(this.bookings);

  final Bookings bookings;

  @override
  Widget build(BuildContext context) {
    Bookings upcoming = [];
    Bookings past = [];

    for (final booking in bookings) {
      if (booking.isUpcoming()) {
        upcoming.add(booking);
      } else {
        past.add(booking);
      }
    }

    upcoming.sort((a, b) => a.toDateTime().compareTo(b.toDateTime()));
    past.sort((a, b) => b.toDateTime().compareTo(a.toDateTime()));

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          shadowColor: const Color(0x00FFFFFF),
          flexibleSpace: Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 10,
                ),
                insets: EdgeInsets.symmetric(horizontal: 40),
              ),
              tabs: [
                Tab(text: AppLocalizations.of(context)!.upcomingBookings),
                Tab(text: AppLocalizations.of(context)!.pastBookings),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            BookingList(bookings: upcoming),
            BookingList(bookings: past),
          ],
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
      child: Column(
        children: bookingsByDate.entries
            .map<Widget>(
              (b) => StickyHeader(
                header: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).bottomAppBarColor,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2.0,
                        offset: Offset(0.0, 2.0),
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
                content: Column(
                  children: b.value
                      .map(
                        (e) => BookingTicket(
                          e,
                          onTap: () => showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: context.read<BookingsBloc>(),
                              child: _BookingDialog(booking: e),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class BookingListTile extends StatelessWidget {
  const BookingListTile({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: booking.bookingStatus.isPending() ? Colors.amber : null,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(booking.seatNo)],
      ),
      title: Text(booking.hallName),
      subtitle: Text(
        [
          DateFormat.yMEd(Localizations.localeOf(context).toLanguageTag())
              .format(booking.date),
          if (kDebugMode) booking.bookingStatus.toString()
        ].join(" "),
      ),
      trailing: Text(booking.timeRange.format(context, " - ")),
      onTap: () => showDialog(
        context: context,
        builder: (_) => BlocProvider.value(
          value: context.read<BookingsBloc>(),
          child: _BookingDialog(booking: booking),
        ),
      ),
    );
  }
}

class _BookingDialog extends StatelessWidget {
  const _BookingDialog({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final qrCodeSize = deviceSize.width > deviceSize.height
        ? deviceSize.height * 0.6
        : deviceSize.width * 0.8;

    return AlertDialog(
      title: Text(
        [
          booking.hallName,
          booking.timeRange.format(context, " - "),
          DateFormat.yMd(
            Localizations.localeOf(context).toLanguageTag(),
          ).format(booking.date),
        ].join("\n"),
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, height: 1.2),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: qrCodeSize,
            height: qrCodeSize,
            child: QrImage(
              data: booking.bookingId.toUpperCase(),
            ),
          ),
          Text(
            booking.bookingId,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        if (booking.isUpcoming())
          TextButton(
            child: const Text("Cancella"),
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
    );
  }
}
