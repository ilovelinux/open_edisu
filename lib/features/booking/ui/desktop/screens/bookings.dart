import 'package:collection/collection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:open_edisu/core/utilities/dio.dart';
import 'package:open_edisu/core/utilities/inceptor.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/models/booking.dart';
import 'package:open_edisu/features/booking/ui/desktop/widgets/booking.dart';
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
      content: const _BookingViewBody(),
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
      itemBuilder: (context, index) {
        final b = bookingsByDate[index];
        return StickyHeader(
          header: Acrylic(
            child: SizedBox(
              width: double.infinity,
              height: 60,
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
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: b.value
                  .map((e) => BookingTicket(e, dialogBuilder: _dialogBuilder))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  void _dialogBuilder(BuildContext context, Booking booking) => ContentDialog(
        title: const Text("Delete booking"),
        content: const Text("Are you sure you wanna delete booking"),
        actions: [
          FilledButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No, keep it"),
          ),
          Button(
            child: const Text("Yes, delete!"),
            onPressed: () => client
                .bookingCancel(booking.id)
                .then((_) => context
                    .read<BookingsBloc>()
                    .add(const BookingsEvent.update()))
                .catchError(
                  (e) => displayInfoBar(context, builder: (context, close) {
                    return InfoBar(
                      title: const Text('Error'),
                      content: Text(getErrorString(e)),
                      action: IconButton(
                        icon: const Icon(FluentIcons.clear),
                        onPressed: close,
                      ),
                      severity: InfoBarSeverity.error,
                    );
                  }),
                )
                .whenComplete(() => Navigator.of(context).pop()),
          ),
        ],
      );
}
