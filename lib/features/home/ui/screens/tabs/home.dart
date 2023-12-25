import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../core/widgets/commons.dart';
import '../../../../auth/logic/auth_bloc.dart';
import '../../../../auth/models/user.dart';
import '../../../../auth/ui/widgets/logout_dialog.dart';
import '../../../../booking/logic/bookings_bloc.dart';
import '../../../../booking/models/booking.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _UserCard(),
          _WeeklyStatisticsCard(),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard();

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I<User>();

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext c) => BlocProvider.value(
            value: context.read<AuthBloc>(),
            child: const LogoutDialog(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text(
            AppLocalizations.of(context)!.welcome(user.name, user.surname),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
          ),
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
        primaryXAxis: CategoryAxis(),
        primaryYAxis: NumericAxis(interval: 1),
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
