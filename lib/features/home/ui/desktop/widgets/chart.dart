import 'package:collection/collection.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:open_edisu/core/widgets/commons.dart';
import 'package:open_edisu/features/booking/logic/bookings_bloc.dart';
import 'package:open_edisu/features/booking/models/booking.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WeeklyStatisticsCard extends StatelessWidget {
  const WeeklyStatisticsCard({super.key});

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
                child: IconButton(
                  onPressed: () => _showWeeklyStatisticsInfo(context),
                  icon: Icon(
                    FluentIcons.status_circle_question_mark,
                    size: 30,
                    color: Colors.red.light,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AspectRatio(
              aspectRatio: 4,
              child: BlocBuilder<BookingsBloc, BookingsState>(
                builder: (context, state) => state.when(
                  success: (bookings) => WeeklyChartbar(bookings),
                  loading: () => const LoadingWidget(),
                  error: (e) => CenteredText(
                    kDebugMode ? e : AppLocalizations.of(context)!.genericError,
                  ),
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
        builder: (BuildContext context) => ContentDialog(
          title: Text(AppLocalizations.of(context)!.weeklyStatisticsTitle),
          content:
              Text(AppLocalizations.of(context)!.weeklyStatisticsDescription),
          actions: [
            FilledButton(
              child: Text(
                AppLocalizations.of(context)!.weeklyStatisticsConfirm,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
}

class WeeklyChartbar extends StatelessWidget {
  final Bookings bookings;

  const WeeklyChartbar(this.bookings, {super.key});

  @override
  Widget build(BuildContext context) {
    final shortWeekDays =
        DateFormat.EEEE(Localizations.localeOf(context).toLanguageTag())
            .dateSymbols
            .SHORTWEEKDAYS;

    final bookingsPerWeekDay = groupBy(
      bookings, //.where((final e) => e.bookingStatus.isCompleted()),
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
