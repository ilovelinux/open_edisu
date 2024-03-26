import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/ui/mobile/screens/bookings.dart';
import 'package:open_edisu/features/booking/ui/widgets/booking.dart';

class NextBookingCard extends StatelessWidget {
  const NextBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.nextBooking,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler: const TextScaler.linear(1.5),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 12.0),
            BlocBuilder<BookingsBloc, BookingsState>(
              builder: (context, state) => state.when(
                success: (bookings) {
                  final nextBooking = bookings
                      .where((element) => element.isUpcoming())
                      .sortedBy((element) => element.toDateTime())
                      .firstOrNull;

                  if (nextBooking == null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.noBookings,
                        ),
                      ),
                    );
                  }

                  return BookingTicket(nextBooking, minimal: true);
                },
                loading: () => const LoadingWidget(),
                error: (e) => CenteredText(
                  kDebugMode ? e : AppLocalizations.of(context)!.genericError,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            FilledButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BookingsPage(),
                ),
              ),
              child: Text(
                AppLocalizations.of(context)!.showAll,
              ),
            )
          ],
        ),
      ),
    );
  }
}
