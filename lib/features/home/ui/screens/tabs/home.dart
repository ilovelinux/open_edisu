import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:open_edisu/features/booking/ui/screens/bookings.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/widgets/commons.dart';
import '../../../../booking/logic/bookings_bloc.dart';
import '../../../../booking/models/booking.dart';
import '../../../../booking/ui/widgets/booking.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _NextBookingCard(),
          _WeeklyStatisticsCard(),
        ],
      ),
    );
  }
}

class _NextBookingCard extends StatelessWidget {
  const _NextBookingCard();

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

                  return BookingTicket(nextBooking, showQrCode: false);
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
                  builder: (context) => const BookingsView(),
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

class _WeeklyStatisticsCard extends StatelessWidget {
  const _WeeklyStatisticsCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(AppLocalizations.of(context)!.weeklyStatisticsTitle),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => _showWeeklyStatisticsInfo(context),
                  child: Icon(
                    Icons.question_mark,
                    size: 14,
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(16.0),
            height: 150,
            child: BlocBuilder<BookingsBloc, BookingsState>(
              builder: (context, state) => state.when(
                success: (bookings) => _WeeklyChartbar(bookings),
                loading: () => const LoadingWidget(),
                error: (e) => CenteredText(
                  kDebugMode ? e : AppLocalizations.of(context)!.genericError,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showWeeklyStatisticsInfo(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.weeklyStatisticsTitle),
          content:
              Text(AppLocalizations.of(context)!.weeklyStatisticsDescription),
        ),
      );
}

class _WeeklyChartbar extends StatelessWidget {
  final Bookings bookings;

  const _WeeklyChartbar(this.bookings);

  @override
  Widget build(BuildContext context) {
    final shortWeekDays =
        DateFormat.EEEE(Localizations.localeOf(context).toLanguageTag())
            .dateSymbols
            .SHORTWEEKDAYS;

    final bookingsPerWeekDay = groupBy(
      bookings.where((final e) => e.bookingStatus.isCompleted()),
      (final Booking e) => e.date.weekday,
    );

    return Center(
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        primaryYAxis: const NumericAxis(interval: 1),
        series: <CartesianSeries>[
          ColumnSeries<String, String>(
            dataSource: shortWeekDays,
            xValueMapper: (String data, _) => data,
            yValueMapper: (_, int index) => bookingsPerWeekDay[index]?.length,
          )
        ],
      ),
    );
  }
}
