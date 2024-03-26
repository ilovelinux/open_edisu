import 'package:collection/collection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/models/booking.dart';
import 'package:open_edisu/features/booking/ui/widgets/booking.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(
        title: Text(AppLocalizations.of(context)!.bookings),
        commandBar: IconButton(
          onPressed: () =>
              context.read<BookingsBloc>().add(const BookingsEvent.update()),
          icon: const Icon(FluentIcons.refresh, size: 20),
        ),
      ),
      content: _BookingViewBody(),
    );
  }
}

class _BookingViewBody extends StatelessWidget {
  const _BookingViewBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsBloc, BookingsState>(
      builder: (context, state) => state.when(
        success: (bookings) => BookingList(
          bookings: bookings.toList()..sortBy((a) => a.toDateTime()),
        ),
        loading: () => const LoadingWidget(),
        error: (e) => CenteredText(
          kDebugMode ? e : AppLocalizations.of(context)!.genericError,
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

    final bookingsByDate =
        groupBy(bookings, (Booking booking) => booking.date).entries.toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bookingsByDate.length,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        final b = bookingsByDate[index];
        return StickyHeader(
          header: Container(
            width: double.infinity,
            height: 50,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.transparent,
                  blurRadius: 1.0,
                  offset: Offset(0.0, 1.0),
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
            children: b.value.map((e) => BookingTicket(e)).toList(),
          ),
        );
      },
    );
  }
}
